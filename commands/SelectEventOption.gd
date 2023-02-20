extends Command
class_name SelectEventOption

var event_id: String
var option_id: String

func _init(event_id: String, option_id: String) -> void:
	self.event_id = event_id
	self.option_id = option_id
