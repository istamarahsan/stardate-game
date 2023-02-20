extends Popup
class_name EventPopup

signal option_selected(option)

var option_scene: PackedScene = preload("res://demo_no_arch/event_popup_option.tscn")

onready var title_label: Label = get_node("%Title")
onready var desc_label: Label = get_node("%Description")
onready var options_container: Container = get_node("%Options")

func show_event(event: Event) -> void:
	
	for child in options_container.get_children():
		child.queue_free()
	
	title_label.text = event.title
	desc_label.text = event.text
	
	for option in event.options:
		if not option is EventOption:
			continue
		var option_display: EventPopupOption = option_scene.instance()
		options_container.add_child(option_display)
		option_display.display(option)
		option_display.connect("selected", self, "_on_option_selected", [option])
		
func _on_option_selected(option: EventOption) -> void:
	emit_signal("option_selected", option)
	hide()
