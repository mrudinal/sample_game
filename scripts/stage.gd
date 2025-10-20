extends Node2D

func _process(_delta: float) -> void:
	if Functionalities.game_over and not get_tree().paused:
		get_tree().paused = true
		# If you plan to show a pause/game-over UI, make that UI node's pause_mode = PROCESS
