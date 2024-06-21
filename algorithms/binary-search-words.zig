const std = @import("std");

fn binarySearch(arr: []const []const u8, target: []const u8) ?usize {
    var left: usize = 0;
    var right: usize = arr.len - 1;

    while (left <= right) {
        const mid = left + (right - left) / 2;
        const midValue = arr[mid];

        if (std.mem.eql(u8, midValue, target)) {
            return mid;
        } else if (std.mem.lessThan(u8, midValue, target)) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return null;
}

pub fn main() void {
    const array = [_][]const u8{"apple", "banana", "cherry", "date", "fig", "grape", "kiwi"};
    const target = "date";

    const result = binarySearch(array[0..], target);
    if (result != null) {
        std.debug.print("Found at index: {}\n", .{result.?});
    } else {
        std.debug.print("Not found\n", .{});
    }
}
