extends LogEntry
class_name ActivityPerformed

var target_body_id: String

func _init(target_body_id: String) -> void:
	self.target_body_id = target_body_id
