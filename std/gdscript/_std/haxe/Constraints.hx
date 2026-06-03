package haxe;

/**
	The Constraints module contains used for constraining type parameters.
**/
interface IMap<K, V> {
	function get(k:K):Null<V>;
	function set(k:K, v:V):Void;
	function exists(k:K):Bool;
	function remove(k:K):Bool;
	function keys():Iterator<K>;
	function iterator():Iterator<V>;
	function keyValueIterator():KeyValueIterator<K, V>;
	function copy():IMap<K, V>;
	function clear():Void;
	function toString():String;
}

typedef Function = Dynamic;

class Constraints {
	/**
		A type that can be used as a key in generic associative arrays.
	**/
	public static inline function isEnumValue<T>(v:T):Bool {
		return true;
	}

	/**
		Used as a type constraint to mark that a type parameter must be a Class.
	**/
	#if false
	typedef Class<T:Dynamic> = Class<T>;
	#end
}
