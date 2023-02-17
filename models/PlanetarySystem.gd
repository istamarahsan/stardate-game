extends Resource
class_name PlanetarySystem

export(String) var name
export(Resource) var central_body
export(Array) var bodies

func _init(name: String = "", central_body: Resource = null, bodies: Array = []) -> void:
	self.name = name
	self.central_body = central_body
	self.bodies = bodies
