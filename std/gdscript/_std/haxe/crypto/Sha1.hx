package haxe.crypto;

class Sha1 {
	public static function encode(s: String): String {
		return make(haxe.io.Bytes.ofString(s));
	}

	public static function make(b: haxe.io.Bytes): String {
		final ctx: Dynamic = untyped __gdscript__("HashingContext.new()");
		untyped __gdscript__("{0}.start(HashingContext.HASH_SHA1)", ctx);
		untyped __gdscript__("{0}.update({1})", ctx, @:privateAccess b.data);
		final result: Dynamic = untyped __gdscript__("{0}.finish()", ctx);
		return untyped __gdscript__("{0}.hex()", result);
	}
}
