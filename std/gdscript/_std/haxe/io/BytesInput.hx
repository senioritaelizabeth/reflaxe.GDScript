package haxe.io;

/**
	GDScript implementation of haxe.io.BytesInput.
**/
class BytesInput extends Input {
	var b: Bytes;
	var pos: Int;
	var len: Int;

	public function new(b: Bytes, ?pos: Int, ?len: Int) {
		super();
		this.b = b;
		this.pos = pos != null ? pos : 0;
		this.len = len != null ? len : b.length - this.pos;
	}

	public override function readByte(): Int {
		if(pos >= b.length) throw new Eof();
		return b.get(pos++);
	}

	public override function readBytes(s: Bytes, pos: Int, len: Int): Int {
		if(this.pos >= b.length) throw new Eof();
		final available = b.length - this.pos;
		final toRead = len < available ? len : available;
		for(i in 0...toRead) {
			s.set(pos + i, b.get(this.pos + i));
		}
		this.pos += toRead;
		return toRead;
	}

	public override function close(): Void {}
}
