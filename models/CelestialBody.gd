extends Resource
class_name CelestialBody

# Must be exactly the same as that in Enums.gd
enum ActivityType {
	Mine = 0,
	Repair = 1,
	Trade = 2,
	Survey = 3,
	Story = 4,
	None = 5
}

export(String) var id: String
export(String) var name: String
export(String) var description: String
export(ActivityType) var activity: int

func _init(id: String = "", name: String = "", description: String = "", activity: int = ActivityType.None) -> void:
	self.id = id
	self.name = name
	self.description = description
	self.activity = activity
