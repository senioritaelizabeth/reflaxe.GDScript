package haxe.io;

/**
	GDScript implementation of haxe.io.Output.
**/
class Output {
	public function new() {}

	public function writeByte(c: Int): Void {
		throw "Output.writeByte not implemented for GDScript.";
	}

	public function writeBytes(s: Bytes, pos: Int, len: Int): Int {
		throw "Output.writeBytes not implemented for GDScript.";
		return 0;
	}

	public function write(s: Bytes): Void {
		var p = 0;
		final l = s.length;
		while(p < l) {
			p += writeBytes(s, p, l - p);
		}
	}

	public function writeFullBytes(s: Bytes, pos: Int, len: Int): Void {
		var p = pos;
		while(len > 0) {
			final k = writeBytes(s, p, len);
			p += k;
			len -= k;
		}
	}

	public function writeInt8(value: Int): Void {
		writeByte(value);
	}

	public function writeUInt8(value: Int): Void {
		writeByte(value);
	}

	public function writeInt16(value: Int): Void {
		writeByte(value & 0xFF);
		writeByte((value >> 8) & 0xFF);
	}

	public function writeUInt16(value: Int): Void {
		writeInt16(value);
	}

	public function writeInt24(value: Int): Void {
		writeByte(value & 0xFF);
		writeByte((value >> 8) & 0xFF);
		writeByte((value >> 16) & 0xFF);
	}

	public function writeInt32(value: Int): Void {
		writeByte(value & 0xFF);
		writeByte((value >> 8) & 0xFF);
		writeByte((value >> 16) & 0xFF);
		writeByte((value >> 24) & 0xFF);
	}

	public function writeSingle(value: Float): Void {
		throw "Output.writeSingle not implemented for GDScript.";
	}

	public function writeDouble(value: Float): Void {
		throw "Output.writeDouble not implemented for GDScript.";
	}

	public function writeFloat(value: Float): Void {
		writeSingle(value);
	}

	public function writeString(s: String, ?encoding: Encoding): Void {
		write(Bytes.ofString(s, encoding));
	}

	public function prepare(nbytes: Int): Void {}

	public function close(): Void {}

	public function flush(): Void {}
}
