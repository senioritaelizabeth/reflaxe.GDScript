package haxe;

class Serializer {
	static public var USE_CACHE: Bool = false;
	static public var USE_ENUM_INDEX: Bool = false;

	var buf: StringBuf;
	var cache: Array<Dynamic>;
	var useCache: Bool;
	var useEnumIndex: Bool;
	var shash: haxe.ds.StringMap<Int>;
	var scount: Int;

	public function new() {
		buf = new StringBuf();
		cache = [];
		useCache = USE_CACHE;
		useEnumIndex = USE_ENUM_INDEX;
		shash = new haxe.ds.StringMap<Int>();
		scount = 0;
	}

	public function toString(): String {
		return buf.toString();
	}

	public function serialize(v: Dynamic): Void {
		switch (Type.typeof(v)) {
			case TNull:
				buf.add("n");
			case TInt:
				if (v == 0) {
					buf.add("z");
					return;
				}
				buf.add("i");
				buf.add(Std.string(v));
				buf.add(";");
			case TFloat:
				if (Math.isNaN(v)) {
					buf.add("k");
				} else if (!Math.isFinite(v)) {
					buf.add(v < 0 ? "m" : "p");
				} else {
					buf.add("d");
					buf.add(Std.string(v));
					buf.add(";");
				}
			case TBool:
				buf.add(v ? "t" : "f");
			case TClass(c):
				if (c == String) {
					serializeString(v);
				} else if (c == Array) {
					final a: Array<Dynamic> = v;
					buf.add("a");
					for (item in a) serialize(item);
					buf.add("h");
				} else {
					buf.add("o");
					serializeFields(v);
					buf.add("g");
				}
			case TObject:
				buf.add("o");
				serializeFields(v);
				buf.add("g");
			case TEnum(e):
				final enumVal: EnumValue = v;
				buf.add("j");
				serializeString(Type.getEnumName(e));
				buf.add(":");
				if (useEnumIndex) {
					buf.add(Std.string(Type.enumIndex(enumVal)));
				} else {
					serializeString(Type.enumConstructor(enumVal));
				}
				buf.add(":");
				final params = Type.enumParameters(enumVal);
				buf.add(Std.string(params.length));
				buf.add(":");
				for (p in params) serialize(p);
			case TUnknown:
				buf.add("?");
			case TFunction:
				throw "Cannot serialize function";
		}
	}

	private function serializeString(s: String): Void {
		final idx = shash.get(s);
		if (idx != null) {
			buf.add("R");
			buf.add(Std.string(idx));
			buf.add(";");
			return;
		}
		shash.set(s, scount++);
		buf.add("y");
		final encoded = StringTools.urlEncode(s);
		buf.add(Std.string(encoded.length));
		buf.add(":");
		buf.add(encoded);
	}

	private function serializeFields(v: Dynamic): Void {
		for (f in Reflect.fields(v)) {
			serializeString(f);
			serialize(Reflect.field(v, f));
		}
	}

	public static function run(v: Dynamic): String {
		final s = new Serializer();
		s.serialize(v);
		return s.toString();
	}
}
