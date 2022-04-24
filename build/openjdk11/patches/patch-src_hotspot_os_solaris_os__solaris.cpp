$NetBSD$

Fix building on SunOS in C99 mode.

diff -wpruN '--exclude=*.orig' a~/src/hotspot/os/solaris/os_solaris.cpp a/src/hotspot/os/solaris/os_solaris.cpp
--- a~/src/hotspot/os/solaris/os_solaris.cpp	1970-01-01 00:00:00
+++ a/src/hotspot/os/solaris/os_solaris.cpp	1970-01-01 00:00:00
@@ -2325,7 +2327,7 @@ void os::pd_commit_memory_or_exit(char*
 
 // Uncommit the pages in a specified region.
 void os::pd_free_memory(char* addr, size_t bytes, size_t alignment_hint) {
-  if (madvise(addr, bytes, MADV_FREE) < 0) {
+  if (posix_madvise(addr, bytes, MADV_FREE) < 0) {
     debug_only(warning("MADV_FREE failed."));
     return;
   }
@@ -2354,7 +2356,7 @@ void os::pd_realign_memory(char *addr, s
 // Tell the OS to make the range local to the first-touching LWP
 void os::numa_make_local(char *addr, size_t bytes, int lgrp_hint) {
   assert((intptr_t)addr % os::vm_page_size() == 0, "Address should be page-aligned.");
-  if (madvise(addr, bytes, MADV_ACCESS_LWP) < 0) {
+  if (posix_madvise(addr, bytes, MADV_ACCESS_LWP) < 0) {
     debug_only(warning("MADV_ACCESS_LWP failed."));
   }
 }
@@ -2362,7 +2364,7 @@ void os::numa_make_local(char *addr, siz
 // Tell the OS that this range would be accessed from different LWPs.
 void os::numa_make_global(char *addr, size_t bytes) {
   assert((intptr_t)addr % os::vm_page_size() == 0, "Address should be page-aligned.");
-  if (madvise(addr, bytes, MADV_ACCESS_MANY) < 0) {
+  if (posix_madvise(addr, bytes, MADV_ACCESS_MANY) < 0) {
     debug_only(warning("MADV_ACCESS_MANY failed."));
   }
 }
