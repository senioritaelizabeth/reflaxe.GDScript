package haxe;

/**
	An iterable which can return a key-value iterator.
**/
typedef KeyValueIterable<K, V> = {
	function keyValueIterator():KeyValueIterator<K, V>;
};
