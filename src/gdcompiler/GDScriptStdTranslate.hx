package gdcompiler;

#if (macro || gdscript_runtime)

/**
	Translates common Haxe std static calls to native GDScript.
	Applied in GDCompiler.callToGDScript when detecting Std.*, Math.*, etc.
**/
class GDScriptStdTranslate {
	// Static method translations: "ClassName.methodName" => "gdscript_code"
	static var staticMethodTranslations: Map<String, String> = [
		// Std
		"Std.string" => "str({arg0})",
		"Std.isOfType" => "(({arg0} as Variant) is {arg1})",
		"Std.int" => "int({arg0})",
		"Std.parseInt" => "{arg0}.to_int()",
		"Std.parseFloat" => "{arg0}.to_float()",
		"Std.random" => "floor(randf() * {arg0})",

		// Math
		"Math.abs" => "abs({arg0})",
		"Math.min" => "min({arg0}, {arg1})",
		"Math.max" => "max({arg0}, {arg1})",
		"Math.sin" => "sin({arg0})",
		"Math.cos" => "cos({arg0})",
		"Math.tan" => "tan({arg0})",
		"Math.asin" => "asin({arg0})",
		"Math.acos" => "acos({arg0})",
		"Math.atan" => "atan({arg0})",
		"Math.atan2" => "atan2({arg0}, {arg1})",
		"Math.exp" => "exp({arg0})",
		"Math.log" => "log({arg0})",
		"Math.pow" => "pow({arg0}, {arg1})",
		"Math.sqrt" => "sqrt({arg0})",
		"Math.floor" => "floor({arg0})",
		"Math.ceil" => "ceil({arg0})",
		"Math.round" => "round({arg0})",
		"Math.sign" => "sign({arg0})",
		"Math.random" => "randf()",
		"Math.isNaN" => "is_nan({arg0})",
		"Math.isFinite" => "is_finite({arg0})",

		// Reflect
		"Reflect.hasField" => "{arg0} in {arg1}",
		"Reflect.field" => "{arg0}.get({arg1})",
		"Reflect.setField" => "{arg0}.set({arg1}, {arg2})",
		"Reflect.callMethod" => "{arg0}.callv({arg1})",
		"Reflect.isFunction" => "({arg0} as Variant) is Callable",
		"Reflect.isObject" => "({arg0} as Variant) is Object",
		"Reflect.fields" => "{arg0}.get_property_list().map(func(x): return x.name)",

		// String
		"String.fromCharCode" => "char({arg0})",
		"String.fromUTF8" => "{arg0}.get_string_from_utf8()",

		// Sys
		"Sys.print" => "print(str({arg0}))",
		"Sys.println" => "print(str({arg0}))",
		"Sys.getEnv" => "OS.get_environment({arg0})",
		"Sys.putEnv" => "OS.set_environment({arg0}, {arg1})",
		"Sys.sleep" => "OS.delay_msec({arg0} * 1000)",
		"Sys.systemName" => "OS.get_name()",
		"Sys.time" => "Time.get_unix_time_from_system()",
		"Sys.cpuTime" => "Time.get_ticks_msec() / 1000.0",
		"Sys.programPath" => "OS.get_executable_path()",
		"Sys.command" => "OS.execute({arg0}, PackedStringArray({arg1}))",
		"Sys.exit" => "get_tree().quit({arg0})",
	];

	// Instance method translations for specific types
	static var stringMethodTranslations: Map<String, String> = [
		"charCodeAt" => "{self}.unicode_at({arg0})",
		"cca" => "{self}.unicode_at({arg0})",
		"charAt" => "{self}[{arg0}]",
		"indexOf" => "{self}.find({arg0})",
		"lastIndexOf" => "{self}.rfind({arg0})",
		"substring" => "{self}.substr({arg0})",
		"toLowerCase" => "{self}.to_lower()",
		"toUpperCase" => "{self}.to_upper()",
		"split" => "{self}.split({arg0})",
		"replace" => "{self}.replace({arg0}, {arg1})",
		"trim" => "{self}.strip()",
		"toString" => "{self}",
	];

	static var arrayMethodTranslations: Map<String, String> = [
		"push" => "{self}.append({arg0})",
		"push_back" => "{self}.append({arg0})",
		"pop" => "{self}.pop_back()",
		"unshift" => "{self}.push_front({arg0})",
		"shift" => "{self}.pop_front()",
		"remove" => "{self}.erase({arg0})",
		"contains" => "{self}.has({arg0})",
		"indexOf" => "{self}.find({arg0})",
		"lastIndexOf" => "{self}.rfind({arg0})",
		"join" => "{self}.join({arg0})",
		"concat" => "{self} + {arg0}",
		"copy" => "{self}.duplicate()",
		"splice" => "{self}.slice({arg0})",
		"insert" => "{self}.insert({arg0}, {arg1})",
		"removeAt" => "{self}.remove_at({arg0})",
		"toString" => "str({self})",
		"length" => "{self}.size()",
		"sort" => "{self}.sort_custom({arg0})",
	];

	public static function translateStaticCall(className: String, methodName: String, args: Array<String>): Null<String> {
		final key = className + "." + methodName;
		if(staticMethodTranslations.exists(key)) {
			return applyArgs(staticMethodTranslations.get(key), args);
		}
		return null;
	}

	public static function translateStringMethod(methodName: String, selfExpr: String, args: Array<String>): Null<String> {
		if(stringMethodTranslations.exists(methodName)) {
			return applySelfArgs(stringMethodTranslations.get(methodName), selfExpr, args);
		}
		return null;
	}

	public static function translateArrayMethod(methodName: String, selfExpr: String, args: Array<String>): Null<String> {
		if(arrayMethodTranslations.exists(methodName)) {
			return applySelfArgs(arrayMethodTranslations.get(methodName), selfExpr, args);
		}
		return null;
	}

	static function applyArgs(template: String, args: Array<String>): String {
		var result = template;
		for(i in 0...args.length) {
			result = StringTools.replace(result, "{arg" + i + "}", args[i]);
		}
		return result;
	}

	static function applySelfArgs(template: String, selfExpr: String, args: Array<String>): String {
		var result = StringTools.replace(template, "{self}", selfExpr);
		for(i in 0...args.length) {
			result = StringTools.replace(result, "{arg" + i + "}", args[i]);
		}
		return result;
	}
}

#end
