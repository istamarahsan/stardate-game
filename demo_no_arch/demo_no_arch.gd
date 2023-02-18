extends Control

var body_display_scene: PackedScene = preload("res://demo_no_arch/demo_body_display.tscn")

onready var system_name_label: Label = get_node("%SystemNameV")
onready var bodies_container: Container = get_node("%SystemBodies")
onready var activity_button: Button = get_node("%PerformActivity")
onready var hull_label: Label = get_node("%HullLabel")
onready var energy_label: Label = get_node("%EnergyLabel")
onready var credits_label: Label = get_node("%CreditsLabel")
onready var event_popup: EventPopup = $EventPopup

var system_1: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_1.tres")
var system_2: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_2.tres")
var system_3: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_3.tres")
var test_event: Event = preload("res://demo_no_arch/data/events/test_event.tres")

var selected_body: CelestialBody

var hull: int = 50
var energy: int = 50
var credits: int = 50
var active_tags: Dictionary = {}
var ship_log: Array = []

func _ready() -> void:
	_move_to_system(system_1)
	hull_label.text = "HULL: " + str(hull)
	energy_label.text = "ENERGY: " + str(energy)
	credits_label.text = "CREDITS: " + str(credits)
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
	selected_body = body
	activity_button.text = "Perform Activity: " + Enums.Activity_to_str(body.activity).to_upper()

func _on_PerformActivity_button_up() -> void:
	if selected_body == null: 
		return
		
	match selected_body.activity:
		Enums.Activity.Mine:
			hull -= 2
			energy += 3
			hull_label.text = "HULL: " + str(hull)
			energy_label.text = "ENERGY: " + str(energy)
		Enums.Activity.Repair:
			credits -= 5
			hull += 3
			credits_label.text = "CREDITS: " + str(credits)
			hull_label.text = "HULL: " + str(hull)
		Enums.Activity.Trade:
			energy -= 5
			credits += 6
			energy_label.text = "ENERGY: " + str(energy)
			credits_label.text = "CREDITS: " + str(credits)
		Enums.Activity.Survey:
			energy -= 2
			energy_label.text = "ENERGY: " + str(energy)
		Enums.Activity.Story:
			pass
		Enums.Activity.None:
			pass
	ship_log.append(ActivityPerformed.new(selected_body.id))
	if randi() % 2 == 1:
		event_popup.show_event(test_event)
		event_popup.popup_centered()

func _on_EventPopup_option_selected(option: EventOption) -> void:
	self.hull += option.add_hull
	hull_label.text = "HULL: " + str(hull)
	self.energy += option.add_energy
	energy_label.text = "ENERGY: " + str(energy)
	self.credits += option.add_credits
	credits_label.text = "CREDITS: " + str(credits)
	for tag_to_add in option.tags_added:
		active_tags[tag_to_add] = true
	ship_log.append(EventOccurred.new(test_event.id, option.id))
