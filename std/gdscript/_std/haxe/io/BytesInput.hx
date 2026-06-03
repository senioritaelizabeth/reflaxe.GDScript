package haxe.io;

class BytesInput extends Input {
	public var position: Int;
	var b: Bytes;
	public var length: Int;

	public function new(b: Bytes, pos: Int = 0, ?len: Int) {
		this.b = b;
		this.position = pos;
		this.length = len == null ? b.length - pos : len;
	}

	override public function readByte(): Int {
		if (position >= length) throw new Eof();
		return b.get(position++);
	}

	override public function readBytes(s: Bytes, pos: Int, len: Int): Int {
		if (position + len > length) len = length - position;
		if (len == 0) throw new Eof();
		s.blit(pos, b, position, len);
		position += len;
		return len;
	}
}
