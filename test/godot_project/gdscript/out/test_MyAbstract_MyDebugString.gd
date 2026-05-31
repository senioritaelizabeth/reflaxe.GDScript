class_name MyDebugString_Impl_

func _init() -> void:
	pass

static func _new(s: String) -> String:
	return s

static func substr(this1: String, i: int, len = null) -> String:
	return this1.substr(i)

