package haxe.io;

class Bytes {
	public var length(default, null): Int;
	private var data: Dynamic; // PackedByteArray

	private function new(length: Int, data: Dynamic) {
		this.length = length;
		this.data = data;
	}

	public function get(pos: Int): Int {
		return untyped __gdscript__("{0}[{1}]", data, pos);
	}

	public function set(pos: Int, v: Int): Void {
		untyped __gdscript__("{0}[{1}] = {2}", data, pos, v & 0xFF);
	}

	public function blit(pos: Int, src: Bytes, srcPos: Int, len: Int): Void {
		for (i in 0...len) set(pos + i, src.get(srcPos + i));
	}

	public function fill(pos: Int, len: Int, value: Int): Void {
		for (i in 0...len) set(pos + i, value);
	}

	public function sub(pos: Int, len: Int): Bytes {
		final newData = untyped __gdscript__("{0}.slice({1}, {2})", data, pos, pos + len);
		return new Bytes(len, newData);
	}

	public function compare(other: Bytes): Int {
		final len = length < other.length ? length : other.length;
		for (i in 0...len) {
			final a = get(i);
			final b = other.get(i);
			if (a != b) return a - b;
		}
		return length - other.length;
	}

	public function getString(pos: Int, len: Int, ?encoding: Encoding): String {
		final sub = untyped __gdscript__("{0}.slice({1}, {2})", data, pos, pos + len);
		return untyped __gdscript__("{0}.get_string_from_utf8()", sub);
	}

	public function toString(): String {
		return getString(0, length);
	}

	public function toHex(): String {
		final hex = "0123456789abcdef";
		var result = "";
		for (i in 0...length) {
			final v = get(i);
			result += hex.charAt(v >> 4) + hex.charAt(v & 0xF);
		}
		return result;
	}

	public function getInt32(pos: Int): Int {
		final a = get(pos);
		final b = get(pos + 1);
		final c = get(pos + 2);
		final d = get(pos + 3);
		return a | (b << 8) | (c << 16) | (d << 24);
	}

	public function getInt16(pos: Int): Int {
		final a = get(pos);
		final b = get(pos + 1);
		return a | (b << 8);
	}

	public function setInt32(pos: Int, v: Int): Void {
		set(pos, v & 0xFF);
		set(pos + 1, (v >> 8) & 0xFF);
		set(pos + 2, (v >> 16) & 0xFF);
		set(pos + 3, (v >> 24) & 0xFF);
	}

	public function setInt16(pos: Int, v: Int): Void {
		set(pos, v & 0xFF);
		set(pos + 1, (v >> 8) & 0xFF);
	}

	public function getFloat(pos: Int): Float {
		// Pack bytes into float using GDScript
		final sub = untyped __gdscript__("{0}.slice({1}, {2})", data, pos, pos + 4);
		return untyped __gdscript__("{0}.decode_float(0)", sub);
	}

	public function getDouble(pos: Int): Float {
		final sub = untyped __gdscript__("{0}.slice({1}, {2})", data, pos, pos + 8);
		return untyped __gdscript__("{0}.decode_double(0)", sub);
	}

	public function setFloat(pos: Int, v: Float): Void {
		final enc: Dynamic = untyped __gdscript__("PackedByteArray()");
		untyped __gdscript__("{0}.resize(4)", enc);
		untyped __gdscript__("{0}.encode_float(0, {1})", enc, v);
		for (i in 0...4) set(pos + i, untyped __gdscript__("{0}[{1}]", enc, i));
	}

	public function setDouble(pos: Int, v: Float): Void {
		final enc: Dynamic = untyped __gdscript__("PackedByteArray()");
		untyped __gdscript__("{0}.resize(8)", enc);
		untyped __gdscript__("{0}.encode_double(0, {1})", enc, v);
		for (i in 0...8) set(pos + i, untyped __gdscript__("{0}[{1}]", enc, i));
	}

	public static function alloc(length: Int): Bytes {
		final data: Dynamic = untyped __gdscript__("PackedByteArray()");
		untyped __gdscript__("{0}.resize({1})", data, length);
		untyped __gdscript__("{0}.fill(0)", data);
		return new Bytes(length, data);
	}

	public static function ofString(s: String, ?encoding: Encoding): Bytes {
		final data: Dynamic = untyped __gdscript__("{0}.to_utf8_buffer()", s);
		final len: Int = untyped __gdscript__("{0}.size()", data);
		return new Bytes(len, data);
	}

	public static function ofHex(hex: String): Bytes {
		final len = Std.int(hex.length / 2);
		final bytes = alloc(len);
		for (i in 0...len) {
			final high = hex.charCodeAt(i * 2);
			final low = hex.charCodeAt(i * 2 + 1);
			final hv = high < 58 ? high - 48 : (high < 71 ? high - 55 : high - 87);
			final lv = low < 58 ? low - 48 : (low < 71 ? low - 55 : low - 87);
			bytes.set(i, (hv << 4) | lv);
		}
		return bytes;
	}
}
