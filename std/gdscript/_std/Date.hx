package;

/**
	`Date` provides date/time functionality backed by GDScript's `Time` singleton.
**/
class Date {
	// Stored as Unix timestamp in seconds (Float for sub-second precision)
	private var t: Float;

	public function new(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) {
		// month is 0-based in Haxe, 1-based in GDScript
		final dict: Dynamic = untyped __gdscript__("{\"year\": {0}, \"month\": {1}, \"day\": {2}, \"hour\": {3}, \"minute\": {4}, \"second\": {5}}",
			year, month + 1, day, hour, min, sec);
		t = untyped __gdscript__("Time.get_unix_time_from_datetime_dict({0})", dict);
	}

	private static function fromTime(stamp: Float): Date {
		final d = new Date(1970, 0, 1, 0, 0, 0);
		d.t = stamp;
		return d;
	}

	public static function now(): Date {
		final d = new Date(1970, 0, 1, 0, 0, 0);
		d.t = untyped __gdscript__("Time.get_unix_time_from_system()");
		return d;
	}

	public static function fromTime(t: Float): Date {
		final d = new Date(1970, 0, 1, 0, 0, 0);
		d.t = t / 1000.0; // Haxe uses milliseconds
		return d;
	}

	public static function fromString(s: String): Date {
		// Expected: "YYYY-MM-DD HH:MM:SS"
		final parts = s.split(" ");
		final dateParts = parts[0].split("-");
		final timeParts = parts.length > 1 ? parts[1].split(":") : ["0", "0", "0"];
		return new Date(
			Std.parseInt(dateParts[0]),
			Std.parseInt(dateParts[1]) - 1,
			Std.parseInt(dateParts[2]),
			Std.parseInt(timeParts[0]),
			Std.parseInt(timeParts[1]),
			Std.parseInt(timeParts[2])
		);
	}

	private function getDict(): Dynamic {
		return untyped __gdscript__("Time.get_datetime_dict_from_unix_time(int({0}))", t);
	}

	public function getTime(): Float {
		return t * 1000.0; // Haxe returns milliseconds
	}

	public function getFullYear(): Int {
		return untyped __gdscript__("{0}[\"year\"]", getDict());
	}

	public function getMonth(): Int {
		// Haxe months are 0-based
		return (untyped __gdscript__("{0}[\"month\"]", getDict()) : Int) - 1;
	}

	public function getDate(): Int {
		return untyped __gdscript__("{0}[\"day\"]", getDict());
	}

	public function getDay(): Int {
		// weekday: 0=Sunday in Haxe, GDScript weekday: 0=Sunday too
		return untyped __gdscript__("{0}[\"weekday\"]", getDict());
	}

	public function getHours(): Int {
		return untyped __gdscript__("{0}[\"hour\"]", getDict());
	}

	public function getMinutes(): Int {
		return untyped __gdscript__("{0}[\"minute\"]", getDict());
	}

	public function getSeconds(): Int {
		return untyped __gdscript__("{0}[\"second\"]", getDict());
	}

	public function getTimezoneOffset(): Int {
		return 0; // GDScript always returns UTC
	}

	public function toString(): String {
		final d = getDict();
		final yr  = Std.string(untyped __gdscript__("{0}[\"year\"]", d));
		final mo  = StringTools.lpad(Std.string((untyped __gdscript__("{0}[\"month\"]", d) : Int)), "0", 2);
		final dy  = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"day\"]", d)), "0", 2);
		final hr  = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"hour\"]", d)), "0", 2);
		final mn  = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"minute\"]", d)), "0", 2);
		final sc  = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"second\"]", d)), "0", 2);
		return '$yr-$mo-$dy $hr:$mn:$sc';
	}

	public function toDateString(): String {
		final d = getDict();
		final yr = Std.string(untyped __gdscript__("{0}[\"year\"]", d));
		final mo = StringTools.lpad(Std.string((untyped __gdscript__("{0}[\"month\"]", d) : Int)), "0", 2);
		final dy = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"day\"]", d)), "0", 2);
		return '$yr-$mo-$dy';
	}

	public function toTimeString(): String {
		final d = getDict();
		final hr = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"hour\"]", d)), "0", 2);
		final mn = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"minute\"]", d)), "0", 2);
		final sc = StringTools.lpad(Std.string(untyped __gdscript__("{0}[\"second\"]", d)), "0", 2);
		return '$hr:$mn:$sc';
	}
}
