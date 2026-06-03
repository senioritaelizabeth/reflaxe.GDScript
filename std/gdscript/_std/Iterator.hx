package;

/**
	An iterator.
**/
typedef Iterator<T> = {
	function hasNext():Bool;
	function next():T;
};
