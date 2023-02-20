extends Resource
class_name SavedLog

export(Array) var entries: Array

func _init(entries: Array = []) -> void:
	self.entries = []
	for entry in entries:
		if entry is LogEntry:
			self.entries.append(entry)
