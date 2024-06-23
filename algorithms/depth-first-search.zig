const std = @import("std");

fn dfs(graph: [][]usize, start: usize, visited: []bool) void {
    if (visited[start]) return;
    visited[start] = true;
    std.debug.print("Visited node {d}\n", .{start});

    for (graph[start]) |neighbor| {
        dfs(graph, neighbor, visited);
    }
}

pub fn main() void {
    const graph = [][]usize{
        &[1, 2],  // Node 0 is connected to 1 and 2
        &[0, 3],  // Node 1 is connected to 0 and 3
        &[0, 4],  // Node 2 is connected to 0 and 4
        &[1],     // Node 3 is connected to 1
        &[2],     // Node 4 is connected to 2
    };
    var visited = [_]bool{false, false, false, false, false};

    dfs(graph, 0, &visited);
}
