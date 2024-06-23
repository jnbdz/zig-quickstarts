const std = @import("std");

fn selectionSort(arr: [][]const u8) void {
    const n = arr.len;
    var i: usize = 0;
    while (i < n - 1) {
        var minIdx = i;
        var j: usize = i + 1;
        while (j < n) {
            if (std.mem.lessThan(u8, arr[j], arr[minIdx])) {
                minIdx = j;
            }
            j += 1;
        }
        if (minIdx != i) {
            const temp = arr[i];
            arr[i] = arr[minIdx];
            arr[minIdx] = temp;
        }
        i += 1;
    }
}

pub fn main() void {
    var array = [_][]const u8{"peach", "banana", "apple", "cherry", "date", "fig", "grape"};

    selectionSort(array[0..]);

    for (array) |word| {
        std.debug.print("{s}\n", .{word});
    }
}
