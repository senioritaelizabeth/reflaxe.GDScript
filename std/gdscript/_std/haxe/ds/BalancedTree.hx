package haxe.ds;

private class TreeNode<K, V> {
	public var k: K;
	public var v: V;
	public var left: Null<TreeNode<K, V>>;
	public var right: Null<TreeNode<K, V>>;
	public var height: Int;

	public function new(k: K, v: V, left: Null<TreeNode<K, V>>, right: Null<TreeNode<K, V>>) {
		this.k = k;
		this.v = v;
		this.left = left;
		this.right = right;
		this.height = 1 + (left == null ? 0 : left.height) > (right == null ? 0 : right.height)
			? 1 + (left == null ? 0 : left.height)
			: 1 + (right == null ? 0 : right.height);
	}
}

class BalancedTree<K, V> implements haxe.Constraints.IMap<K, V> {
	var root: Null<TreeNode<K, V>>;

	public function new() {
		root = null;
	}

	public function set(key: K, value: V): Void {
		root = setNode(root, key, value);
	}

	public function get(key: K): Null<V> {
		var node = root;
		while (node != null) {
			final c = compare(key, node.k);
			if (c < 0) node = node.left;
			else if (c > 0) node = node.right;
			else return node.v;
		}
		return null;
	}

	public function exists(key: K): Bool {
		return get(key) != null;
	}

	public function remove(key: K): Bool {
		if (!exists(key)) return false;
		root = removeNode(root, key);
		return true;
	}

	public function keys(): Iterator<K> {
		final keys: Array<K> = [];
		collectKeys(root, keys);
		return keys.iterator();
	}

	public function iterator(): Iterator<V> {
		final values: Array<V> = [];
		collectValues(root, values);
		return values.iterator();
	}

	@:runtime public inline function keyValueIterator(): KeyValueIterator<K, V> {
		return new haxe.iterators.MapKeyValueIterator(this);
	}

	public function copy(): BalancedTree<K, V> {
		final result = new BalancedTree<K, V>();
		for (key => value in this) result.set(key, value);
		return result;
	}

	public function toString(): String {
		var result = "[";
		var first = true;
		for (key => value in this) {
			result += (first ? "" : ", ") + (Std.string(key) + " => " + Std.string(value));
			if (first) first = false;
		}
		return result + "]";
	}

	public function clear(): Void {
		root = null;
	}

	private function compare(a: K, b: K): Int {
		return Reflect.compare(a, b);
	}

	private function setNode(node: Null<TreeNode<K, V>>, key: K, value: V): TreeNode<K, V> {
		if (node == null) return new TreeNode<K, V>(key, value, null, null);
		final c = compare(key, node.k);
		if (c < 0) {
			return balance(new TreeNode<K, V>(node.k, node.v, setNode(node.left, key, value), node.right));
		} else if (c > 0) {
			return balance(new TreeNode<K, V>(node.k, node.v, node.left, setNode(node.right, key, value)));
		} else {
			return new TreeNode<K, V>(key, value, node.left, node.right);
		}
	}

	private function removeNode(node: Null<TreeNode<K, V>>, key: K): Null<TreeNode<K, V>> {
		if (node == null) return null;
		final c = compare(key, node.k);
		if (c < 0) {
			return balance(new TreeNode<K, V>(node.k, node.v, removeNode(node.left, key), node.right));
		} else if (c > 0) {
			return balance(new TreeNode<K, V>(node.k, node.v, node.left, removeNode(node.right, key)));
		} else {
			if (node.left == null) return node.right;
			if (node.right == null) return node.left;
			var minNode = node.right;
			while (minNode.left != null) minNode = minNode.left;
			return balance(new TreeNode<K, V>(minNode.k, minNode.v, node.left, removeMin(node.right)));
		}
	}

	private function removeMin(node: TreeNode<K, V>): Null<TreeNode<K, V>> {
		if (node.left == null) return node.right;
		return balance(new TreeNode<K, V>(node.k, node.v, removeMin(node.left), node.right));
	}

	private function height(node: Null<TreeNode<K, V>>): Int {
		return if (node == null) 0 else node.height;
	}

	private function balance(node: TreeNode<K, V>): TreeNode<K, V> {
		final lh = height(node.left);
		final rh = height(node.right);
		if (lh > rh + 1) {
			final left = node.left;
			if (height(left.left) >= height(left.right)) {
				return rotateRight(node);
			} else {
				return rotateRight(new TreeNode<K, V>(node.k, node.v, rotateLeft(left), node.right));
			}
		} else if (rh > lh + 1) {
			final right = node.right;
			if (height(right.right) >= height(right.left)) {
				return rotateLeft(node);
			} else {
				return rotateLeft(new TreeNode<K, V>(node.k, node.v, node.left, rotateRight(right)));
			}
		}
		return new TreeNode<K, V>(node.k, node.v, node.left, node.right);
	}

	private function rotateLeft(node: TreeNode<K, V>): TreeNode<K, V> {
		final right = node.right;
		return new TreeNode<K, V>(right.k, right.v, new TreeNode<K, V>(node.k, node.v, node.left, right.left), right.right);
	}

	private function rotateRight(node: TreeNode<K, V>): TreeNode<K, V> {
		final left = node.left;
		return new TreeNode<K, V>(left.k, left.v, left.left, new TreeNode<K, V>(node.k, node.v, left.right, node.right));
	}

	private function collectKeys(node: Null<TreeNode<K, V>>, acc: Array<K>): Void {
		if (node == null) return;
		collectKeys(node.left, acc);
		acc.push(node.k);
		collectKeys(node.right, acc);
	}

	private function collectValues(node: Null<TreeNode<K, V>>, acc: Array<V>): Void {
		if (node == null) return;
		collectValues(node.left, acc);
		acc.push(node.v);
		collectValues(node.right, acc);
	}
}
