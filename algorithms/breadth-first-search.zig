const std = @import("std");

fn bfs(graph: [][]const usize, start: usize) void {
    var visited = std.ArrayList(bool).init(std.heap.page_allocator);
    visited.ensureTotalCapacity(graph.len) catch unreachable;
    for (graph) |_| {
        visited.append(false) catch unreachable;
    }

    var queue = std.ArrayList(usize).init(std.heap.page_allocator);
    queue.append(start) catch unreachable;
    visited.items[start] = true;

    while (queue.len > 0) {
        const node = queue.pop();
        std.debug.print("Visited node {d}\n", .{node});
        for (graph[node]) |neighbor| {
            if (!visited.items[neighbor]) {
                queue.append(neighbor) catch unreachable;
                visited.items[neighbor] = true;
            }
        }
    }
}

pub fn main() void {
    const graph = [_][]const usize{
        &[_]usize{1, 2},  // Node 0 is connected to 1 and 2
        &[_]usize{0, 3},  // Node 1 is connected to 0 and 3
        &[_]usize{0, 4},  // Node 2 is connected to 0 and 4
        &[_]usize{1},     // Node 3 is connected to 1
        &[_]usize{2},     // Node 4 is connected to 2
    };

    bfs(&graph, 0);
}
