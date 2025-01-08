const std = @import("std");
const expect = @import("std").testing.expect;
const os = std.os;

const Module = struct {
    const EXERCISES_FOLDER: []u8 = "../exercises/";
    const INPUT_FOLDER: []u8 = "../input/";

    path: []const u8,

    pub fn init(module_name: []u8) Module {
        return .{ .path = INPUT_FOLDER ++ module_name };
    }

    pub fn name(self: Module) []const u8 {
        return std.fs.path.stem(self.path);
    }

    pub fn inputFile(self: Module) *const []u8 {
        return @embedFile(self.path);
    }

    fn build(self: *Module) !void {}
};

const Kind = enum {
    /// Run the artifact as a normal executable.
    exe,
    /// Run the artifact as a test.
    @"test",
};

pub const Exercise = struct {
    /// main_file must have the format key_name.zig.
    /// The key will be used as a shorthand to build just one example.
    main_file: []const u8,

    /// This is the desired output of the program.
    /// A program passes if its output, excluding trailing whitespace, is equal
    /// to this string.
    output: []const u8,

    /// This is an optional hint to give if the program does not succeed.
    hint: ?[]const u8 = null,

    /// By default, we verify output against stderr.
    /// Set this to true to check stdout instead.
    check_stdout: bool = false,

    /// This exercise makes use of C functions.
    /// We need to keep track of this, so we compile with libc.
    link_libc: bool = false,

    /// This exercise ki
    kind: Kind = .exe,

    /// This exercise is not supported by the current Zig compiler.
    skip: bool = false,

    /// Returns the name of the main file with .zig stripped.
    pub fn name(self: Exercise) []const u8 {
        return std.fs.path.stem(self.main_file);
    }

    /// Returns the key of the main file, the string before the '_' with
    /// "zero padding" removed.
    /// For example, "001_hello.zig" has the key "1".
    pub fn key(self: Exercise) []const u8 {
        // Main file must be key_description.zig.
        const end_index = std.mem.indexOfScalar(u8, self.main_file, '_') orelse
            unreachable;

        // Remove zero padding by advancing index past '0's.
        var start_index: usize = 0;
        while (self.main_file[start_index] == '0') start_index += 1;
        return self.main_file[start_index..end_index];
    }

    /// Returns the exercise key as an integer.
    pub fn number(self: Exercise) usize {
        return std.fmt.parseInt(usize, self.key(), 10) catch unreachable;
    }
};

pub fn main() !void {}
