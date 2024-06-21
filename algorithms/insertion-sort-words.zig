const std = @import("std");

fn insertionSort(arr: [][]const u8) void {
    const n = arr.len;
    var i: usize = 1;
    while (i < n) {
        const key = arr[i];
        var j: isize = i - 1;
        while (j >= 0 and std.mem.compare(key, arr[@intCast(usize, j)]) < 0) {
            arr[@intCast(usize, j + 1)] = arr[@intCast(usize, j)];
            j -= 1;
        }
        arr[@intCast(usize, j + 1)] = key;
        i += 1;
    }
}

pub fn main() void {
    var array = [_][]const u8{"peach", "banana", "apple", "cherry", "date", "fig", "grape"};

    insertionSort(array[0..]);

    for (array) |word| {
        std.debug.print("{s}\n", .{word});
    }
}
