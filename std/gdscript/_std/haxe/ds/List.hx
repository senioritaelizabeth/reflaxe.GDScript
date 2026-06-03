package haxe.ds;

private class ListNode<T> {
	public var value: T;
	public var next: Null<ListNode<T>>;
	public var prev: Null<ListNode<T>>;

	public function new(value: T, prev: Null<ListNode<T>>, next: Null<ListNode<T>>) {
		this.value = value;
		this.prev = prev;
		this.next = next;
	}
}

class List<T> {
	private var head: Null<ListNode<T>>;
	private var tail: Null<ListNode<T>>;
	public var length(default, null): Int;

	public function new() {
		length = 0;
	}

	public function add(item: T): Void {
		final node = new ListNode(item, tail, null);
		if (tail != null) {
			tail.next = node;
		} else {
			head = node;
		}
		tail = node;
		length++;
	}

	public function push(item: T): Void {
		final node = new ListNode(item, null, head);
		if (head != null) {
			head.prev = node;
		} else {
			tail = node;
		}
		head = node;
		length++;
	}

	public function first(): Null<T> {
		return if (head != null) head.value else null;
	}

	public function last(): Null<T> {
		return if (tail != null) tail.value else null;
	}

	public function pop(): Null<T> {
		if (head == null) return null;
		final val = head.value;
		head = head.next;
		if (head != null) {
			head.prev = null;
		} else {
			tail = null;
		}
		length--;
		return val;
	}

	public function isEmpty(): Bool {
		return head == null;
	}

	public function clear(): Void {
		head = null;
		tail = null;
		length = 0;
	}

	public function remove(v: T): Bool {
		var node = head;
		while (node != null) {
			if (node.value == v) {
				if (node.prev != null) {
					node.prev.next = node.next;
				} else {
					head = node.next;
				}
				if (node.next != null) {
					node.next.prev = node.prev;
				} else {
					tail = node.prev;
				}
				length--;
				return true;
			}
			node = node.next;
		}
		return false;
	}

	public function contains(v: T): Bool {
		var node = head;
		while (node != null) {
			if (node.value == v) return true;
			node = node.next;
		}
		return false;
	}

	public function iterator(): Iterator<T> {
		return {
			var cur = head;
			{
				hasNext: function() return cur != null,
				next: function() {
					final val = cur.value;
					cur = cur.next;
					return val;
				}
			}
		};
	}

	public function keyValueIterator(): KeyValueIterator<Int, T> {
		return {
			var cur = head;
			var idx = 0;
			{
				hasNext: function() return cur != null,
				next: function() {
					final val = { key: idx, value: cur.value };
					cur = cur.next;
					idx++;
					return val;
				}
			}
		};
	}

	public function filter(f: T -> Bool): List<T> {
		final result = new List<T>();
		var node = head;
		while (node != null) {
			if (f(node.value)) result.add(node.value);
			node = node.next;
		}
		return result;
	}

	public function map<X>(f: T -> X): List<X> {
		final result = new List<X>();
		var node = head;
		while (node != null) {
			result.add(f(node.value));
			node = node.next;
		}
		return result;
	}

	public function join(sep: String): String {
		var result = "";
		var first = true;
		var node = head;
		while (node != null) {
			if (!first) result += sep;
			result += Std.string(node.value);
			first = false;
			node = node.next;
		}
		return result;
	}

	public function toString(): String {
		return "{" + join(",") + "}";
	}
}
