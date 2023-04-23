extends "./regular_note.gd"

@export var left_push_velocity: float = -350
@export var right_push_velocity: float = 350

func _physics_process(delta: float) -> void:
	super(delta)
	
	if cast_left && is_player_colliding(cast_left):
		player.velocity_local.x = left_push_velocity
		bump(false, 90, true)
		return
	
	if cast_right && is_player_colliding(cast_right):
		player.velocity_local.x = right_push_velocity
		bump(false, 270, true)
		return
