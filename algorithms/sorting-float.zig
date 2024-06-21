const std = @import("std");

fn quicksortFloat(arr: []f64, left: usize, right: usize) void {
    if (left < right) {
        const pivotIndex = partitionFloat(arr, left, right);
        if (pivotIndex > 0) quicksortFloat(arr, left, pivotIndex - 1);
        quicksortFloat(arr, pivotIndex + 1, right);
    }
}

fn partitionFloat(arr: []f64, left: usize, right: usize) usize {
    const pivot = arr[right];
    var i: usize = left;

    var j: usize = left;
    while (j < right) : (j += 1) {
        if (arr[j] < pivot) {
            const temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            i += 1;
        }
    }
    const temp = arr[i];
    arr[i] = arr[right];
    arr[right] = temp;
    return i;
}

pub fn main() !void {
    var array = [_]f64{29.5, 10.1, 14.2, 37.8, 13.3, 22.7, 17.6, 8.9, 1.4, 9.5, 19.8, 45.3, 30.2, 18.1, 15.7, 5.5, 7.6, 28.3, 12.4, 16.9};

    quicksortFloat(array[0..], 0, array.len - 1);

    var stdout = std.io.getStdOut().writer();
    for (array) |num| {
        try stdout.print("{:.2}\n", .{num});
    }
}
