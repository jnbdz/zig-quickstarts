const std = @import("std");

var hello: [6]u8 = [_]u8{'H', 'e', 'l', 'l', 'o', 0}; // Explicitly include the null terminator

const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

pub fn main() !void {
    hello[0] = 'h'; // This changes 'H' to 'h'

    std.debug.print("{s}, {s}. a: {s}, b: {s}, 1: {s}, 2: {s}, 3: {s}, 4: {s}, Length: {d}!\n", 
       .{hello, "World", a, b, hello[0..5], hello[1..5], hello[0..4], hello[1..2], hello[2..5].len});
}
