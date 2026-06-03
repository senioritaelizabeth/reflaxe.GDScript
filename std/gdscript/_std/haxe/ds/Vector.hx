package haxe.ds;

@:forward
abstract Vector<T>(VectorData<T>) {
	public inline function new(length: Int) {
		this = new VectorData<T>(length);
	}

	@:op([]) public inline function get(index: Int): T {
		return this.get(index);
	}

	@:op([]) public inline function set(index: Int, val: T): T {
		this.set(index, val);
		return val;
	}

	public var length(get, never): Int;
	inline function get_length(): Int return this.length;

	public inline function toArray(): Array<T> {
		final a: Array<T> = [];
		for (i in 0...this.length) a.push(this.get(i));
		return a;
	}

	public static inline function fromArrayCopy<T>(array: Array<T>): Vector<T> {
		final v = new Vector<T>(array.length);
		for (i in 0...array.length) v.set(i, array[i]);
		return v;
	}

	public inline function copy(): Vector<T> {
		return fromArrayCopy(toArray());
	}

	public inline function blit(srcPos: Int, dst: Vector<T>, dstPos: Int, len: Int): Void {
		for (i in 0...len) dst.set(dstPos + i, get(srcPos + i));
	}

	public inline function fill(val: T): Void {
		for (i in 0...this.length) this.set(i, val);
	}

	public inline function iterator(): Iterator<T> {
		var i = 0;
		final len = this.length;
		return {
			hasNext: () -> i < len,
			next: () -> {
				final v = this.get(i);
				i++;
				v;
			}
		};
	}

	public inline function keyValueIterator(): KeyValueIterator<Int, T> {
		var i = 0;
		final len = this.length;
		return {
			hasNext: () -> i < len,
			next: () -> {
				final kv = { key: i, value: this.get(i) };
				i++;
				kv;
			}
		};
	}

	public inline function map<S>(f: T -> S): Vector<S> {
		final result = new Vector<S>(this.length);
		for (i in 0...this.length) result.set(i, f(this.get(i)));
		return result;
	}

	public function toString(): String {
		final parts: Array<String> = [];
		for (i in 0...this.length) parts.push(Std.string(this.get(i)));
		return "[" + parts.join(", ") + "]";
	}
}

private class VectorData<T> {
	var data: Array<T>;
	public var length(default, null): Int;

	public function new(length: Int) {
		this.length = length;
		data = [];
		data.resize(length);
	}

	public function get(index: Int): T {
		return data[index];
	}

	public function set(index: Int, val: T): Void {
		data[index] = val;
	}
}
