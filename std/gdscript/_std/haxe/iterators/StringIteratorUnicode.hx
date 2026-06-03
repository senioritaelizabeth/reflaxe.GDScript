package haxe.iterators;

class StringIteratorUnicode {
	var s: String;
	var i: Int;
	var l: Int;

	public inline function new(s: String) {
		this.s = s;
		this.i = 0;
		this.l = s.length;
	}

	public inline function hasNext(): Bool {
		return i < l;
	}

	public inline function next(): Int {
		// GDScript strings are unicode-aware, charCodeAt returns code points for BMP chars.
		// For full surrogate support this would need extension.
		return s.charCodeAt(i++);
	}
}
