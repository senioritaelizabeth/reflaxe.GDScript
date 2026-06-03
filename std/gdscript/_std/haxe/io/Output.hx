package haxe.io;

class Output {
	public var bigEndian: Bool = false;

	public function writeByte(c: Int): Void {
		throw Error.Custom("Not implemented");
	}

	public function writeBytes(s: Bytes, pos: Int, len: Int): Int {
		var k = len;
		while (k > 0) {
			writeByte(s.get(pos));
			pos++;
			k--;
		}
		return len;
	}

	public function flush(): Void {}

	public function close(): Void {}

	public function writeFullBytes(s: Bytes, pos: Int, len: Int): Void {
		while (len > 0) {
			final k = writeBytes(s, pos, len);
			pos += k;
			len -= k;
		}
	}

	public function write(s: Bytes): Void {
		writeFullBytes(s, 0, s.length);
	}

	public function writeString(s: String, ?encoding: Encoding): Void {
		final bytes = Bytes.ofString(s, encoding);
		write(bytes);
	}

	public function writeInt8(x: Int): Void {
		writeByte(x & 0xFF);
	}

	public function writeInt16(x: Int): Void {
		if (bigEndian) {
			writeByte((x >> 8) & 0xFF);
			writeByte(x & 0xFF);
		} else {
			writeByte(x & 0xFF);
			writeByte((x >> 8) & 0xFF);
		}
	}

	public function writeUInt16(x: Int): Void {
		writeInt16(x);
	}

	public function writeInt24(x: Int): Void {
		if (bigEndian) {
			writeByte((x >> 16) & 0xFF);
			writeByte((x >> 8) & 0xFF);
			writeByte(x & 0xFF);
		} else {
			writeByte(x & 0xFF);
			writeByte((x >> 8) & 0xFF);
			writeByte((x >> 16) & 0xFF);
		}
	}

	public function writeInt32(x: Int): Void {
		if (bigEndian) {
			writeByte((x >> 24) & 0xFF);
			writeByte((x >> 16) & 0xFF);
			writeByte((x >> 8) & 0xFF);
			writeByte(x & 0xFF);
		} else {
			writeByte(x & 0xFF);
			writeByte((x >> 8) & 0xFF);
			writeByte((x >> 16) & 0xFF);
			writeByte((x >> 24) & 0xFF);
		}
	}

	public function writeFloat(x: Float): Void {
		final b = Bytes.alloc(4);
		b.setFloat(0, x);
		write(b);
	}

	public function writeDouble(x: Float): Void {
		final b = Bytes.alloc(8);
		b.setDouble(0, x);
		write(b);
	}
}
