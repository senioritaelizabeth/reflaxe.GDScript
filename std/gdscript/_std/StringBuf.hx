package;

class StringBuf {
	private var b: String;

	public var length(get, never): Int;
	inline function get_length(): Int return b.length;

	public function new() {
		b = "";
	}

	public function add<T>(x: T): Void {
		b += Std.string(x);
	}

	public function addChar(c: Int): Void {
		b += String.fromCharCode(c);
	}

	public function addSub(s: String, pos: Int, ?len: Int): Void {
		b += if (len == null) s.substr(pos) else s.substr(pos, len);
	}

	public function toString(): String {
		return b;
	}
}
