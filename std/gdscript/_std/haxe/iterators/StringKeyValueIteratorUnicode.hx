package haxe.iterators;

class StringKeyValueIteratorUnicode {
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

	public inline function next(): { key: Int, value: Int } {
		return { key: i, value: s.charCodeAt(i++) };
	}
}
