extends Object
class_name Proportion

var _val: float

func _init(val: float) -> void:
	self._val = clamp(val, 0, 1)

func as_float() -> float:
	return _val
