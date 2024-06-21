const std = @import("std");

fn quicksort(arr: []i32, left: usize, right: usize) void {
    if (left < right) {
        const pivotIndex = partition(arr, left, right);
        if (pivotIndex > 0) quicksort(arr, left, pivotIndex - 1);
        quicksort(arr, pivotIndex + 1, right);
    }
}

fn partition(arr: []i32, left: usize, right: usize) usize {
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

pub fn main() void {
    var array = [_]i32{29, 10, 14, 37, 13, 22, 17, 8, 1, 9, 19, 45, 30, 18, 15, 5, 7, 28, 12, 16};

    quicksort(array[0..], 0, array.len - 1);

    for (array) |num| {
        std.debug.print("{}\n", .{num});
    }
}
