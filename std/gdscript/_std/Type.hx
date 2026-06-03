package;

enum ValueType {
	TNull;
	TInt;
	TFloat;
	TBool;
	TObject;
	TFunction;
	TClass(c:Class<Dynamic>);
	TEnum(e:Enum<Dynamic>);
	TUnknown;
}

class Type {
	public static function getClass<T>(o:T):Null<Class<T>> {
		if (o == null)
			return null;
		return untyped __gdscript__("{0}.get_script()", o);
	}

	public static function getEnum(o:EnumValue):Null<Enum<Dynamic>> {
		if (o == null)
			return null;
		return untyped __gdscript__("{0}.get(\"__type__\")", o);
	}

	public static function getSuperClass(c:Class<Dynamic>):Null<Class<Dynamic>> {
		return null;
	}

	public static function getClassName(c:Class<Dynamic>):String {
		return Std.string(c);
	}

	public static function getEnumName(e:Enum<Dynamic>):String {
		return Std.string(e);
	}

	public static function resolveClass(name:String):Null<Class<Dynamic>> {
		return null;
	}

	public static function resolveEnum(name:String):Null<Enum<Dynamic>> {
		return null;
	}

	public static function createInstance<T>(cl:Class<T>, args:Array<Dynamic>):T {
		return untyped __gdscript__("{0}.new.callv({1})", cl, args);
	}

	public static function createEmptyInstance<T>(cl:Class<T>):T {
		return untyped __gdscript__("{0}.new()", cl);
	}

	public static function createEnum<T>(e:Enum<T>, constr:String, ?params:Array<Dynamic>):T {
		final ctor = untyped __gdscript__("{0}.get(\"_constructors\").get({1})", e, constr);
		if (params == null || params.length == 0) {
			return untyped __gdscript__("{0}.call()", ctor);
		}
		return untyped __gdscript__("{0}.callv({1})", ctor, params);
	}

	public static function createEnumIndex<T>(e:Enum<T>, index:Int, ?params:Array<Dynamic>):T {
		// Simplified implementation - not fully functional
		return null;
	}

	public static function allClasses():Array<Class<Dynamic>> {
		return [];
	}

	public static function allEnums<T>(e:Enum<T>):Array<T> {
		var result:Array<T> = [];
		var keys:Array<String> = cast getEnumConstructs(e);
		for (i in 0...keys.length) {
			result.push(createEnum(e, keys[i]));
		}
		return result;
	}

	public static function getEnumConstructs<T>(e:Enum<T>):Array<String> {
		return untyped __gdscript__("{0}.get(\"_constructors\").keys()", e);
	}

	public static function enumConstructor(e:EnumValue):String {
		final name = untyped __gdscript__("{0}.get(\"_hx_name\")", e);
		return if (name == null) "" else cast name;
	}

	public static function enumParameters(e:EnumValue):Array<Dynamic> {
		final params = untyped __gdscript__("{0}.get(\"params\")", e);
		if (params == null)
			return [];
		return untyped __gdscript__("Array({0})", params);
	}

	public static function enumIndex(e:EnumValue):Int {
		return untyped __gdscript__("{0}.get(\"index\")", e);
	}

	public static function enumEq<T:EnumValue>(a:T, b:T):Bool {
		if (a == b)
			return true;
		if (a == null || b == null)
			return false;
		if (enumConstructor(a) != enumConstructor(b))
			return false;
		final pa = enumParameters(a);
		final pb = enumParameters(b);
		if (pa.length != pb.length)
			return false;
		for (i in 0...pa.length) {
			if (!enumEq(cast pa[i], cast pb[i])) {
				// fallback to equality
				if (pa[i] != pb[i])
					return false;
			}
		}
		return true;
	}

	public static function typeof(v:Dynamic):ValueType {
		if (v == null)
			return TNull;
		if (untyped __gdscript__("({0} as Variant) is bool", v))
			return TBool;
		if (untyped __gdscript__("({0} as Variant) is int", v))
			return TInt;
		if (untyped __gdscript__("({0} as Variant) is float", v))
			return TFloat;
		if (untyped __gdscript__("({0} as Variant) is Callable", v))
			return TFunction;
		if (untyped __gdscript__("({0} as Variant) is Object", v))
			return TObject;
		return TUnknown;
	}
}
