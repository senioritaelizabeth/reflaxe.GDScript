class_name TestSys

func _init() -> void:
	pass

static func test() -> void:
	if true:
		var cond: bool = Sys.args().length == 0
		assert(cond, "Test assert failed.")

	var first: float = Time.get_ticks_msec() / 1000.0

	OS.delay_msec(0.1 * 1000)

	if true:
		var cond: bool = Time.get_ticks_msec() / 1000.0 - first > 10000
		assert(cond, "Test assert failed.")

