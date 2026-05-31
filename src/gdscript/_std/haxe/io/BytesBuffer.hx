package haxe.io;

/**
	GDScript implementation of haxe.io.BytesBuffer.
**/
class BytesBuffer {
	var b: Array<Int>;

	public function new() {
		b = [];
	}

	public function add(bytes: Bytes): Void {
		for(i in 0...bytes.length) {
			b.push(bytes.get(i));
		}
	}

	public function addByte(byte: Int): Void {
		b.push(byte);
	}

	public function addString(str: String, ?encoding: Encoding): Void {
		add(Bytes.ofString(str, encoding));
	}

	public function addInt32(v: Int): Void {
		b.push(v & 0xFF);
		b.push((v >> 8) & 0xFF);
		b.push((v >> 16) & 0xFF);
		b.push((v >> 24) & 0xFF);
	}

	public function addFloat(f: Float): Void {
		throw "BytesBuffer.addFloat not implemented for GDScript.";
	}

	public function getBytes(): Bytes {
		return Bytes.ofData(b);
	}
}
