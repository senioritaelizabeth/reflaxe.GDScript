class_name TestString

func _init() -> void:
	pass

static func test() -> void:
	var _str: String = String.new("Test")

	assert(_str == "Test", "Test assert failed.")

	if true:
		var cond: bool = _str.length == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.toString() == "Test"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = char(70) == "F"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.charCodeAt(1) == 101
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.indexOf("es") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.indexOf("Hey") == -1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.indexOf("Te", 2) == -1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.lastIndexOf("Te") == 0
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.split("s")[0] == "Te"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _str.split("e").length == 2
		assert(cond, "Test assert failed.")

	var str2: String = "Hello, World!"

	if true:
		var cond: bool = str2.substr(7, 5) == "World"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.substring(7, 12) == "World"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.toLowerCase() == "hello, world!"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.toUpperCase() == "HELLO, WORLD!"
		assert(cond, "Test assert failed.")

