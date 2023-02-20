extends Resource
class_name EventOption

export(String) var id: String
export(String) var text: String
export(int, -100, 100, 1) var add_hull: int
export(int, -100, 100, 1) var add_energy: int
export(int) var add_credits: int
export(Array) var tags_added: Array

func _init(
	id: String = "",
	text: String = "", 
	add_hull: int = 0, 
	add_energy: int = 0,
	add_credits: int = 0,
	tags_added: Array = []) -> void:
	self.id = id
	self.text = text
	self.add_hull = add_hull
	self.add_energy = add_energy
	self.add_credits = add_credits
	self.tags_added = tags_added
