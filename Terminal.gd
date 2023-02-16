extends Control

signal end_turn_requested()
signal event_option_selected()

onready var hull_label: Label = get_node("%HullValue")
onready var energy_label: Label = get_node("%EnergyValue")
onready var credits_label: Label = get_node("%CreditsValue")

func set_hull(p: Proportion) -> void:
	hull_label.text = str(p.as_float() * 100) + "%"
	pass
	
func set_energy(p: Proportion) -> void:
	energy_label.text = str(p.as_float() * 100) + "%"
	pass

func set_credits(value: int) -> void:
	credits_label.text = str(value)
	pass

func queue_events(events: Array) -> void:
	pass
