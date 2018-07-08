/++
CPU cache infromation provided by macOS, iOS, TVOS, WatchOS.

$(GREEN This module is is compatible with betterC compilation mode.)

License:   $(WEB www.boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors:   Ilya Yaroshenko
+/
module cpuid.sys.darwin;

version (OSX)
    version = Darwin;
else
version (iOS)
    version = Darwin;
else
version (TVOS)
    version = Darwin;
else
version (WatchOS)
    version = Darwin;
else
version (D_Ddoc)
    version = Darwin;

version(Darwin):

///
unittest
{
    import std.stdio;
    darwin_cpu_info info = void;
    get_darwin_cpu_info(info);
    "#######################################".writeln;
    "########## SYS/DARWIN REPORT ##########".writeln;
    "#######################################".writeln;
    "CPUs = %s".writefln(info.packages);
    "cores per cpu = %s".writefln(info.physicalcpu / info.packages);
    "threads per cpu = %s".writefln(info.logicalcpu / info.packages);
    "page size = %s KB".writefln(info.pagesize >> 10);
    "cache line = %s B".writefln(info.cacheline);
    "L1i cache size = %s KB".writefln(info.l1icachesize >> 10);
    "L1d cache size = %s KB".writefln(info.l1dcachesize >> 10);
    "L2 cache size = %s KB".writefln(info.l2cachesize >> 10);
    "L3 cache size = %s KB".writefln(info.l3cachesize >> 10);
}

nothrow @nogc:

/// 
struct darwin_cpu_info
{
    /// total CPUs (packages)
    int packages;
    /// total cores (physical execution units)
    int physicalcpu;
    /// total threads (logical execution units)
    int logicalcpu;
    /// bytes
    int pagesize;
    /// bytes
    int cacheline;
    /// bytes
    int l1icachesize;
    /// bytes
    int l1dcachesize;
    /// bytes
    int l2cachesize;
    /// bytes
    int l3cachesize;
}

///
void get_darwin_cpu_info(ref darwin_cpu_info info)
{
    info.packages = sysctlbyname1("hw.packages");
    info.physicalcpu = sysctlbyname1("hw.physicalcpu");
    info.logicalcpu = sysctlbyname1("hw.logicalcpu");
    info.pagesize = sysctl_hw(HW_PAGESIZE);
    info.cacheline = sysctl_hw(HW_CACHELINE);
    info.l1icachesize = sysctl_hw(HW_L1ICACHESIZE);
    info.l1dcachesize = sysctl_hw(HW_L1DCACHESIZE);
    info.l2cachesize = sysctl_hw(HW_L2CACHESIZE);
    info.l3cachesize = sysctl_hw(HW_L3CACHESIZE);
}

//package(cpuid) 
int sysctlbyname1(const char *name)
{
    int ret = void;
    size_t len = ret.sizeof;
    if (sysctlbyname(name, &ret, &len, null, 0))
        return 1;
    return ret;
}

private:

extern(C)
int sysctl(int *, uint, void *, size_t *, void *, size_t);
int sysctl_hw(int ib)
{
    int[2] mib = void;
    mib[0] = CTL_HW;
    mib[1] = ib;
    int ret = void;
    size_t len = ret.sizeof;
    if (sysctl(mib.ptr, cast(uint)mib.length, &ret, &len, null, 0))
        return 0;
    return ret;
}
extern(C)
int sysctlbyname(const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen);

enum
{
    CTL_UNSPEC = 0,         /// unused
    CTL_KERN = 1,           /// "high kernel": proc, limits
    CTL_VM = 2,             /// virtual memory
    CTL_VFS = 3,            /// file system, mount type is next
    CTL_NET = 4,            /// network, see socket.h
    CTL_DEBUG = 5,          /// debugging parameters
    CTL_HW = 6,             /// generic cpu/io
    CTL_MACHDEP = 7,        /// machine dependent
    CTL_USER = 8,           /// user-level
    CTL_MAXID = 9,          /// number of valid top-level ids
}

enum
{
    HW_MACHINE = 1,         /// string: machine class
    HW_MODEL = 2,           /// string: specific machine model
    HW_NCPU = 3,            /// int: number of CPUs
    HW_BYTEORDER = 4,       /// int: machine byte order
    HW_PHYSMEM = 5,         /// int: total memory
    HW_USERMEM = 6,         /// int: non-kernel memory
    HW_PAGESIZE = 7,        /// int: software page size
    HW_DISKNAMES = 8,       /// strings: disk drive names
    HW_DISKSTATS = 9,       /// struct: diskstats[]
    HW_EPOCH = 10,          /// int: 0 for Legacy, else NewWorld
    HW_FLOATINGPT = 11,     /// int: has HW floating point?
    HW_MACHINE_ARCH = 12,   /// string: machine architecture
    HW_VECTORUNIT = 13,     /// int: has HW vector unit?
    HW_BUS_FREQ = 14,       /// int: Bus Frequency
    HW_CPU_FREQ = 15,       /// int: CPU Frequency
    HW_CACHELINE = 16,      /// int: Cache Line Size in Bytes
    HW_L1ICACHESIZE = 17,   /// int: L1 I Cache Size in Bytes
    HW_L1DCACHESIZE = 18,   /// int: L1 D Cache Size in Bytes
    HW_L2SETTINGS = 19,     /// int: L2 Cache Settings
    HW_L2CACHESIZE = 20,    /// int: L2 Cache Size in Bytes
    HW_L3SETTINGS = 21,     /// int: L3 Cache Settings
    HW_L3CACHESIZE = 22,    /// int: L3 Cache Size in Bytes
    HW_TB_FREQ = 23,        /// int: Bus Frequency
    HW_MEMSIZE = 24,        /// uint64_t: physical ram size
    HW_AVAILCPU = 25,       /// int: number of available CPUs
    HW_MAXID = 26,          /// number of valid hw ids
}
