package haxe;

class Unserializer {
	static public var DEFAULT_RESOLVER: TypeResolver = {
		resolveClass: function(name: String) return Type.resolveClass(name),
		resolveEnum: function(name: String) return Type.resolveEnum(name)
	};

	var buf: String;
	var pos: Int;
	var length: Int;
	var cache: Array<Dynamic>;
	var scache: Array<String>;
	var resolver: TypeResolver;

	public function new(buf: String) {
		this.buf = buf;
		this.length = buf.length;
		this.pos = 0;
		this.cache = [];
		this.scache = [];
		this.resolver = DEFAULT_RESOLVER;
	}

	public function setResolver(r: TypeResolver): Void {
		if (r == null) resolver = { resolveClass: function(_) return null, resolveEnum: function(_) return null };
		else resolver = r;
	}

	public function getResolver(): TypeResolver {
		return resolver;
	}

	private function get(p: Int): Int {
		return buf.charCodeAt(p);
	}

	private function readDigits(): Int {
		var k = 0;
		var neg = false;
		if (get(pos) == "-".code) { neg = true; pos++; }
		while (pos < length) {
			final c = get(pos);
			if (c < "0".code || c > "9".code) break;
			k = k * 10 + (c - "0".code);
			pos++;
		}
		return neg ? -k : k;
	}

	private function readString(): String {
		final len = readDigits();
		if (get(pos) != ":".code) throw "Invalid format";
		pos++;
		final s = StringTools.urlDecode(buf.substr(pos, len));
		pos += len;
		scache.push(s);
		return s;
	}

	public function unserialize(): Dynamic {
		switch (get(pos++)) {
			case "n".code: return null;
			case "t".code: return true;
			case "f".code: return false;
			case "z".code: return 0;
			case "i".code:
				final v = readDigits();
				if (get(pos) != ";".code) throw "Invalid format";
				pos++;
				return v;
			case "d".code:
				final start = pos;
				while (pos < length && get(pos) != ";".code) pos++;
				final v = Std.parseFloat(buf.substr(start, pos - start));
				pos++;
				return v;
			case "k".code: return Math.NaN;
			case "m".code: return Math.NEGATIVE_INFINITY;
			case "p".code: return Math.POSITIVE_INFINITY;
			case "y".code: return readString();
			case "R".code:
				final idx = readDigits();
				if (get(pos) != ";".code) throw "Invalid format";
				pos++;
				return scache[idx];
			case "a".code:
				final a: Array<Dynamic> = [];
				while (get(pos) != "h".code) a.push(unserialize());
				pos++;
				return a;
			case "o".code:
				final o: Dynamic = {};
				while (get(pos) != "g".code) {
					final k = unserialize();
					final v = unserialize();
					Reflect.setField(o, k, v);
				}
				pos++;
				return o;
			default:
				throw "Unknown serialization token at pos " + (pos - 1);
		}
	}

	public static function run(v: String): Dynamic {
		return new Unserializer(v).unserialize();
	}
}

typedef TypeResolver = {
	function resolveClass(name: String): Class<Dynamic>;
	function resolveEnum(name: String): Enum<Dynamic>;
}
