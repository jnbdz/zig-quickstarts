const std = @import("std");

fn bubbleSort(arr: []i32) void {
    const n = arr.len;
    var swapped: bool = true;
    while (swapped) {
        swapped = false;
        var i: usize = 0;
        while (i < n - 1) {
            if (arr[i] > arr[i + 1]) {
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
    var array = [_]i32{29, 10, 14, 37, 13, 22, 17, 8, 1, 9, 19, 45, 30, 18, 15, 5, 7, 28, 12, 16};

    bubbleSort(array[0..]);

    for (array) |num| {
        std.debug.print("{}\n", .{num});
    }
}
