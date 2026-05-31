class_name MyReflect_Impl_

func _init() -> void:
	pass

static func arrayAccess(this1: Variant, key: String):
	return this1.get(key)

static func arrayWrite(this1: Variant, key: String, value):
	this1.set(key, value)

	return value

