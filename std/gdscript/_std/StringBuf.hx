package;

/**
	GDScript implementation of Haxe's StringBuf class.
**/
#if !macro
@:coreApi
#end
class StringBuf {
	public var length(get, never): Int;

	var b: String;

	public function new() {
		b = "";
	}

	function get_length(): Int {
		return b.length;
	}

	public function add<T>(x: T): Void {
		b += Std.string(x);
	}

	public function addChar(c: Int): Void {
		b += untyped __gdscript__("char({0})", c);
	}

	public function addSub(s: String, pos: Int, len: Int = -1): Void {
		if(len < 0) {
			b += s.substr(pos);
		} else {
			b += s.substr(pos, len);
		}
	}

	public function toString(): String {
		return b;
	}
}
