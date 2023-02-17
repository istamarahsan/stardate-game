extends Object
class_name Simulation

var hull: Proportion
var energy: Proportion
var credits: int
var current_system: String
var game_data: Dictionary

func _init(game_data: Dictionary) -> void:
	self.game_data = game_data
	hull = Proportion.new(0.5)
	energy = Proportion.new(0.5)
	credits = 50
	pass

func process_command(command: Command) -> void:
	if command is PerformActivity:
		var cmd: PerformActivity = command as PerformActivity
		var body: CelestialBody = game_data["systems"][cmd.target_body]
		var activity := body.activity
		match activity:
			Enums.Activity.Mine:
				pass
			Enums.Activity.Repair:
				pass
			Enums.Activity.Trade:
				pass
			Enums.Activity.Survey:
				pass
			Enums.Activity.Story:
				pass
			Enums.Activity.None:
				pass
