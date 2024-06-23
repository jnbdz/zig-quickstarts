const std = @import("std");

fn heapify(arr: [][]const u8, n: usize, i: usize) void {
    var largest = i;
    const l = 2 * i + 1;
    const r = 2 * i + 2;

    if (l < n and std.mem.lessThan(u8, arr[largest], arr[l])) {
        largest = l;
    }

    if (r < n and std.mem.lessThan(u8, arr[largest], arr[r])) {
        largest = r;
    }

    if (largest != i) {
        const swap = arr[i];
        arr[i] = arr[largest];
        arr[largest] = swap;

        heapify(arr, n, largest);
    }
}

fn heapSort(arr: [][]const u8) void {
    const n = arr.len;

    var i: isize = @intCast(isize, n / 2 - 1);
    while (i >= 0) {
        heapify(arr, n, @intCast(usize, i));
        i -= 1;
    }

    var j: isize = @intCast(isize, n - 1);
    while (j >= 0) {
        const temp = arr[0];
        arr[0] = arr[@intCast(usize, j)];
        arr[@intCast(usize, j)] = temp;

        heapify(arr, @intCast(usize, j), 0);
        j -= 1;
    }
}

pub fn main() void {
    var array = [_][]const u8{"peach", "banana", "apple", "cherry", "date", "fig", "grape"};

    heapSort(array[0..]);

    for (array) |word| {
        std.debug.print("{s}\n", .{word});
    }
}
