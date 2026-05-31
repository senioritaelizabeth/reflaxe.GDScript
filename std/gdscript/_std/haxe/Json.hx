package haxe;

/**
	GDScript implementation of haxe.Json.
	Uses Godot's JSON class.
**/
@:nativeGen
class Json {
	public static function parse(text: String, ?reviver: (Dynamic, Dynamic) -> Dynamic): Dynamic {
		if(reviver != null) {
			throw "haxe.Json.parse: reviver function is not supported in GDScript.";
		}
		return untyped __gdscript__("JSON.parse_string({0})", text);
	}

	public static function stringify(data: Dynamic, ?replacer: (Dynamic, Dynamic) -> Dynamic, ?space: String): String {
		if(replacer != null) {
			throw "haxe.Json.stringify: replacer function is not supported in GDScript.";
		}
		if(space != null) {
			return untyped __gdscript__("JSON.stringify({0}, \"\", {1})", data, space);
		}
		return untyped __gdscript__("JSON.stringify({0})", data);
	}
}
