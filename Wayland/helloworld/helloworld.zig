const std = @import("std");
const wayland = @cImport({
    @cInclude("wayland-client.h");
});

const wl_registry_listener = wayland.wl_registry_listener{
    .global = registry_handler,
    .global_remove = registry_remover,
};

const wl_shell_surface_listener = wayland.wl_shell_surface_listener{
    .ping = shell_surface_ping,
    .configure = shell_surface_configure,
    .popup_done = shell_surface_popup_done,
};

var compositor: ?*wayland.wl_compositor = null;
var shell: ?*wayland.wl_shell = null;

fn registry_handler(_: ?*anyopaque, registry: *wayland.wl_registry, id: u32, interface: [*c]const u8, _: u32) callconv(.C) void {
    if (std.mem.eql(u8, interface, "wl_compositor")) {
        compositor = @ptrCast(*wayland.wl_compositor, wayland.wl_registry_bind(registry, id, &wayland.wl_compositor_interface, 1));
    } else if (std.mem.eql(u8, interface, "wl_shell")) {
        shell = @ptrCast(*wayland.wl_shell, wayland.wl_registry_bind(registry, id, &wayland.wl_shell_interface, 1));
    }
}

fn registry_remover(_: ?*anyopaque, _: *wayland.wl_registry, id: u32) callconv(.C) void {
    std.debug.print("Registry object removed: {}\n", .{id});
}

fn shell_surface_ping(_: ?*anyopaque, shell_surface: *wayland.wl_shell_surface, serial: u32) callconv(.C) void {
    wayland.wl_shell_surface_pong(shell_surface, serial);
}

fn shell_surface_configure(_: ?*anyopaque, _: *wayland.wl_shell_surface, _: u32, width: i32, height: i32) callconv(.C) void {
    std.debug.print("Shell surface configured: {}x{}\n", .{width, height});
    // Handle resizing or other configuration changes here if needed
}

fn shell_surface_popup_done(_: ?*anyopaque, _: *wayland.wl_shell_surface) callconv(.C) void {
    std.debug.print("Popup done\n", .{});
}

pub fn main() void {
    // Connect to Wayland display server
    const display = wayland.wl_display_connect(null);
    if (display == null) {
        std.debug.print("Cannot connect to Wayland display\n", .{});
        return;
    }

    // Get the Wayland registry
    const registry = wayland.wl_display_get_registry(display);
    _ = wayland.wl_registry_add_listener(registry, &wl_registry_listener, null);

    // Round-trip the display to process the registry events
    wayland.wl_display_roundtrip(display);

    if (compositor == null or shell == null) {
        std.debug.print("Required Wayland interfaces not available\n", .{});
        wayland.wl_display_disconnect(display);
        return;
    }

    // Create a surface
    const surface = wayland.wl_compositor_create_surface(compositor);
    if (surface == null) {
        std.debug.print("Cannot create Wayland surface\n", .{});
        wayland.wl_display_disconnect(display);
        return;
    }

    // Create a shell surface
    const shell_surface = wayland.wl_shell_get_shell_surface(shell, surface);
    if (shell_surface == null) {
        std.debug.print("Cannot create Wayland shell surface\n", .{});
        wayland.wl_display_disconnect(display);
        return;
    }

    _ = wayland.wl_shell_surface_add_listener(shell_surface, &wl_shell_surface_listener, null);

    // Set the shell surface to toplevel
    wayland.wl_shell_surface_set_toplevel(shell_surface);

    // Main event loop
    while (true) {
        const ret = wayland.wl_display_dispatch(display);
        if (ret == -1) {
            break;
        }
    }

    // Cleanup
    _ = wayland.wl_display_disconnect(display);
}
