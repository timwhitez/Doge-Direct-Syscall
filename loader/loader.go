package loader

func main() {

}

func Allocate(callid uint16, PHandle uint64, BaseA, ZeroBits, RegionSize, AllocType, Protect uintptr, nothing uint64) uintptr

func NtProtectVirtualMemory(callid uint16, argh ...uintptr) (errcode uint32, err error)
