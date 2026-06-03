package haxe.ds;

private class GenericCell<T> {
	public var elt: T;
	public var next: Null<GenericCell<T>>;

	public function new(elt: T, next: Null<GenericCell<T>>) {
		this.elt = elt;
		this.next = next;
	}
}

class GenericStack<T> {
	public var head: Null<GenericCell<T>>;

	public function new() {
		head = null;
	}

	public function push(item: T): Void {
		head = new GenericCell<T>(item, head);
	}

	public function pop(): Null<T> {
		if (head == null) return null;
		final val = head.elt;
		head = head.next;
		return val;
	}

	public function first(): Null<T> {
		return if (head == null) null else head.elt;
	}

	public function isEmpty(): Bool {
		return head == null;
	}

	public function remove(v: T): Bool {
		var prev: Null<GenericCell<T>> = null;
		var cur = head;
		while (cur != null) {
			if (cur.elt == v) {
				if (prev == null) {
					head = cur.next;
				} else {
					prev.next = cur.next;
				}
				return true;
			}
			prev = cur;
			cur = cur.next;
		}
		return false;
	}

	public function contains(v: T): Bool {
		var cur = head;
		while (cur != null) {
			if (cur.elt == v) return true;
			cur = cur.next;
		}
		return false;
	}

	public function iterator(): Iterator<T> {
		return {
			var cur = head;
			{
				hasNext: function() return cur != null,
				next: function() {
					final val = cur.elt;
					cur = cur.next;
					return val;
				}
			}
		};
	}

	public function toString(): String {
		var result = "";
		var cur = head;
		while (cur != null) {
			result += Std.string(cur.elt);
			if (cur.next != null) result += ", ";
			cur = cur.next;
		}
		return "{" + result + "}";
	}
}
