class_name haxe_iterators_ArrayKeyValueIterator

var current: int = 0
var array: Array

func _init(array2: Array) -> void:
	self.array = array2

func hasNext() -> bool:
	return self.current < self.array.length

func next() -> Variant:
	self.current += 1

	var tempNumber: int = self.current - 1

	return {
		"value": self.array[self.current],
		"key": tempNumber
	}

