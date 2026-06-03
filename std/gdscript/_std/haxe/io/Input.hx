package haxe.io;

class Input {
	public var bigEndian: Bool = false;

	public function readByte(): Int {
		throw Error.Custom("Not implemented");
		return 0;
	}

	public function readBytes(s: Bytes, pos: Int, len: Int): Int {
		var k = len;
		while (k > 0) {
			s.set(pos, readByte());
			pos++;
			k--;
		}
		return len;
	}

	public function close(): Void {}

	public function readAll(?bufsize: Int): Bytes {
		final buf = Bytes.alloc(bufsize == null ? 16384 : bufsize);
		final bb = new BytesBuffer();
		var nbytes = 0;
		try {
			while (true) {
				nbytes = readBytes(buf, 0, buf.length);
				bb.addSub(buf, 0, nbytes);
			}
		} catch(e: haxe.io.Eof) {}
		return bb.getBytes();
	}

	public function readFullBytes(s: Bytes, pos: Int, len: Int): Void {
		while (len > 0) {
			final k = readBytes(s, pos, len);
			pos += k;
			len -= k;
		}
	}

	public function read(nbytes: Int): Bytes {
		final s = Bytes.alloc(nbytes);
		readFullBytes(s, 0, nbytes);
		return s;
	}

	public function readString(len: Int, ?encoding: Encoding): String {
		final b = Bytes.alloc(len);
		readFullBytes(b, 0, len);
		return b.getString(0, len, encoding);
	}

	public function readLine(): String {
		var buf = new StringBuf();
		var last: Null<Int> = null;
		var b = 0;
		while (true) {
			try {
				b = readByte();
			} catch(e: haxe.io.Eof) {
				if (last == null) throw e;
				break;
			}
			if (b == 13) {
				last = b;
			} else if (b == 10) {
				break;
			} else {
				if (last == 13) buf.addChar(last);
				last = null;
				buf.addChar(b);
			}
		}
		return buf.toString();
	}

	public function readInt8(): Int {
		final n = readByte();
		return if (n >= 128) n - 256 else n;
	}

	public function readInt16(): Int {
		final a = readByte();
		final b = readByte();
		final n = if (bigEndian) (a << 8) | b else (b << 8) | a;
		return if (n >= 32768) n - 65536 else n;
	}

	public function readUInt16(): Int {
		final a = readByte();
		final b = readByte();
		return if (bigEndian) (a << 8) | b else (b << 8) | a;
	}

	public function readInt24(): Int {
		final a = readByte();
		final b = readByte();
		final c = readByte();
		final n = if (bigEndian) (a << 16) | (b << 8) | c else (c << 16) | (b << 8) | a;
		return if (n >= 8388608) n - 16777216 else n;
	}

	public function readUInt24(): Int {
		final a = readByte();
		final b = readByte();
		final c = readByte();
		return if (bigEndian) (a << 16) | (b << 8) | c else (c << 16) | (b << 8) | a;
	}

	public function readInt32(): Int {
		final a = readByte();
		final b = readByte();
		final c = readByte();
		final d = readByte();
		return if (bigEndian) (a << 24) | (b << 16) | (c << 8) | d else (d << 24) | (c << 16) | (b << 8) | a;
	}

	public function readFloat(): Float {
		final bytes = read(4);
		return bytes.getFloat(0);
	}

	public function readDouble(): Float {
		final bytes = read(8);
		return bytes.getDouble(0);
	}
}
