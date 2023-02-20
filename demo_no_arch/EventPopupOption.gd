extends Control
class_name EventPopupOption

signal selected()

func display(option: EventOption):
	self.text = option.text

func _on_PopupOption_button_up() -> void:
	emit_signal("selected")
