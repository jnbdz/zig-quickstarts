const std = @import("std");

fn binarySearch(arr: []const i32, target: i32) ?usize {
    var left: usize = 0;
    var right: usize = arr.len - 1;

    while (left <= right) {
        const mid = left + (right - left) / 2;

        if (arr[mid] == target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return null;
}

pub fn main() void {
    const array = [_]i32{1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    const target = 13;

    const result = binarySearch(array[0..], target);
    if (result != null) {
        std.debug.print("Found at index: {}\n", .{result.?});
    } else {
        std.debug.print("Not found\n", .{});
    }
}
