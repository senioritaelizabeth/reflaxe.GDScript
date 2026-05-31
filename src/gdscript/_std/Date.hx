package;

/**
	GDScript implementation of Haxe's Date class.
	Uses Godot's Time and DateTime APIs.
**/
#if !macro
@:coreApi
#end
@:nativeTypeCode("Dictionary")
class Date {
	public var fullYear(default, null): Int;
	public var month(default, null): Int;
	public var date(default, null): Int;
	public var hours(default, null): Int;
	public var minutes(default, null): Int;
	public var seconds(default, null): Int;

	var __timestamp: Float;

	public function new(year: Int, month: Int, date: Int, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
		full_year = year;
		this.month = month;
		this.date = date;
		this.hours = hours;
		this.minutes = minutes;
		this.seconds = seconds;
		__timestamp = untyped __gdscript__("Time.get_unix_time_from_datetime_dict({{year: {0}, month: {1}, day: {2}, hour: {3}, minute: {4}, second: {5}}})", year, month + 1, date, hours, minutes, seconds);
	}

	public static function now(): Date {
		final ts = untyped __gdscript__("Time.get_unix_time_from_system()");
		return fromDate(ts);
	}

	public static function fromTime(t: Float): Date {
		return fromDate(t);
	}

	public static function fromString(str: String): Date {
		final dict = untyped __gdscript__("Time.get_datetime_dict_from_datetime_string({0}, false)", str);
		final ts = untyped __gdscript__("Time.get_unix_time_from_datetime_dict({0})", dict);
		return fromDate(ts);
	}

	static function fromDate(ts: Float): Date {
		final dict = untyped __gdscript__("Time.get_datetime_dict_from_unix_time({0})", ts);
		final d = new Date(dict.year, dict.month - 1, dict.day, dict.hour, dict.minute, dict.second);
		d.__timestamp = ts;
		return d;
	}

	public function getTime(): Float {
		return __timestamp;
	}

	public function getFullYear(): Int {
		return full_year;
	}

	public function getMonth(): Int {
		return month;
	}

	public function getDate(): Int {
		return date;
	}

	public function getHours(): Int {
		return hours;
	}

	public function getMinutes(): Int {
		return minutes;
	}

	public function getSeconds(): Int {
		return seconds;
	}

	public function getDay(): Int {
		final dict = untyped __gdscript__("Time.get_datetime_dict_from_unix_time({0})", __timestamp);
		return dict.weekday - 1;
	}

	public function toString(): String {
		return untyped __gdscript__("Time.get_datetime_string_from_unix_time({0})", __timestamp);
	}
}
