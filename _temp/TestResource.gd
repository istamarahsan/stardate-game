extends Resource
class_name TestResource

export(String) var content

func _init(content: String = "") -> void:
	self.content = content
