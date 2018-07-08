/++
CPU cache infromation provided by GNU Runtime.

$(GREEN This module is is compatible with betterC compilation mode.)

License:   $(WEB www.boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors:   Ilya Yaroshenko
+/
module cpuid.sys.gnu;


version (CRuntime_Glibc)
    version = GNUClib;
version (D_Ddoc)
    version = GNUClib;

version (GNUClib):

///
unittest
{
    import std.stdio;
    gnu_cpu_cache_info info = void;
    get_gnu_cpu_cache_info(info);
    "#######################################".writeln;
    "############ SYS/GNU REPORT ###########".writeln;
    "#######################################".writeln;
    "L1i cache size = ".writeln(info.level1_icache_size);
    "L1i cache assoc = ".writeln(info.level1_icache_assoc);
    "L1i cache linesize = ".writeln(info.level1_icache_linesize);
    "L1d cache size = ".writeln(info.level1_dcache_size);
    "L1d cache assoc = ".writeln(info.level1_dcache_assoc);
    "L1d cache linesize = ".writeln(info.level1_dcache_linesize);
    "L2 cache size = ".writeln(info.level2_cache_size);
    "L2 cache assoc = ".writeln(info.level2_cache_assoc);
    "L2 cache linesize = ".writeln(info.level2_cache_linesize);
    "L3 cache size = ".writeln(info.level3_cache_size);
    "L3 cache assoc = ".writeln(info.level3_cache_assoc);
    "L3 cache linesize = ".writeln(info.level3_cache_linesize);
    "L4 cache size = ".writeln(info.level4_cache_size);
    "L4 cache assoc = ".writeln(info.level4_cache_assoc);
    "L4 cache linesize = ".writeln(info.level4_cache_linesize);
}

nothrow @nogc:

///
struct gnu_cpu_cache_info
{
    /// Bytes
    int level1_icache_size;
    /// Ways
    int level1_icache_assoc;
    /// Bytes
    int level1_icache_linesize;
    /// Bytes
    int level1_dcache_size;
    /// Ways
    int level1_dcache_assoc;
    /// Bytes
    int level1_dcache_linesize;
    /// Bytes
    int level2_cache_size;
    /// Ways
    int level2_cache_assoc;
    /// Bytes
    int level2_cache_linesize;
    /// Bytes
    int level3_cache_size;
    /// Ways
    int level3_cache_assoc;
    /// Bytes
    int level3_cache_linesize;
    /// Bytes
    int level4_cache_size;
    /// Ways
    int level4_cache_assoc;
    /// Bytes
    int level4_cache_linesize;
}

///
@safe nothrow @nogc
void get_gnu_cpu_cache_info(ref gnu_cpu_cache_info info)
{
    import core.sys.posix.unistd;
    info.level1_icache_size = cast(int) sysconf(_SC_LEVEL1_ICACHE_SIZE);
    info.level1_icache_assoc = cast(int) sysconf(_SC_LEVEL1_ICACHE_ASSOC);
    info.level1_icache_linesize = cast(int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
    info.level1_dcache_size = cast(int) sysconf(_SC_LEVEL1_DCACHE_SIZE);
    info.level1_dcache_assoc = cast(int) sysconf(_SC_LEVEL1_DCACHE_ASSOC);
    info.level1_dcache_linesize = cast(int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
    info.level2_cache_size = cast(int) sysconf(_SC_LEVEL2_CACHE_SIZE);
    info.level2_cache_assoc = cast(int) sysconf(_SC_LEVEL2_CACHE_ASSOC);
    info.level2_cache_linesize = cast(int) sysconf(_SC_LEVEL2_CACHE_LINESIZE);
    info.level3_cache_size = cast(int) sysconf(_SC_LEVEL3_CACHE_SIZE);
    info.level3_cache_assoc = cast(int) sysconf(_SC_LEVEL3_CACHE_ASSOC);
    info.level3_cache_linesize = cast(int) sysconf(_SC_LEVEL3_CACHE_LINESIZE);
    info.level4_cache_size = cast(int) sysconf(_SC_LEVEL4_CACHE_SIZE);
    info.level4_cache_assoc = cast(int) sysconf(_SC_LEVEL4_CACHE_ASSOC);
    info.level4_cache_linesize = cast(int) sysconf(_SC_LEVEL4_CACHE_LINESIZE);
}
