package;

/**
	EnumValue is an abstract that represents any enum value in Haxe.
	This is used to type enum values that could be of any enum type.
**/
abstract EnumValue(Dynamic) {
	@:from
	inline static function fromAny(x:Dynamic):EnumValue {
		return cast x;
	}

	@:to
	inline function toDynamic():Dynamic {
		return this;
	}
}
