package;

/**
	The `Lambda` class provides a collection of operations on iterables.
**/
class Lambda {
	public static function array<T>(it: Iterable<T>): Array<T> {
		final result: Array<T> = [];
		for (item in it) result.push(item);
		return result;
	}

	public static function list<T>(it: Iterable<T>): haxe.ds.List<T> {
		final result = new haxe.ds.List<T>();
		for (item in it) result.add(item);
		return result;
	}

	public static function map<T, S>(it: Iterable<T>, f: T -> S): haxe.ds.List<S> {
		final result = new haxe.ds.List<S>();
		for (item in it) result.add(f(item));
		return result;
	}

	public static function mapi<T, S>(it: Iterable<T>, f: Int -> T -> S): haxe.ds.List<S> {
		final result = new haxe.ds.List<S>();
		var i = 0;
		for (item in it) {
			result.add(f(i, item));
			i++;
		}
		return result;
	}

	public static function filter<T>(it: Iterable<T>, f: T -> Bool): haxe.ds.List<T> {
		final result = new haxe.ds.List<T>();
		for (item in it) if (f(item)) result.add(item);
		return result;
	}

	public static function fold<T, S>(it: Iterable<T>, f: T -> S -> S, first: S): S {
		for (item in it) first = f(item, first);
		return first;
	}

	public static function foreach<T>(it: Iterable<T>, f: T -> Bool): Bool {
		for (item in it) if (!f(item)) return false;
		return true;
	}

	public static function iter<T>(it: Iterable<T>, f: T -> Void): Void {
		for (item in it) f(item);
	}

	public static function exists<T>(it: Iterable<T>, f: T -> Bool): Bool {
		for (item in it) if (f(item)) return true;
		return false;
	}

	public static function has<T>(it: Iterable<T>, elt: T): Bool {
		for (item in it) if (item == elt) return true;
		return false;
	}

	public static function indexOf<T>(it: Iterable<T>, v: T): Int {
		var i = 0;
		for (item in it) {
			if (item == v) return i;
			i++;
		}
		return -1;
	}

	public static function find<T>(it: Iterable<T>, f: T -> Bool): Null<T> {
		for (item in it) if (f(item)) return item;
		return null;
	}

	public static function findIndex<T>(it: Iterable<T>, f: T -> Bool): Int {
		var i = 0;
		for (item in it) {
			if (f(item)) return i;
			i++;
		}
		return -1;
	}

	public static function count<T>(it: Iterable<T>, ?f: T -> Bool): Int {
		var n = 0;
		if (f == null) {
			for (_ in it) n++;
		} else {
			for (item in it) if (f(item)) n++;
		}
		return n;
	}

	public static function isEmpty<T>(it: Iterable<T>): Bool {
		for (_ in it) return false;
		return true;
	}

	public static function concat<T>(a: Iterable<T>, b: Iterable<T>): haxe.ds.List<T> {
		final result = new haxe.ds.List<T>();
		for (item in a) result.add(item);
		for (item in b) result.add(item);
		return result;
	}

	public static function flatten<T>(it: Iterable<Iterable<T>>): haxe.ds.List<T> {
		final result = new haxe.ds.List<T>();
		for (inner in it)
			for (item in inner)
				result.add(item);
		return result;
	}

	public static function flatMap<T, S>(it: Iterable<T>, f: T -> Iterable<S>): haxe.ds.List<S> {
		return flatten(map(it, f));
	}
}
