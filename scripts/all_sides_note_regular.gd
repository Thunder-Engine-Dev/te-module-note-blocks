extends "./regular_note.gd"

@export var left_push_velocity: float = -350
@export var right_push_velocity: float = 350

@onready var cast_left: ShapeCast2D = $Left
@onready var cast_right: ShapeCast2D = $Right


func _physics_process(delta: float) -> void:
	super(delta)
	
	if cast_left && is_player_colliding(cast_left):
		player.speed.x = left_push_velocity
		bump(false, 90, true)
		return
	
	if cast_right && is_player_colliding(cast_right):
		player.speed.x = right_push_velocity
		bump(false, 270, true)
		return
