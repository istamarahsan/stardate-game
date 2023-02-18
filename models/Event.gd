extends Resource
class_name Event

export(String) var id: String
export(String) var title: String
export(String, MULTILINE) var text: String 
export(Array) var options: Array

func _init(id: String = "", title: String = "", text: String = "", options: Array = []) -> void:
	self.id = id
	self.title = title
	self.text = text
	self.options = options
