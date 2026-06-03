package haxe.io;

// On GDScript target, BytesData is a PackedByteArray
abstract BytesData(Dynamic) {
	public inline function new() {
		this = untyped __gdscript__("PackedByteArray()");
	}
}
