package haxe.iterators;

class ArrayKeyValueIterator<T> {
	var a: Array<T>;
	var i: Int;

	public inline function new(a: Array<T>) {
		this.a = a;
		this.i = 0;
	}

	public inline function hasNext(): Bool {
		return i < a.length;
	}

	public inline function next(): { key: Int, value: T } {
		return { key: i, value: a[i++] };
	}
}
