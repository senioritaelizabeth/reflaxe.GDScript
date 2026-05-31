class_name StringTools

func _init() -> void:
	pass

static func startsWith(s: String, start: String) -> bool:
	return s.length >= start.length && s.lastIndexOf(start, 0) == 0

static func hex(n: int, digits = null) -> String:
	var s: String = ""
	var hexChars: String = "0123456789ABCDEF"

	while true:
		s = hexChars.charAt(n & 15) + s
		n = (((n & -1) >> 4) & -1)
		if !(n > 0):
			break

	if (digits != null):
		while (s.length < digits):
			s = "0" + s

	return s

