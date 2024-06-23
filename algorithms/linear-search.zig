const std = @import("std");

fn linearSearch(arr: [][]const u8, target: []const u8) ?usize {
    var i: usize = 0;
    while (i < arr.len) {
        if (std.mem.eql(u8, arr[i], target)) {
            return i;
        }
        i += 1;
    }
    return null;
}

pub fn main() void {
    var array = [_][]const u8{"peach", "banana", "apple", "cherry", "date", "fig", "grape"};
    const target = "cherry";

    const index = linearSearch(array[0..], target);
    if (index) |i| {
        std.debug.print("Found {s} at index {d}\n", .{target, i});
    } else {
        std.debug.print("{s} not found\n", .{target});
    }
}
