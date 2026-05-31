class_name TestArray

func _init() -> void:
	pass

static func test() -> void:
	var arr: Array = Array.new()

	if true:
		var cond: bool = arr.length == 0
		assert(cond, "Test assert failed.")

	arr.push(0 + 1)
	arr.push(1 + 1)
	arr.push(2 + 1)

	if true:
		var cond: bool = arr.length == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = arr.concat(([4, 5, 6] as Array)).length == 6
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = arr.contains(3)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !arr.contains(5)
		assert(cond, "Test assert failed.")

	assert(arr == arr, "Test assert failed.")

	if true:
		var cond: bool = arr == arr.copy()
		assert(cond, "Test assert failed.")
	if true:
		var tempArray
		if true:
			var _g: Array = ([] as Array)
			if true:
				var _g1: int = 0
				while (_g1 < arr.length):
					var v: int = arr[_g1]
					_g1 += 1
					if ((func(i: int) -> bool:
						return i != 1).call(v)):
						_g.push(v)
			tempArray = _g
		var cond: bool = (tempArray).length == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = arr.indexOf(2) == 1
		assert(cond, "Test assert failed.")

	arr.insert(0, 0)

	if true:
		var cond: bool = arr.length == 4
		assert(cond, "Test assert failed.")

	assert(arr[0] == 0, "Test assert failed.")
	assert(arr[2] == 2, "Test assert failed.")
	arr.insert(-1, 4)

	if true:
		var cond: bool = arr.length == 5
		assert(cond, "Test assert failed.")

	assert(arr[4] == 4, "Test assert failed.")
	assert(arr[2] == 2, "Test assert failed.")

	var total: int = 0
	var it_current: int = 0

	while (it_current < arr.length):
		var tempIndex
		it_current += 1
		tempIndex = it_current - 1
		total += arr[tempIndex]

	assert(total == 10, "Test assert failed.")

	if true:
		var cond: bool = arr.join(", ") == "0, 1, 2, 3, 4"
		assert(cond, "Test assert failed.")

	var tempArray1

	if true:
		var _g: Array = ([] as Array)
		if true:
			var _g1: int = 0
			while (_g1 < arr.length):
				var v: int = arr[_g1]
				_g1 += 1
				_g.push((func(i: int) -> int:
					return i * 2).call(v))
		tempArray1 = _g

	var keyTotal: int = 0
	var doubleTotal: int = 0
	var kvit_current: int = 0

	while (kvit_current < tempArray1.length):
		var o_value
		var o_key
		o_value = tempArray1[kvit_current]
		var tempRight
		kvit_current += 1
		tempRight = kvit_current - 1
		o_key = tempRight
		keyTotal += o_key
		doubleTotal += o_value

	assert(keyTotal == 10, "Test assert failed.")
	assert(doubleTotal == 20, "Test assert failed.")

	var stack: Array = ([84, 29, 655] as Array)

	if true:
		var cond: bool = stack.pop() == 655
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = stack.length == 2
		assert(cond, "Test assert failed.")

	stack.push(333)
	assert(stack[2] == 333, "Test assert failed.")

	if (stack.remove(84)):
		if true:
			var cond: bool = stack.length == 2
			assert(cond, "Test assert failed.")
		assert(stack[0] == 29, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

	var ordered: Array = ([3, 6, 9, 12] as Array)

	ordered.reverse()
	assert(ordered == ([12, 9, 6, 3] as Array), "Test assert failed.")

	if true:
		var cond: bool = ordered.shift() == 12
		assert(cond, "Test assert failed.")

	var newArr: Array = ([22, 44, 66, 88] as Array)

	if true:
		var cond: bool = newArr.slice(1) == ([44, 66, 88] as Array)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = newArr.slice(2, 3) == ([66] as Array)
		assert(cond, "Test assert failed.")

	var sortable: Array = ([2, 7, 1, 4, 0, 4] as Array)

	sortable.sort(func(a: int, b: int) -> int:
		return a - b)
	assert(sortable == ([0, 1, 2, 4, 4, 7] as Array), "Test assert failed.")

	if true:
		var cond: bool = sortable.splice(2, 1) == ([2] as Array)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = sortable.splice(1, 3) == ([1, 4, 4] as Array)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = sortable.toString() == "[0, 7]"
		assert(cond, "Test assert failed.")

	var unfinished: Array = ([3, 4, 5] as Array)

	unfinished.unshift(2)
	unfinished.unshift(1)
	assert(unfinished == ([1, 2, 3, 4, 5] as Array), "Test assert failed.")

