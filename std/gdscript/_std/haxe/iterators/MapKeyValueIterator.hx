package haxe.iterators;

class MapKeyValueIterator<K, V> {
	var map: haxe.Constraints.IMap<K, V>;
	var keys: Iterator<K>;

	public inline function new(map: haxe.Constraints.IMap<K, V>) {
		this.map = map;
		this.keys = map.keys();
	}

	public inline function hasNext(): Bool {
		return keys.hasNext();
	}

	public inline function next(): { key: K, value: V } {
		final k = keys.next();
		return { key: k, value: map.get(k) };
	}
}
