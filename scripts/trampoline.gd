extends Node2D

@export var bounce_velocity: float = -900.0

@onready var sprite: AnimatedSprite2D = $Platform/CollisionShape2D/AnimatedSprite2D
@onready var trigger: Area2D = $Trigger

func _ready() -> void:
	sprite.play("IDLE")
	trigger.body_entered.connect(_on_trigger_body_entered)
	sprite.animation_finished.connect(_on_anim_finished)

func _on_trigger_body_entered(body: Node) -> void:
	var player := body as CharacterBody2D
	if player == null:
		return
	# Only bounce if player is landing/standing (not rising)
	if player.velocity.y >= 0.0:
		sprite.play("BOUNCE")
		player.velocity.y = bounce_velocity

func _on_anim_finished() -> void:
	if sprite.animation == "bounce":
		sprite.play("idle")
