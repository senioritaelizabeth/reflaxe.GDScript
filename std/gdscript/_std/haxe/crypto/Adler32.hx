package haxe.crypto;

abstract Adler32(Int) {
	inline function new(v: Int) {
		this = v;
	}

	public static function make(): Adler32 {
		return new Adler32(1);
	}

	public static function read(i: haxe.io.Input): Adler32 {
		final b = i.read(4);
		return new Adler32(b.getInt32(0));
	}

	public function update(buf: haxe.io.Bytes, pos: Int, len: Int): Void {
		var s1 = this & 0xFFFF;
		var s2 = (this >> 16) & 0xFFFF;
		for (i in pos...(pos + len)) {
			s1 = (s1 + buf.get(i)) % 65521;
			s2 = (s2 + s1) % 65521;
		}
		this = (s2 << 16) | s1;
	}

	public function equals(a: Adler32): Bool {
		return this == (a : Int);
	}

	public static function encode(b: haxe.io.Bytes): Adler32 {
		final a = make();
		a.update(b, 0, b.length);
		return a;
	}
}
