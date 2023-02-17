extends PanelContainer
class_name DemoBodyDisplay

signal selected()

onready var system_name_label: Label = $VBoxContainer/Name
onready var activity_label: Label = $VBoxContainer/HBoxContainer/ActivityValue
onready var description_label: Label = $VBoxContainer/Description

func clear() -> void:
	system_name_label.text = ""
	activity_label.text = ""
	description_label.text = ""

func display_body(body: CelestialBody) -> void:
	system_name_label.text = body.name
	activity_label.text = Enums.Activity_to_str(body.activity)
	description_label.text = body.description

func _on_Body_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("selected")
