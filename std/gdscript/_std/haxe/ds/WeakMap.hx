package haxe.ds;

/**
	WeakMap for the GDScript target.
	Note: GDScript doesn't support weak references natively, so this
	behaves as a regular ObjectMap. Objects won't be garbage collected
	while they remain in this map.
**/
class WeakMap<K: {}, V> implements haxe.Constraints.IMap<K, V> {
	var m: gdscript.Dictionary<K, V>;

	public function new(): Void {
		m = new gdscript.Dictionary<K, V>();
	}

	public function set(key: K, value: V): Void {
		m.set(key, value);
	}

	public function get(key: K): Null<V> {
		return if (m.has(key)) m.get(key) else null;
	}

	public function exists(key: K): Bool {
		return m.has(key);
	}

	public function remove(key: K): Bool {
		return m.erase(key);
	}

	public function keys(): Iterator<K> {
		return m.keys().iterator();
	}

	public function iterator(): Iterator<V> {
		return m.values().iterator();
	}

	@:runtime public inline function keyValueIterator(): KeyValueIterator<K, V> {
		return new haxe.iterators.MapKeyValueIterator(this);
	}

	public function copy(): WeakMap<K, V> {
		final result = new WeakMap<K, V>();
		result.m = m.duplicate(false);
		return result;
	}

	public function toString(): String {
		var result = "[";
		var first = true;
		for (key => value in this) {
			result += (first ? "" : ", ") + (Std.string(key) + " => " + Std.string(value));
			if (first) first = false;
		}
		return result + "]";
	}

	public function clear(): Void {
		m.clear();
	}
}
