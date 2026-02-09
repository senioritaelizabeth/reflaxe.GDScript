package;

class Date {
	private var timestamp:Float;

	public function new(year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int) {
		var dict = untyped __gdscript__("{
			'year': {0},
			'month': {1},
			'day': {2},
			'hour': {3},
			'minute': {4},
			'second': {5}
		}", year, month
			+ 1, day, hour, minute, second);
		timestamp = untyped __gdscript__("Time.get_unix_time_from_datetime_dict({0})", dict);
	}

	public static function now():Date {
		var d = new Date(1970, 0, 1, 0, 0, 0);
		d.timestamp = untyped __gdscript__("Time.get_unix_time_from_system()");
		return d;
	}

	public static function fromTime(t:Float):Date {
		var d = new Date(1970, 0, 1, 0, 0, 0);
		d.timestamp = t / 1000.0;
		return d;
	}

	public static function fromString(s:String):Date {
		var parts = s.split(" ");
		var dateParts = parts[0].split("-");
		var year = Std.parseInt(dateParts[0]);
		var month = Std.parseInt(dateParts[1]) - 1;
		var day = Std.parseInt(dateParts[2]);

		var hour = 0;
		var minute = 0;
		var second = 0;

		if (parts.length > 1) {
			var timeParts = parts[1].split(":");
			hour = Std.parseInt(timeParts[0]);
			minute = Std.parseInt(timeParts[1]);
			if (timeParts.length > 2) {
				second = Std.parseInt(timeParts[2]);
			}
		}

		return new Date(year, month, day, hour, minute, second);
	}

	public function getTime():Float {
		return timestamp * 1000.0;
	}

	private function getDateDict():Dynamic {
		return untyped __gdscript__("Time.get_datetime_dict_from_unix_time({0})", timestamp);
	}

	public function getFullYear():Int {
		return untyped getDateDict().year;
	}

	public function getMonth():Int {
		return untyped getDateDict().month - 1;
	}

	public function getDate():Int {
		return untyped getDateDict().day;
	}

	public function getHours():Int {
		return untyped getDateDict().hour;
	}

	public function getMinutes():Int {
		return untyped getDateDict().minute;
	}

	public function getSeconds():Int {
		return untyped getDateDict().second;
	}

	public function getDay():Int {
		return untyped getDateDict().weekday;
	}

	public function toString():String {
		var dict = getDateDict();
		var year = untyped dict.year;
		var month = untyped dict.month;
		var day = untyped dict.day;
		var hour = untyped dict.hour;
		var minute = untyped dict.minute;
		var second = untyped dict.second;

		return untyped __gdscript__('"%04d-%02d-%02d %02d:%02d:%02d" % [{0}, {1}, {2}, {3}, {4}, {5}]', year, month, day, hour, minute, second);
	}
}
