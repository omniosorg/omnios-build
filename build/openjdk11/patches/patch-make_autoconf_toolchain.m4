$NetBSD$

Support SunOS/gcc.

diff -wpruN --no-dereference '--exclude=*.orig' a~/make/autoconf/toolchain.m4 a/make/autoconf/toolchain.m4
--- a~/make/autoconf/toolchain.m4	1970-01-01 00:00:00
+++ a/make/autoconf/toolchain.m4	1970-01-01 00:00:00
@@ -39,7 +39,7 @@ VALID_TOOLCHAINS_all="gcc clang solstudi
 
 # These toolchains are valid on different platforms
 VALID_TOOLCHAINS_linux="gcc clang"
-VALID_TOOLCHAINS_solaris="solstudio"
+VALID_TOOLCHAINS_solaris="gcc solstudio"
 VALID_TOOLCHAINS_macosx="gcc clang"
 VALID_TOOLCHAINS_aix="xlc"
 VALID_TOOLCHAINS_windows="microsoft"
