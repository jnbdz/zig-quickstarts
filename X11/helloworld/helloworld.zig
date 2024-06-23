const std = @import("std");
const x11 = @cImport({
    @cInclude("X11/Xlib.h");
    @cInclude("X11/Xutil.h");
});

pub fn main() void {
    // Open a connection to the X server
    const display = x11.XOpenDisplay(null);
    if (display == null) {
        std.debug.print("Cannot open display\n", .{});
        return;
    }

    // Get the default screen of the display
    const screen_num = x11.XDefaultScreen(display);

    // Create a simple window
    const win = x11.XCreateSimpleWindow(
        display,
        x11.XRootWindow(display, screen_num),
        10, 10, 800, 600, 1,
        x11.XBlackPixel(display, screen_num),
        x11.XWhitePixel(display, screen_num),
    );

    // Select kind of events we are interested in
    _ = x11.XSelectInput(display, win, x11.ExposureMask | x11.KeyPressMask);

    // Map (show) the window
    _ = x11.XMapWindow(display, win);

    var event: x11.XEvent = undefined;

    while (true) {
        _ = x11.XNextEvent(display, &event);

        if (event.type == x11.Expose) {
            const gc = x11.XCreateGC(display, win, 0, null);
            _ = x11.XSetForeground(display, gc, x11.XBlackPixel(display, screen_num));
            _ = x11.XDrawString(
                display,
                win,
                gc,
                50, 50,
                "Hello, World!".ptr,
                13, // Length of the string
            );
            _ = x11.XFreeGC(display, gc);
        }

        if (event.type == x11.KeyPress) {
            break;
        }
    }

    // Close the display
    _ = x11.XCloseDisplay(display);
}
