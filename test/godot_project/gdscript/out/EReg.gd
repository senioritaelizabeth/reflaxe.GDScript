class_name EReg

func _init(r: String, opt: String) -> void:
	assert(false, str(haxe_exceptions_NotImplementedException.new("Regular expressions are not implemented for this platform", null, {
		"fileName": "EReg.hx",
		"lineNumber": 48,
		"className": "EReg",
		"methodName": "new"
	})))

func _match(s: String) -> bool:
	return false

func matched(n: int) -> String:
	return null

func matchedRight() -> String:
	return null

func matchedPos() -> Variant:
	return null

func matchSub(s: String, pos: int, len: int = -1) -> bool:
	return false

func split(s: String) -> Array:
	return null

func replace(s: String, by: String) -> String:
	return null

