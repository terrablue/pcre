const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const pcre = b.addStaticLibrary(.{
        .name = "pcre",
        .target = target,
        .optimize = optimize,
    });

    const config_h = b.addConfigHeader(.{
        .style = .{ .cmake = .{ .path = "config.h.in" } }
    }, .{
        .HAVE_DIRENT_H = 1,
        .HAVE_SYS_STAT_H = 1,
        .HAVE_SYS_TYPES_H = 1,
        .HAVE_UNISTD_H = 1,
        .HAVE_WINDOWS_H = null,
        .HAVE_STDINT_H = 1,
        .HAVE_INTTYPES_H = 1,

        .HAVE_TYPE_TRAITS_H = null,
        .HAVE_BITS_TYPE_TRAITS_H = null,

        .HAVE_BCOPY = 1,
        .HAVE_MEMMOVE = 1,
        .HAVE_STRERROR = 1,
        .HAVE_STRTOLL = 1,
        .HAVE_STRTOQ = 1,
        .HAVE__STRTOI64 = null,

        .PCRE_STATIC = null,

        .SUPPORT_PCRE8 = 1,
        .SUPPORT_PCRE16 = null,
        .SUPPORT_PCRE32 = null,
        .SUPPORT_JIT = null,
        .SUPPORT_PCREGREP_JIT = null,
        .SUPPORT_UTF = null,
        .SUPPORT_UCP = null,
        .EBCDIC = null,
        .EBCDIC_NL25 = null,
        .BSR_ANYCRLF = null,
        .NO_RECURSE = 1,

        .HAVE_LONG_LONG = 1,
        .HAVE_UNSIGNED_LONG_LONG = 1,

        .SUPPORT_LIBBZ2 = null,
        .SUPPORT_LIBZ = null,
        .SUPPORT_LIBEDIT = null,
        .SUPPORT_LIBREADLINE = null,

        .SUPPORT_VALGRIND = null,
        .SUPPORT_GCOV = null,
    });

    pcre.addIncludePath(".");
    pcre.addConfigHeader(config_h);
    pcre.linkLibC();
    pcre.addCSourceFiles(&.{
      "pcre_byte_order.c",
      "pcre_chartables.c",
      "pcre_compile.c",
      "pcre_config.c",
      "pcre_dfa_exec.c",
      "pcre_exec.c",
      "pcre_fullinfo.c",
      "pcre_get.c",
      "pcre_globals.c",
      "pcre_jit_compile.c",
      "pcre_maketables.c",
      "pcre_newline.c",
      "pcre_ord2utf8.c",
      "pcre_refcount.c",
      "pcre_string_utils.c",
      "pcre_study.c",
      "pcre_tables.c",
      "pcre_ucd.c",
      "pcre_valid_utf8.c",
      "pcre_version.c",
      "pcre_xclass.c",
    }, &.{
        "-DHAVE_CONFIG_H",
        "-Wall",
        "-W",
        "-Wstrict-prototypes",
        "-Wwrite-strings",
        "-Wno-missing-field-initializers",
    });
    pcre.linkLibC();
    pcre.install();
    pcre.installHeader("pcre.h", "pcre.h");
}
