package haxe;

class Json {
	public static function parse(text: String): Dynamic {
		return untyped __gdscript__("JSON.parse_string({0})", text);
	}

	public static function stringify(value: Dynamic, ?replacer: Dynamic -> String -> Dynamic, ?space: String): String {
		// GDScript's JSON.stringify supports indent but not a replacer function.
		final indent = space == null ? "" : space;
		return untyped __gdscript__("JSON.stringify({0}, {1})", value, indent);
	}
}
