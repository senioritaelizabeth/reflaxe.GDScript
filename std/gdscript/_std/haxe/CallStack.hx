package haxe;

typedef StackItem = haxe.StackItem;

enum StackItem {
	CFunction;
	Module(m: String);
	FilePos(s: Null<StackItem>, file: String, line: Int, ?column: Int);
	Method(classname: Null<String>, method: String);
	LocalFunction(?v: Int);
}

/**
	Call stack access. GDScript doesn't expose a usable call stack to user code,
	so most functions return empty/stub data.
**/
class CallStack {
	public static function callStack(): Array<StackItem> {
		return [];
	}

	public static function exceptionStack(): Array<StackItem> {
		return [];
	}

	@:deprecated("Use exceptionStack() instead")
	public static function catchStack(): Array<StackItem> {
		return [];
	}

	public static function toString(stack: Array<StackItem>): String {
		var result = "";
		var i = stack.length;
		while (--i >= 0) {
			final item = stack[i];
			result += "\nCalled from ";
			result += itemToString(item);
		}
		return result;
	}

	static function itemToString(item: StackItem): String {
		return switch item {
			case CFunction: "a C function";
			case Module(m): "module " + m;
			case FilePos(itm, file, line, col):
				(itm == null ? "" : itemToString(itm) + " ") + file + ":" + line + (col == null ? "" : ":" + col);
			case Method(classname, method):
				(classname == null ? "" : classname + ".") + method + "()";
			case LocalFunction(v):
				"local function #" + (v == null ? "?" : Std.string(v));
		};
	}
}
