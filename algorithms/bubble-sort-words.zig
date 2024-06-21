const std = @import("std");

fn bubbleSort(arr: [][]const u8) void {
    const n = arr.len;
    var swapped: bool = true;
    while (swapped) {
        swapped = false;
        var i: usize = 0;
        while (i < n - 1) {
            if (std.mem.lessThan(u8, arr[i + 1], arr[i])) {
                const temp = arr[i];
                arr[i] = arr[i + 1];
                arr[i + 1] = temp;
                swapped = true;
            }
            i += 1;
        }
    }
}

pub fn main() void {
    var array = [_][]const u8{"peach", "banana", "apple", "cherry", "date", "fig", "grape"};

    bubbleSort(array[0..]);

    for (array) |word| {
        std.debug.print("{s}\n", .{word});
    }
}
