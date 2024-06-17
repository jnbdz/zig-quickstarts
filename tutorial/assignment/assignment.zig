const std = @import("std");

const constant: i32 = 5; // signed 32-bit constant
var variable: u32 = 5000; // unsigned 32-bit variable

// @as performs an explicit type coercion
const inferred_constant = @as(i32, 5);
var inferred_variable = @as(u32, 5000);

const a: i32 = undefined;
var b: u32 = undefined;

const hello: []const u8 = "Hello";

pub fn main() !void {
    std.debug.print("{s}, {s}. constant: {d}, variable: {d}, inferred_constant: {d}, inferred_variable: {d}, a: {d}, b: {d}!\n", 
       .{hello, "World", constant, variable, inferred_constant, inferred_variable, a, b});
}
