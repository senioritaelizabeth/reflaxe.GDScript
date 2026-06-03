package haxe;

class NativeStackTrace {
	@:ifFeature("haxe.NativeStackTrace.exceptionStack")
	public static inline function saveStack(exception: Dynamic): Void {}

	public static inline function exceptionStack(): Array<haxe.StackItem> {
		return [];
	}

	public static inline function callStack(): Array<haxe.StackItem> {
		return [];
	}

	public static function toHaxe(native: Dynamic, skip: Int = 0): Array<haxe.StackItem> {
		return [];
	}
}
