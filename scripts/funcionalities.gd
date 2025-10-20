extends Node

# Global flags / state
var game_over: bool = false

# (nice-to-have) quick reset
func reset() -> void:
	game_over = false
