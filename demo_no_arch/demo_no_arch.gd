extends Control

var body_display_scene: PackedScene = preload("res://demo_no_arch/demo_body_display.tscn")

onready var system_name_label: Label = get_node("%SystemNameV")
onready var bodies_container: Container = get_node("%SystemBodies")
onready var activity_button: Button = get_node("%PerformActivity")
onready var hull_label: Label = get_node("%HullLabel")
onready var energy_label: Label = get_node("%EnergyLabel")
onready var credits_label: Label = get_node("%CreditsLabel")
onready var event_popup: EventPopup = $EventPopup
onready var system_1_button: Button = get_node("%System1")
onready var system_2_button: Button = get_node("%System2")
onready var system_3_button: Button = get_node("%System3")
onready var logs_container: Container = get_node("%LogsContainer")

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
	system_1_button.text = system_1.name
	system_2_button.text = system_2.name
	system_3_button.text = system_3.name

func _on_System1_button_up() -> void:
	_move_to_system(system_1)

func _on_System2_button_up() -> void:
	_move_to_system(system_2)

func _on_System3_button_up() -> void:
	_move_to_system(system_3)

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
	var new_log := ActivityPerformed.new(selected_body.id)
	ship_log.append(new_log)
	var log_label = _create_label_for_log(new_log)
	logs_container.add_child(log_label)
	logs_container.move_child(log_label, 0)
	if randi() % 10 == 1:
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
	var new_log := EventOccurred.new(test_event.id, option.id)
	ship_log.append(new_log)
	var log_label = _create_label_for_log(new_log)
	logs_container.add_child(log_label)
	logs_container.move_child(log_label, 0)

func _on_SaveButton_button_up() -> void:
	ResourceSaver.save("res://saved_log.tres", SavedLog.new(ship_log), ResourceSaver.FLAG_BUNDLE_RESOURCES)

func _create_label_for_log(entry: LogEntry) -> Label:
	var label: Label = Label.new()
	label.text = "(" + str(ship_log.size()) + ") "
	if "event_id" in entry and "selected_option_id" in entry:
		label.text += \
			"[EVENT_OCCURRED] " + \
			"event: " + \
			entry.event_id + \
			" | " + \
			"selected_option: " + \
			entry.selected_option_id
	elif "target_body_id" in entry:
		label.text += \
			"[ACTIVITY_PERFORMED] " + \
			"target body: " + \
			entry.target_body_id
	return label
