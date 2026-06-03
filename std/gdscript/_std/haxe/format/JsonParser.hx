package haxe.format;

class JsonParser {
	var str: String;
	var pos: Int;

	public function new(str: String) {
		this.str = str;
		this.pos = 0;
	}

	public static function parse(str: String): Dynamic {
		// Delegate to GDScript's built-in JSON for speed
		return untyped __gdscript__("JSON.parse_string({0})", str);
	}
}
