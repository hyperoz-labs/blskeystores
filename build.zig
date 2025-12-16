const std = @import("std");

pub fn build(b: *std.Build) void {
    // Standard target options
    const target = b.standardTargetOptions(.{});
    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const optimize = b.standardOptimizeOption(.{});

    // primary module that will be exposed to users and the cli
    const primary_mod = b.addModule("blskeystore", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });

    // primary cli executeable
    const exe = b.addExecutable(.{
        .name = "blskeystore",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            // List of modules available for import in source file
            .imports = &.{
                .{ .name = "blskeystore", .module = primary_mod },
            },
        }),
    });

    // zig build [-p install_dir] would install primary cli executeable
    b.installArtifact(exe);

    // ---------------------------------------------------------- //
    // helpful custom `zig build <option>` commands
    // ---------------------------------------------------------- //

    // zig build run -- arg1 arg2 ...
    const run_cli_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_cli_exe.step);
    if (b.args) |args| {
        run_cli_exe.addArgs(args);
    }

    // `zig build run` depends on install step to allow running from install directory
    run_cli_exe.step.dependOn(b.getInstallStep());

    // zig build test
    const test_step = b.step("test", "Run tests");

    // primary module test executeable
    const primary_mod_tests = b.addTest(.{
        .root_module = primary_mod,
    });

    // run step for primary module test executeable.
    const run_primary_mod_tests = b.addRunArtifact(primary_mod_tests);

    // cli exe test executeable
    const cli_exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });

    // run step for cli test executeable.
    const run_cli_exe_tests = b.addRunArtifact(cli_exe_tests);

    // the `zig build test` step depends on test exec run steps
    test_step.dependOn(&run_primary_mod_tests.step);
    test_step.dependOn(&run_cli_exe_tests.step);
}
