package haxe.io;

/**
	GDScript implementation of haxe.io.BytesOutput.
**/
class BytesOutput extends Output {
	var buf: BytesBuffer;

	public function new() {
		super();
		buf = new BytesBuffer();
	}

	public override function writeByte(c: Int): Void {
		buf.addByte(c);
	}

	public override function writeBytes(s: Bytes, pos: Int, len: Int): Int {
		for(i in 0...len) {
			buf.addByte(s.get(pos + i));
		}
		return len;
	}

	public override function writeString(s: String, ?encoding: Encoding): Void {
		buf.addString(s, encoding);
	}

	public function getBytes(): Bytes {
		return buf.getBytes();
	}

	public override function flush(): Void {}
}
