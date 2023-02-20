extends Resource
class_name PlanetarySystem

export(String) var id: String
export(String) var name: String
export(Resource) var central_body: Resource
export(Array, Resource) var bodies: Array

func _init(id: String = "", name: String = "", central_body: Resource = null, bodies: Array = []) -> void:
	self.id = id
	self.name = name
	self.central_body = central_body
	self.bodies = bodies
