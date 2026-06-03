package haxe.io;

enum Error {
	Blocked;
	Overflow;
	OutsideBounds;
	Custom(e: Dynamic);
}
