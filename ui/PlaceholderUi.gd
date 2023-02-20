extends Terminal

var body_display_scene: PackedScene = preload("res://demo_no_arch/demo_body_display.tscn")
var system_1: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_1.tres")
var system_2: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_2.tres")
var system_3: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_3.tres")

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

var active_event: Event = null
var selected_body: CelestialBody = null

func _ready() -> void:
	pass

func set_hull(p: Proportion) -> void:
	hull_label.text = "HULL: " + str(p.as_float() * 100)

func set_energy(p: Proportion) -> void:
	energy_label.text = "ENERGY: " + str(p.as_float() * 100)

func set_credits(value: int) -> void:
	credits_label.text = "CREDITS: " + str(value)

func set_logs(entries: Array) -> void:
	for child in logs_container.get_children():
		child.queue_free()
		
	for i in entries.size():
		var entry = entries[i]
		var label := Label.new()
		label.text = str(i) + ". " + _create_display_string_for_log_entry(entry)
		logs_container.add_child(label)
		logs_container.move_child(label, 0)

func prompt_event(event: Event) -> void:
	active_event = event
	event_popup.show_event(event)
	event_popup.popup_centered()

func enter_system(system: PlanetarySystem) -> void:
	for child in bodies_container.get_children():
		child.queue_free()
	
	system_name_label.text = system.name + " System"
	
	for body in system.bodies:
		var body_display: DemoBodyDisplay = body_display_scene.instance()
		bodies_container.add_child(body_display)
		body_display.display_body(body)
		body_display.connect("selected", self, "_on_select_body", [body])

func _create_display_string_for_log_entry(entry: LogEntry) -> String:
	if "event_id" in entry and "selected_option_id" in entry:
		return \
			"[EVENT_OCCURRED] " + \
			"event: " + \
			entry.event_id + \
			" | " + \
			"selected_option: " + \
			entry.selected_option_id
	elif "target_body_id" in entry:
		return \
			"[ACTIVITY_PERFORMED] " + \
			"target body: " + \
			entry.target_body_id
	elif "target_system_id" in entry:
		return \
			"[TRAVELED_TO_SYSTEM] " + \
			"target system: " + \
			entry.target_system_id
	else:
		return ""

func _on_select_body(body: CelestialBody) -> void:
	selected_body = body
	activity_button.text = "Perform Activity: " + Enums.Activity_to_str(body.activity).to_upper()

func _on_EventPopup_option_selected(option: EventOption) -> void:
	
	var command := SelectEventOption.new(active_event.id, option.id)
	emit_signal("command", command)

func _on_PerformActivity_button_up() -> void:
	if selected_body == null: 
		return

	var command := PerformActivity.new(selected_body.id)
	emit_signal("command", command)

func _on_System1_button_up() -> void:
	var command := TravelToSystem.new(system_1.id)
	emit_signal("command", command)

func _on_System2_button_up() -> void:
	var command := TravelToSystem.new(system_2.id)
	emit_signal("command", command)

func _on_System3_button_up() -> void:
	var command := TravelToSystem.new(system_3.id)
	emit_signal("command", command)
