package haxe.io;

/**
	GDScript implementation of haxe.io.StringInput.
**/
class StringInput extends BytesInput {
	public function new(s: String) {
		super(Bytes.ofString(s, UTF8));
	}
}
