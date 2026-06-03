package haxe.io;

class Path {
	public static inline var DEFAULT_EXTENSION: String = "";

	public var dir: Null<String>;
	public var file: String;
	public var ext: Null<String>;
	public var backslash: Bool;

	public function new(path: String) {
		backslash = false;

		// Normalize backslashes
		var p = path;
		if (p.indexOf("\\") >= 0) {
			backslash = true;
			p = p.split("\\").join("/");
		}

		final lastSlash = p.lastIndexOf("/");
		if (lastSlash < 0) {
			dir = null;
			p = path;
		} else {
			dir = p.substring(0, lastSlash);
			p = p.substring(lastSlash + 1);
		}

		final dotPos = p.lastIndexOf(".");
		if (dotPos < 0) {
			file = p;
			ext = null;
		} else {
			file = p.substring(0, dotPos);
			ext = p.substring(dotPos + 1);
		}
	}

	public function toString(): String {
		final sep = backslash ? "\\" : "/";
		return (dir == null ? "" : dir + sep)
			+ file
			+ (ext == null ? "" : "." + ext);
	}

	public static function join(parts: Array<String>): String {
		final result: Array<String> = [];
		for (part in parts) {
			if (part == null || part.length == 0) continue;
			if (result.length > 0 && result[result.length - 1].charAt(result[result.length - 1].length - 1) == "/") {
				result.push(part.charAt(0) == "/" ? part.substr(1) : part);
			} else {
				result.push(part);
			}
		}
		return normalize(result.join("/"));
	}

	public static function normalize(path: String): String {
		final parts = path.split("/");
		final result: Array<String> = [];
		for (part in parts) {
			if (part == "" || part == ".") continue;
			if (part == "..") {
				if (result.length > 0 && result[result.length - 1] != "..") result.pop();
				else result.push("..");
			} else {
				result.push(part);
			}
		}
		final p = result.join("/");
		return if (path.charAt(0) == "/") "/" + p
			else if (p.length == 0) "."
			else p;
	}

	public static function addTrailingSlash(path: String): String {
		if (path.length == 0) return "/";
		final c = path.charAt(path.length - 1);
		return if (c == "/" || c == "\\") path else path + "/";
	}

	public static function removeTrailingSlashes(path: String): String {
		while (path.length > 0) {
			final c = path.charAt(path.length - 1);
			if (c != "/" && c != "\\") break;
			path = path.substr(0, path.length - 1);
		}
		return path;
	}

	public static function directory(path: String): String {
		return new Path(path).dir ?? "";
	}

	public static function withoutDirectory(path: String): String {
		final p = new Path(path);
		return p.file + (p.ext == null ? "" : "." + p.ext);
	}

	public static function withoutExtension(path: String): String {
		final p = new Path(path);
		return (p.dir == null ? "" : p.dir + "/") + p.file;
	}

	public static function extension(path: String): String {
		return new Path(path).ext ?? "";
	}

	public static function withExtension(path: String, ext: String): String {
		final p = new Path(path);
		p.ext = ext == "" ? null : ext;
		return p.toString();
	}

	public static function isAbsolute(path: String): Bool {
		if (path.charAt(0) == "/") return true;
		if (path.length >= 2 && path.charAt(1) == ":") return true; // Windows C:\
		return false;
	}
}
