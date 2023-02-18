extends Control
class_name Terminal

signal command()

func set_hull(p: Proportion) -> void:
	pass
	
func set_energy(p: Proportion) -> void:
	pass

func set_credits(value: int) -> void:
	pass

func set_logs(logs: Array) -> void:
	pass

func prompt_event(event: Event) -> void:
	pass

func enter_system(system: PlanetarySystem) -> void:
	pass
