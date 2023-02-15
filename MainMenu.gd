extends Control

signal new_game()
signal load_game(save_to_load)
signal exit_game()

func _on_ExitButton_button_up() -> void:
	emit_signal("exit_game")

func _on_LoadGameButton_button_up() -> void:
	pass

func _on_NewGameButton_button_up() -> void:
	emit_signal("new_game")
