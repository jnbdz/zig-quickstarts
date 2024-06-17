const std = @import("std");

// Won't run unless you put it in a function
//const b = false;
//var y: u16 = 4;
//if (b) {
//    y += 10;
//} else {
//    y += 11;
//}

pub fn main() !void {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
        std.debug.print("a is true!\n", .{});
    } else {
        x += 2;
    }
    std.debug.print("x: {d}!\n", .{x});
}
