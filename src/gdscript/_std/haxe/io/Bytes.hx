package haxe.io;

typedef BytesData = Array<Int>;

/**
	GDScript implementation of haxe.io.Bytes.
	Uses Array<Int> for byte storage.
**/
@:nativeTypeCode("Array[Int]")
class Bytes {
	public var length(default, null): Int;
	var b: Array<Int>;

	public function new(length: Int, ?b: Array<Int>) {
		this.b = b != null ? b : [];
		this.length = length;
	}

	public static function ofString(s: String, ?encoding: Encoding): Bytes {
		final bytes: Array<Int> = [];
		for(i in 0...s.length) {
			bytes.push(s.charCodeAt(i));
		}
		return new Bytes(bytes.length, bytes);
	}

	public static function ofData(data: Array<Int>): Bytes {
		return new Bytes(data.length, data);
	}

	public static function alloc(length: Int): Bytes {
		final b: Array<Int> = [];
		for(i in 0...length) b.push(0);
		return new Bytes(length, b);
	}

	public static function readBytes(bytes: Bytes, pos: Int, len: Int): Bytes {
		final result: Array<Int> = [];
		for(i in pos...pos + len) {
			result.push(bytes.b[i]);
		}
		return new Bytes(len, result);
	}

	public static function fastCompare(bytes1: Bytes, bytes2: Bytes, ?maxBytes: Int = 8192): Int {
		final len = maxBytes < bytes1.length ? maxBytes : bytes1.length;
		for(i in 0...len) {
			if(bytes1.get(i) != bytes2.get(i)) {
				return bytes1.get(i) - bytes2.get(i);
			}
		}
		return bytes1.length - bytes2.length;
	}

	public function compare(other: Bytes): Int {
		final len = this.length < other.length ? this.length : other.length;
		for(i in 0...len) {
			if(this.get(i) != other.get(i)) {
				return this.get(i) - other.get(i);
			}
		}
		return this.length - other.length;
	}

	public function get(pos: Int): Int {
		return b[pos];
	}

	@:noCompletion
	public function fastGet(pos: Int): Int {
		return b[pos];
	}

	public function set(pos: Int, v: Int): Void {
		b[pos] = v;
	}

	public function blit(pos: Int, src: Bytes, srcpos: Int, len: Int): Void {
		for(i in 0...len) {
			b[pos + i] = src.b[srcpos + i];
		}
	}

	public function sub(pos: Int, len: Int): Bytes {
		return readBytes(this, pos, len);
	}

	public function fill(pos: Int, len: Int, value: Int): Void {
		for(i in pos...pos + len) {
			b[i] = value;
		}
	}

	public function toString(): String {
		var result = "";
		for(i in 0...length) {
			result += String.fromCharCode(get(i));
		}
		return result;
	}

	public function getString(pos: Int, len: Int, ?encoding: Encoding): String {
		var result = "";
		for(i in pos...pos + len) {
			result += String.fromCharCode(get(i));
		}
		return result;
	}

	public function readString(pos: Int, len: Int): String {
		return getString(pos, len);
	}

	public function toHex(): String {
		var result = "";
		final hexChars = "0123456789abcdef";
		for(i in 0...length) {
			final v = get(i);
			result += hexChars.charAt((v >> 4) & 0xF) + hexChars.charAt(v & 0xF);
		}
		return result;
	}

	public function getData(): BytesData {
		return cast b;
	}

	public function getDouble(pos: Int): Float {
		throw "Bytes.getDouble not implemented for GDScript.";
		return 0.0;
	}

	public function getFloat(pos: Int): Float {
		throw "Bytes.getFloat not implemented for GDScript.";
		return 0.0;
	}

	public function getInt32(pos: Int): Int {
		final ch1 = get(pos);
		final ch2 = get(pos + 1);
		final ch3 = get(pos + 2);
		final ch4 = get(pos + 3);
		return (ch4 << 24) | (ch3 << 16) | (ch2 << 8) | ch1;
	}

	public function getInt64(pos: Int): haxe.Int64 {
		throw "Bytes.getInt64 not implemented for GDScript.";
		return 0;
	}

	public function getUInt16(pos: Int): Int {
		final ch1 = get(pos);
		final ch2 = get(pos + 1);
		return (ch2 << 8) | ch1;
	}

	public function setDouble(pos: Int, v: Float): Void {
		throw "Bytes.setDouble not implemented for GDScript.";
	}

	public function setFloat(pos: Int, v: Float): Void {
		throw "Bytes.setFloat not implemented for GDScript.";
	}

	public function setInt32(pos: Int, v: Int): Void {
		set(pos, v & 0xFF);
		set(pos + 1, (v >> 8) & 0xFF);
		set(pos + 2, (v >> 16) & 0xFF);
		set(pos + 3, (v >> 24) & 0xFF);
	}

	public function setInt64(pos: Int, v: haxe.Int64): Void {
		throw "Bytes.setInt64 not implemented for GDScript.";
	}

	public function setUInt16(pos: Int, v: Int): Void {
		set(pos, v & 0xFF);
		set(pos + 1, (v >> 8) & 0xFF);
	}

	public static function ofHex(s: String): Bytes {
		final bytes: Array<Int> = [];
		var i = 0;
		while(i < s.length) {
			final hex = s.substr(i, 2);
			bytes.push(untyped __gdscript__("int(\"{0}\", 16)", hex));
			i += 2;
		}
		return new Bytes(bytes.length, bytes);
	}
}
