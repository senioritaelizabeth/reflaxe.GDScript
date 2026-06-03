package haxe.ds;

/**
	A read-only view of an Array.
**/
@:forward(length, iterator, keyValueIterator, map, filter, copy, indexOf, lastIndexOf, contains, join, slice, toString)
abstract ReadOnlyArray<T>(Array<T>) from Array<T> {
	@:op([]) public inline function arrayAccess(index: Int): T {
		return this[index];
	}
}
