package haxe.crypto;

class Base64 {
	static var CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	static var CHARS_URL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

	public static function encode(bytes: haxe.io.Bytes, complement: Bool = true): String {
		// Use GDScript's Marshalls for base64 encoding if available
		final data: Dynamic = untyped __gdscript__("Marshalls.raw_to_base64({0})", @:privateAccess bytes.data);
		var result: String = Std.string(data);
		if (!complement) {
			// Remove padding
			while (result.length > 0 && result.charAt(result.length - 1) == "=")
				result = result.substr(0, result.length - 1);
		}
		return result;
	}

	public static function decode(str: String, complement: Bool = true): haxe.io.Bytes {
		var s = str;
		if (!complement) {
			// Add padding if needed
			while (s.length % 4 != 0) s += "=";
		}
		final data: Dynamic = untyped __gdscript__("Marshalls.base64_to_raw({0})", s);
		final len: Int = untyped __gdscript__("{0}.size()", data);
		return @:privateAccess new haxe.io.Bytes(len, data);
	}

	public static function encodeString(s: String, complement: Bool = true): String {
		return encode(haxe.io.Bytes.ofString(s), complement);
	}

	public static function decodeString(s: String, complement: Bool = true): String {
		return decode(s, complement).toString();
	}
}
