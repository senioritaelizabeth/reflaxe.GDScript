package haxe.ds;

/**
	HashMap uses `hashCode()` and `equals()` methods on the key type.
	Falls back to ObjectMap-like behavior via gdscript.Dictionary.
**/
class HashMap<K: { function hashCode(): Int; function equals(other: K): Bool; }, V>
	implements haxe.Constraints.IMap<K, V> {

	// We use a Dictionary<Int, Array<{k:K, v:V}>> to handle collisions.
	var buckets: gdscript.Dictionary<Int, Array<{ k: K, v: V }>>;

	public function new(): Void {
		buckets = new gdscript.Dictionary<Int, Array<{ k: K, v: V }>>();
	}

	public function set(key: K, value: V): Void {
		final hash = key.hashCode();
		if (buckets.has(hash)) {
			final bucket = buckets.get(hash);
			for (entry in bucket) {
				if (entry.k.equals(key)) {
					entry.v = value;
					return;
				}
			}
			bucket.push({ k: key, v: value });
		} else {
			buckets.set(hash, [{ k: key, v: value }]);
		}
	}

	public function get(key: K): Null<V> {
		final hash = key.hashCode();
		if (!buckets.has(hash)) return null;
		for (entry in buckets.get(hash)) {
			if (entry.k.equals(key)) return entry.v;
		}
		return null;
	}

	public function exists(key: K): Bool {
		final hash = key.hashCode();
		if (!buckets.has(hash)) return false;
		for (entry in buckets.get(hash)) {
			if (entry.k.equals(key)) return true;
		}
		return false;
	}

	public function remove(key: K): Bool {
		final hash = key.hashCode();
		if (!buckets.has(hash)) return false;
		final bucket = buckets.get(hash);
		for (i in 0...bucket.length) {
			if (bucket[i].k.equals(key)) {
				bucket.splice(i, 1);
				if (bucket.length == 0) buckets.erase(hash);
				return true;
			}
		}
		return false;
	}

	public function keys(): Iterator<K> {
		final result: Array<K> = [];
		for (bucket in buckets.values()) {
			for (entry in bucket) result.push(entry.k);
		}
		return result.iterator();
	}

	public function iterator(): Iterator<V> {
		final result: Array<V> = [];
		for (bucket in buckets.values()) {
			for (entry in bucket) result.push(entry.v);
		}
		return result.iterator();
	}

	@:runtime public inline function keyValueIterator(): KeyValueIterator<K, V> {
		return new haxe.iterators.MapKeyValueIterator(this);
	}

	public function copy(): HashMap<K, V> {
		final result = new HashMap<K, V>();
		for (key => value in this) result.set(key, value);
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
		buckets.clear();
	}
}
