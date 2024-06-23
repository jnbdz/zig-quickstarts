const std = @import("std");

fn mergeSort(arr: [][]const u8) void {
    if (arr.len <= 1) return;

    const mid = arr.len / 2;
    const left = arr[0..mid];
    const right = arr[mid..];

    mergeSort(left);
    mergeSort(right);

    merge(arr, left, right);
}

fn merge(arr: [][]const u8, left: [][]const u8, right: [][]const u8) void {
    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;

    while (i < left.len and j < right.len) {
        if (std.mem.lessThan(u8, left[i], right[j])) {
            arr[k] = left[i];
            i += 1;
        } else {
            arr[k] = right[j];
            j += 1;
        }
        k += 1;
    }

    while (i < left.len) {
        arr[k] = left[i];
        i += 1;
        k += 1;
    }

    while (j < right.len) {
        arr[k] = right[j];
        j += 1;
        k += 1;
    }
}

pub fn main() void {
    var array = [_][]const u8{"peach", "banana", "apple", "cherry", "date", "fig", "grape"};

    mergeSort(array[0..]);

    for (array) |word| {
        std.debug.print("{s}\n", .{word});
    }
}
