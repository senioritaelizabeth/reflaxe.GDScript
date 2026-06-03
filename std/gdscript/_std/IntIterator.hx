package;

/**
	The IntIterator is used for `for (i in a...b)` expressions.
	It iterates from `min` (inclusive) to `max` (exclusive).
**/
class IntIterator {
	var min: Int;
	var max: Int;

	public inline function new(min: Int, max: Int) {
		this.min = min;
		this.max = max;
	}

	public inline function hasNext(): Bool {
		return min < max;
	}

	public inline function next(): Int {
		return min++;
	}
}
