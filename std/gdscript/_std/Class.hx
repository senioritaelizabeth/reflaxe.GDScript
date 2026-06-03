package;

/**
	Class is an abstract type representing a class type in Haxe.
	Used for reflection and dynamic class instantiation.
**/
abstract Class<T:Dynamic>(Dynamic) {
	@:from
	inline static function fromAny<T>(x:Dynamic):Class<T> {
		return cast x;
	}

	@:to
	inline function toDynamic():Dynamic {
		return this;
	}
}
