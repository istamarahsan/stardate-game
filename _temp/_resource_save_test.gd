extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_Save_button_up() -> void:
	var res = TestResource.new(get_node("%Text").text)
	ResourceSaver.save("res://res.tres", res)
	pass # Replace with function body.


func _on_Load_button_up() -> void:
	# var res = ResourceLoader.load("res://res.tres") as TestResource
	var res = load("res://res.tres")
	if res:
		get_node("%Text").text = res.content
	pass # Replace with function body.
