package;

class DateTools {
	public static function delta(d: Date, t: Float): Date {
		return Date.fromTime(d.getTime() + t);
	}

	public static inline function seconds(n: Float): Float {
		return n * 1000.0;
	}

	public static inline function minutes(n: Float): Float {
		return n * 60.0 * 1000.0;
	}

	public static inline function hours(n: Float): Float {
		return n * 60.0 * 60.0 * 1000.0;
	}

	public static inline function days(n: Float): Float {
		return n * 24.0 * 60.0 * 60.0 * 1000.0;
	}

	public static function make(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0): Float {
		return new Date(year, month, day, hour, minute, second).getTime();
	}

	public static function format(d: Date, f: String): String {
		var result = "";
		var i = 0;
		while (i < f.length) {
			final c = f.charAt(i);
			if (c == "%") {
				i++;
				result += switch f.charAt(i) {
					case "Y": StringTools.lpad(Std.string(d.getFullYear()), "0", 4);
					case "m": StringTools.lpad(Std.string(d.getMonth() + 1), "0", 2);
					case "d": StringTools.lpad(Std.string(d.getDate()), "0", 2);
					case "H": StringTools.lpad(Std.string(d.getHours()), "0", 2);
					case "M": StringTools.lpad(Std.string(d.getMinutes()), "0", 2);
					case "S": StringTools.lpad(Std.string(d.getSeconds()), "0", 2);
					case "e": StringTools.lpad(Std.string(d.getDate()), " ", 2);
					case "k": StringTools.lpad(Std.string(d.getHours()), " ", 2);
					case "l": StringTools.lpad(Std.string(d.getHours() % 12 == 0 ? 12 : d.getHours() % 12), " ", 2);
					case "I": StringTools.lpad(Std.string(d.getHours() % 12 == 0 ? 12 : d.getHours() % 12), "0", 2);
					case "p": d.getHours() < 12 ? "AM" : "PM";
					case "P": d.getHours() < 12 ? "am" : "pm";
					case "n": "\n";
					case "t": "\t";
					case "%": "%";
					case s: "%" + s;
				};
			} else {
				result += c;
			}
			i++;
		}
		return result;
	}

	public static function getMonthDays(d: Date): Int {
		final month = d.getMonth();
		final year = d.getFullYear();
		return switch month {
			case 0, 2, 4, 6, 7, 9, 11: 31;
			case 3, 5, 8, 10: 30;
			case 1: ((year % 4 == 0) && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
			case _: throw "Invalid month " + month;
		};
	}
}
