const std = @import("std");

fn quicksort(arr: [][]const u8, left: usize, right: usize) void {
    if (left < right) {
        const pivotIndex = partition(arr, left, right);
        if (pivotIndex > 0) quicksort(arr, left, pivotIndex - 1);
        quicksort(arr, pivotIndex + 1, right);
    }
}

fn partition(arr: [][]const u8, left: usize, right: usize) usize {
    const pivot = arr[right];
    var i: usize = left;

    var j: usize = left;
    while (j < right) : (j += 1) {
        if (std.mem.lessThan(u8, arr[j], pivot)) {
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
    var array = [_][]const u8{
        "peach", "banana", "apple", "cherry", "date", "fig", "grape", "kiwi",
        "lemon", "mango", "nectarine", "orange", "papaya", "quince", "raspberry",
        "strawberry", "tangerine", "ugli", "watermelon", "blueberry"
    };

    quicksort(array[0..], 0, array.len - 1);

    for (array) |word| {
        std.debug.print("{s}\n", .{word});
    }
}
