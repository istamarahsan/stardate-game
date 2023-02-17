extends Control

var body_display_scene: PackedScene = preload("res://demo_no_arch/demo_body_display.tscn")

onready var system_name_label: Label = get_node("%SystemNameV")
onready var bodies_container: Container = get_node("%SystemBodies")
onready var activity_button: Button = get_node("%PerformActivity")

var system_1: PlanetarySystem = preload("res://demo_no_arch/data/demo_system_1.tres")
var system_2: PlanetarySystem = preload("res://demo_no_arch/data/demo_system_2.tres")
var system_3: PlanetarySystem = preload("res://demo_no_arch/data/demo_system_3.tres")

func _ready() -> void:
	_move_to_system(system_1)
	pass

func _on_System1_button_up() -> void:
	_move_to_system(system_1)
	pass # Replace with function body.

func _on_System2_button_up() -> void:
	_move_to_system(system_2)
	pass # Replace with function body.

func _on_System3_button_up() -> void:
	_move_to_system(system_3)
	pass # Replace with function body.

func _move_to_system(system: PlanetarySystem) -> void:
	for child in bodies_container.get_children():
		child.queue_free()
	
	system_name_label.text = system.name + " System"
	
	for body in system.bodies:
		var body_display: DemoBodyDisplay = body_display_scene.instance()
		bodies_container.add_child(body_display)
		body_display.display_body(body)
		body_display.connect("selected", self, "_on_select_body", [body])

func _on_select_body(body: CelestialBody) -> void:
	activity_button.text = "Perform Activity: " + Enums.Activity_to_str(body.activity).to_upper()
