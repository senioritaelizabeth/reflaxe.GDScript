package haxe;

/**
	A key-value iterator.
**/
typedef KeyValueIterator<K, V> = {
	function hasNext():Bool;
	function next():{key:K, value:V};
};
