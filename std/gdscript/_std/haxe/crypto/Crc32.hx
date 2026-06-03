package haxe.crypto;

class Crc32 {
	static var table: Null<Array<Int>> = null;

	static function makeTable(): Array<Int> {
		final t: Array<Int> = [];
		for (i in 0...256) {
			var c = i;
			for (_ in 0...8) {
				c = (c & 1) != 0 ? (0xEDB88320 ^ (c >> 1)) : (c >> 1);
			}
			t.push(c);
		}
		return t;
	}

	public static function make(b: haxe.io.Bytes): Int {
		if (table == null) table = makeTable();
		var crc = 0xFFFFFFFF;
		for (i in 0...b.length) {
			crc = (table[(crc ^ b.get(i)) & 0xFF]) ^ (crc >>> 8);
		}
		return (crc ^ 0xFFFFFFFF);
	}

	public static function encode(s: String): Int {
		return make(haxe.io.Bytes.ofString(s));
	}
}
