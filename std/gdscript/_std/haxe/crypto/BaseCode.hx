package haxe.crypto;

class BaseCode {
	var base: haxe.io.Bytes;
	var nbits: Int;

	public function new(base: haxe.io.Bytes) {
		this.base = base;
		final len = base.length;
		nbits = switch len {
			case 2: 1;
			case 4: 2;
			case 8: 3;
			case 16: 4;
			case 32: 5;
			case 64: 6;
			case 128: 7;
			default: throw "Invalid base length " + len;
		};
	}

	public function encodeBytes(b: haxe.io.Bytes): haxe.io.Bytes {
		final nbits = this.nbits;
		final base = this.base;
		final blen = b.length;
		final outLen = Math.ceil((blen * 8) / nbits);
		final out = haxe.io.Bytes.alloc(outLen);
		var bitbuf = 0;
		var nbuf = 0;
		var pos = 0;
		for (i in 0...blen) {
			bitbuf = (bitbuf << 8) | b.get(i);
			nbuf += 8;
			while (nbuf >= nbits) {
				nbuf -= nbits;
				out.set(pos++, base.get((bitbuf >> nbuf) & ((1 << nbits) - 1)));
			}
		}
		if (nbuf > 0) {
			out.set(pos++, base.get((bitbuf << (nbits - nbuf)) & ((1 << nbits) - 1)));
		}
		return out.sub(0, pos);
	}

	public function decodeBytes(b: haxe.io.Bytes): haxe.io.Bytes {
		final nbits = this.nbits;
		final base = this.base;
		// Build reverse lookup
		final lookup: Array<Int> = [];
		for (i in 0...256) lookup.push(-1);
		for (i in 0...base.length) lookup[base.get(i)] = i;

		final blen = b.length;
		final outLen = Math.ceil((blen * nbits) / 8);
		final out = haxe.io.Bytes.alloc(outLen);
		var bitbuf = 0;
		var nbuf = 0;
		var pos = 0;
		for (i in 0...blen) {
			final c = lookup[b.get(i)];
			if (c < 0) throw "Invalid char";
			bitbuf = (bitbuf << nbits) | c;
			nbuf += nbits;
			if (nbuf >= 8) {
				nbuf -= 8;
				out.set(pos++, (bitbuf >> nbuf) & 0xFF);
			}
		}
		return out.sub(0, pos);
	}

	public function encodeString(s: String): String {
		return encodeBytes(haxe.io.Bytes.ofString(s)).toString();
	}

	public function decodeString(s: String): String {
		return decodeBytes(haxe.io.Bytes.ofString(s)).toString();
	}
}
