package haxe.io;

/**
	GDScript implementation of haxe.io.Input.
**/
class Input {
	public function new() {}

	public function readByte(): Int {
		throw "Input.readByte not implemented for GDScript.";
		return 0;
	}

	public function readBytes(s: Bytes, pos: Int, len: Int): Int {
		throw "Input.readBytes not implemented for GDScript.";
		return 0;
	}

	public function readAll(?bufsize: Int): Bytes {
		final buf = new BytesBuffer();
		try {
			while(true) {
				buf.addByte(readByte());
			}
		} catch(e: Eof) {}
		return buf.getBytes();
	}

	public function readFullBytes(s: Bytes, pos: Int, len: Int): Void {
		var p = pos;
		while(len > 0) {
			final k = readBytes(s, p, len);
			p += k;
			len -= k;
		}
	}

	public function readInt8(): Int {
		return readByte();
	}

	public function readUInt8(): Int {
		return readByte();
	}

	public function readInt16(): Int {
		final ch1 = readByte();
		final ch2 = readByte();
		return (ch2 << 8) | ch1;
	}

	public function readUInt16(): Int {
		return readInt16();
	}

	public function readInt24(): Int {
		final ch1 = readByte();
		final ch2 = readByte();
		final ch3 = readByte();
		return (ch3 << 16) | (ch2 << 8) | ch1;
	}

	public function readInt32(): Int {
		final ch1 = readByte();
		final ch2 = readByte();
		final ch3 = readByte();
		final ch4 = readByte();
		return (ch4 << 24) | (ch3 << 16) | (ch2 << 8) | ch1;
	}

	public function readSingle(): Float {
		throw "Input.readSingle not implemented for GDScript.";
		return 0.0;
	}

	public function readDouble(): Float {
		throw "Input.readDouble not implemented for GDScript.";
		return 0.0;
	}

	public function readFloat(): Float {
		return readSingle();
	}

	public function readLine(): String {
		var buf = "";
		var lastWasCR = false;
		try {
			while(true) {
				final c = readByte();
				if(c == 10) {
					if(lastWasCR) buf = buf.substr(0, buf.length - 1);
					break;
				}
				if(c != 13) {
					buf += String.fromCharCode(c);
					lastWasCR = false;
				} else {
					buf += String.fromCharCode(c);
					lastWasCR = true;
				}
			}
		} catch(e: Eof) {
			if(lastWasCR) buf = buf.substr(0, buf.length - 1);
		}
		return buf;
	}

	public function read(?nbytes: Null<Int>): String {
		if(nbytes == null) return readAll().toString();
		final buf = new BytesBuffer();
		var i = 0;
		while(i < nbytes) {
			try {
				buf.addByte(readByte());
			} catch(e: Eof) break;
			i++;
		}
		return buf.getBytes().toString();
	}

	public function close(): Void {}
}
