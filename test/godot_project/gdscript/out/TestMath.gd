class_name TestMath

func _init() -> void:
	pass

static func test() -> void:
	if true:
		var cond: bool = ceil(2 * pow(Math._PI, 2)) == 20
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = abs(-3) == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ceil(2.1) == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ceil(0.9) == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ceil(exp(1.0)) == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = floor(exp(1.0)) == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = floor(99.9) == 99
		assert(cond, "Test assert failed.")

	assert(1.0 == 1.0, "Test assert failed.")

	if true:
		var cond: bool = is_finite(12)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = is_nan(Math.NaN)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !is_finite(Math.POSITIVE_INFINITY)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !is_finite(Math.NEGATIVE_INFINITY)
		assert(cond, "Test assert failed.")
	if true:
		var input: float = sin(Math._PI)
		assert(abs(0.0 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = cos(0)
		assert(abs(1 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = tan(4)
		assert(abs(1.157821 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = asin(1)
		assert(abs(1.570796 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = acos(100)
		assert(abs(0 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = atan(12)
		assert(abs(1.4876 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = atan2(-3, 3)
		assert(abs(-0.78539 - input) < 0.0001, "Test assert failed.")
	if true:
		var input: float = log(10)
		assert(abs(2.30258 - input) < 0.0001, "Test assert failed.")
	if true:
		var cond: bool = sqrt(25) == 5
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = sqrt(100) == 10
		assert(cond, "Test assert failed.")

