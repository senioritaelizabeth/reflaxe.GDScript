package;

/**
	Enum is an abstract type representing an enum type in Haxe.
	Used for reflection and dynamic enum instantiation.
**/
abstract Enum<T:Dynamic>(Dynamic) {
	@:from
	inline static function fromAny<T>(x:Dynamic):Enum<T> {
		return cast x;
	}

	@:to
	inline function toDynamic():Dynamic {
		return this;
	}
}
