const std = @import("std");

const Node = struct {
    value: []const u8,
    left: ?*Node,
    right: ?*Node,
};

const BinaryTree = struct {
    root: ?*Node,
    allocator: *std.mem.Allocator,

    pub fn init(allocator: *std.mem.Allocator) BinaryTree {
        return BinaryTree{
            .root = null,
            .allocator = allocator,
        };
    }

    pub fn insert(self: *BinaryTree, value: []const u8) !void {
        if (self.root == null) {
            self.root = try self.allocator.create(Node);
            self.root.?.* = Node{
                .value = value,
                .left = null,
                .right = null,
            };
        } else {
            try self.insertNode(self.root.?, value);
        }
    }

    fn insertNode(self: *BinaryTree, node: *Node, value: []const u8) !void {
        if (std.mem.lessThan(u8, value, node.value)) {
            if (node.left == null) {
                node.left = try self.allocator.create(Node);
                node.left.?.* = Node{
                    .value = value,
                    .left = null,
                    .right = null,
                };
            } else {
                try self.insertNode(node.left.?, value);
            }
        } else {
            if (node.right == null) {
                node.right = try self.allocator.create(Node);
                node.right.?.* = Node{
                    .value = value,
                    .left = null,
                    .right = null,
                };
            } else {
                try self.insertNode(node.right.?, value);
            }
        }
    }

    pub fn inOrderTraversal(self: *BinaryTree) void {
        if (self.root != null) {
            self.inOrderTraversalNode(self.root.?);
        }
    }

    fn inOrderTraversalNode(self: *BinaryTree, node: *Node) void {
        if (node.left != null) {
            self.inOrderTraversalNode(node.left.?);
        }
        std.debug.print("{s}\n", .{node.value});
        if (node.right != null) {
            self.inOrderTraversalNode(node.right.?);
        }
    }

    pub fn deinit(self: *BinaryTree) void {
        if (self.root != null) {
            self.deinitNode(self.root.?);
            self.root = null;
        }
    }

    fn deinitNode(self: *BinaryTree, node: *Node) void {
        if (node.left != null) {
            self.deinitNode(node.left.?);
        }
        if (node.right != null) {
            self.deinitNode(node.right.?);
        }
        self.allocator.destroy(node);
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const check = gpa.deinit();
        std.debug.assert(check == .ok);
    }
    var allocator = gpa.allocator();

    var tree = BinaryTree.init(&allocator);
    defer tree.deinit();

    try tree.insert("peach");
    try tree.insert("banana");
    try tree.insert("apple");
    try tree.insert("cherry");
    try tree.insert("date");
    try tree.insert("fig");
    try tree.insert("grape");

    tree.inOrderTraversal();
}
