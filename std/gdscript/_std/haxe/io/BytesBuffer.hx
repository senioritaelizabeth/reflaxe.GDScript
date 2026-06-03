package haxe.io;

class BytesBuffer {
	private var data: Dynamic; // PackedByteArray
	private var _length: Int;

	public var length(get, never): Int;
	inline function get_length(): Int return _length;

	public function new() {
		data = untyped __gdscript__("PackedByteArray()");
		_length = 0;
	}

	public function addByte(byte: Int): Void {
		untyped __gdscript__("{0}.append({1})", data, byte & 0xFF);
		_length++;
	}

	public function add(src: Bytes): Void {
		for (i in 0...src.length) addByte(src.get(i));
	}

	public function addString(s: String, ?encoding: Encoding): Void {
		final encoded: Dynamic = untyped __gdscript__("{0}.to_utf8_buffer()", s);
		final len: Int = untyped __gdscript__("{0}.size()", encoded);
		for (i in 0...len) {
			untyped __gdscript__("{0}.append({1}[{2}])", data, encoded, i);
			_length++;
		}
	}

	public function addInt32(v: Int): Void {
		addByte(v & 0xFF);
		addByte((v >> 8) & 0xFF);
		addByte((v >> 16) & 0xFF);
		addByte((v >> 24) & 0xFF);
	}

	public function addInt16(v: Int): Void {
		addByte(v & 0xFF);
		addByte((v >> 8) & 0xFF);
	}

	public function addFloat(v: Float): Void {
		final enc: Dynamic = untyped __gdscript__("PackedByteArray()");
		untyped __gdscript__("{0}.resize(4)", enc);
		untyped __gdscript__("{0}.encode_float(0, {1})", enc, v);
		for (i in 0...4) {
			untyped __gdscript__("{0}.append({1}[{2}])", data, enc, i);
			_length++;
		}
	}

	public function addDouble(v: Float): Void {
		final enc: Dynamic = untyped __gdscript__("PackedByteArray()");
		untyped __gdscript__("{0}.resize(8)", enc);
		untyped __gdscript__("{0}.encode_double(0, {1})", enc, v);
		for (i in 0...8) {
			untyped __gdscript__("{0}.append({1}[{2}])", data, enc, i);
			_length++;
		}
	}

	public function addSub(src: Bytes, pos: Int, len: Int): Void {
		for (i in 0...len) addByte(src.get(pos + i));
	}

	public function getBytes(): Bytes {
		// Copy out
		final copy: Dynamic = untyped __gdscript__("{0}.duplicate()", data);
		return @:privateAccess new Bytes(_length, copy);
	}
}
