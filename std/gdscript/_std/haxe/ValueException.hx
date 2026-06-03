package haxe;

class ValueException extends Exception {
	public var value: Dynamic;

	public function new(value: Dynamic, ?previous: Exception, ?native: Any) {
		super(Std.string(value), previous, native);
		this.value = value;
	}

	override public function unwrap(): Dynamic {
		return value;
	}
}
