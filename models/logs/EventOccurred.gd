extends LogEntry
class_name EventOccurred

export(String) var event_id: String
export(String) var selected_option_id: String

func _init(event_id: String = "", selected_option_id: String = "") -> void:
	self.event_id = event_id
	self.selected_option_id = selected_option_id
