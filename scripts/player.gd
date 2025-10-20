extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox

func _ready():
	sprite.play("IDLE")
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)

func _physics_process(delta):
	if velocity.y > 0:
		sprite.play("FALL")
	if velocity.y < 0:
		sprite.play("JUMP")
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left","ui_right")
	if direction:
		sprite.flip_h = direction < 0
		velocity.x = direction * SPEED
		if is_on_floor():
			sprite.play("RUN")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			sprite.play("IDLE")
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("pikes"):
		Functionalities.game_over = true
