class_name Enums

enum Activity {
	Mine = 0,
	Repair = 1,
	Trade = 2,
	Survey = 3,
	Story = 4,
	None = 5
}

static func Activity_to_str(act: int) -> String:
	match act:
		Activity.Mine:
			return "Mine"
		Activity.Repair:
			return "Repair"
		Activity.Trade:
			return "Trade"
		Activity.Survey:
			return "Survey"
		Activity.Story:
			return "Story"
		_:
			return "None"
