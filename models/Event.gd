extends Resource
class_name Event

export(String) var title: String
export(String, MULTILINE) var text: String 
export(Array) var options: Array

func _init(title: String = "", text: String = "", options: Array = []) -> void:
	self.title = title
	self.text = text
	self.options = options
