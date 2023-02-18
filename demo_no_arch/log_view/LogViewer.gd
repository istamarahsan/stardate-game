extends Control

onready var entries_container: Container = get_node("%EntriesContainer")

func _ready() -> void:
	pass

func _on_LoadButton_button_up() -> void:
	for child in entries_container.get_children():
		child.queue_free()
	var ship_log = ResourceLoader.load("res://saved_log.tres", "SavedLog")
	for entry in ship_log.entries:
		var label: Label = Label.new()
		if "event_id" in entry and "selected_option_id" in entry:
			label.text = \
				"[EVENT_OCCURRED] " + \
				"event: " + \
				entry.event_id + \
				" | " + \
				"selected_option: " + \
				entry.selected_option_id
		elif "target_body_id" in entry:
			label.text = \
				"[ACTIVITY_PERFORMED] " + \
				"target body: " + \
				entry.target_body_id
		else:
			continue
		
		entries_container.add_child(label)
