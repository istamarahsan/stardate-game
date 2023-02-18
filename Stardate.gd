extends Node

onready var ui: Terminal = $PlaceHolderUI

var system_1: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_1.tres")
var system_2: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_2.tres")
var system_3: PlanetarySystem = preload("res://demo_no_arch/data/world/demo_system_3.tres")
var test_event: Event = preload("res://demo_no_arch/data/events/test_event.tres")

var all_systems = [system_1, system_2, system_3]
var all_events = [test_event]

var systems: Dictionary = {}
var events: Dictionary = {}

var hull: float = 0.5
var energy: float = 0.5
var credits: int = 50
var active_tags: Dictionary = {}
var current_system_id: String
var active_event_id: String
var ship_log: Array = []

func _ready() -> void:
	current_system_id = system_1.id
	for system in all_systems:
		systems[system.id] = system
	for event in all_events:
		events[event.id] = event
	ui.enter_system(systems[current_system_id])
	ui.set_hull(Proportion.new(hull))
	ui.set_energy(Proportion.new(energy))
	ui.set_credits(credits)

func _on_command(cmd: Command) -> void:
	if cmd is PerformActivity:
		_handle_perform_activity(cmd)
	elif cmd is SelectEventOption:
		_handle_select_event_option(cmd)
	elif cmd is TravelToSystem:
		_handle_travel_to_system(cmd)

func _handle_perform_activity(cmd: PerformActivity) -> void:
	for body in systems[current_system_id].bodies:
		if cmd.target_body != body.id:
			continue
		match body.activity:
			Enums.Activity.Mine:
				hull -= 0.02
				energy += 0.03
			Enums.Activity.Repair:
				credits -= 0.05
				hull += 0.03
			Enums.Activity.Trade:
				energy -= 0.05
				credits += 0.06
			Enums.Activity.Survey:
				energy -= 0.02
			Enums.Activity.Story:
				pass
			Enums.Activity.None:
				pass
		ship_log.append(ActivityPerformed.new(body.id))
		ui.set_hull(Proportion.new(hull))
		ui.set_energy(Proportion.new(energy))
		ui.set_credits(credits)
		ui.set_logs(ship_log)
		if randi() % 10 == 1:
			active_event_id = test_event.id
			ui.prompt_event(events[active_event_id])
	
func _handle_select_event_option(cmd: SelectEventOption) -> void:
	if cmd.event_id != active_event_id:
		return
	for option in events[active_event_id].options:
		if cmd.option_id != option.id:
			continue
		hull += float(option.add_hull) / 100
		energy += float(option.add_energy) / 100
		credits += option.add_credits
		for tag in option.tags_added:
			active_tags[tag] = true
		ship_log.append(EventOccurred.new(cmd.event_id, option.id))
		ui.set_hull(Proportion.new(hull))
		ui.set_energy(Proportion.new(energy))
		ui.set_credits(credits)
		ui.set_logs(ship_log)
	
func _handle_travel_to_system(cmd: TravelToSystem) -> void:
	if not cmd.target_system_id in systems:
		return
	current_system_id = cmd.target_system_id
	ship_log.append(TraveledToSystem.new(current_system_id))
	ui.enter_system(systems[current_system_id])
	ui.set_logs(ship_log)

func _on_PlaceHolderUI_command(command) -> void:
	_on_command(command)
