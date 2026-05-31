package;

/**
	GDScript implementation of Haxe's Lambda class.
**/
class Lambda {
	public static function array<A>(it: Iterable<A>): Array<A> {
		final result = [];
		for(x in it) result.push(x);
		return result;
	}

	public static function list<A>(it: Iterable<A>): List<A> {
		final result = new List<A>();
		for(x in it) result.push(x);
		return result;
	}

	public static function map<A, B>(it: Iterable<A>, f: A -> B): List<B> {
		final result = new List<B>();
		for(x in it) result.push(f(x));
		return result;
	}

	public static function has<A>(it: Iterable<A>, elt: A, ?cmp: (A, A) -> Bool): Bool {
		if(cmp == null) {
			for(x in it) if(x == elt) return true;
		} else {
			for(x in it) if(cmp(x, elt)) return true;
		}
		return false;
	}

	public static function exists<A>(it: Iterable<A>, f: A -> Bool): Bool {
		for(x in it) if(f(x)) return true;
		return false;
	}

	public static function forEach<A>(it: Iterable<A>, f: A -> Void): Void {
		for(x in it) f(x);
	}

	public static function fold<A, B>(it: Iterable<A>, f: (A, B) -> B, first: B): B {
		var result = first;
		for(x in it) result = f(x, result);
		return result;
	}

	public static function filter<A>(it: Iterable<A>, f: A -> Bool): List<A> {
		final result = new List<A>();
		for(x in it) if(f(x)) result.push(x);
		return result;
	}

	public static function empty<A>(it: Iterable<A>): Bool {
		return !it.iterator().hasNext();
	}

	public static function count<A>(it: Iterable<A>, ?f: A -> Bool): Int {
		var result = 0;
		if(f == null) {
			for(_ in it) result++;
		} else {
			for(x in it) if(f(x)) result++;
		}
		return result;
	}

	public static function concat<A>(it1: Iterable<A>, it2: Iterable<A>): List<A> {
		final result = new List<A>();
		for(x in it1) result.push(x);
		for(x in it2) result.push(x);
		return result;
	}
}
