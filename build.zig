const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Configure module
    const root = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    root.addIncludePath(b.path("include"));
    root.addIncludePath(b.path("src"));
    root.addCMacro("USE_STBIMAGE", "");
    root.addCMacro("LOAD_PNG", "");
    root.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{
            "IMG_avif.c",
            "IMG_bmp.c",
            "IMG.c",
            "IMG_gif.c",
            "IMG_ImageIO.m",
            "IMG_jpg.c",
            "IMG_jxl.c",
            "IMG_lbm.c",
            "IMG_pcx.c",
            "IMG_png.c",
            "IMG_pnm.c",
            "IMG_qoi.c",
            "IMG_stb.c",
            "IMG_svg.c",
            "IMG_tga.c",
            "IMG_tif.c",
            "IMG_webp.c",
            "IMG_WIC.c",
            "IMG_xcf.c",
            "IMG_xpm.c",
            "IMG_xv.c",
            "IMG_xxx.c",
        },
    });

    // Build library
    const lib = b.addLibrary(.{
        .name = "SDL3_image",
        .root_module = root,
    });
    lib.linkSystemLibrary("sdl3");
    lib.installHeader(b.path("include/SDL3_image/SDL_image.h"), "SDL3_image/SDL_image.h");

    // Install
    b.installArtifact(lib);
}
