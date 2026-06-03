package haxe.io;

class BytesOutput extends Output {
	private var buf: BytesBuffer;

	public function new() {
		buf = new BytesBuffer();
	}

	override public function writeByte(c: Int): Void {
		buf.addByte(c);
	}

	override public function writeBytes(s: Bytes, pos: Int, len: Int): Int {
		buf.addSub(s, pos, len);
		return len;
	}

	public function getBytes(): Bytes {
		return buf.getBytes();
	}
}
