extends Command
class_name TravelToSystem

var target_system_id: String

func _init(target_system_id: String) -> void:
	self.target_system_id = target_system_id
