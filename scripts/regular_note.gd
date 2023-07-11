extends StaticBumpingBlock

@export var weak_jump_velocity: float = -450
@export var strong_jump_velocity: float = -950

var jump_timer: float
var cast_above: bool
var cast_below: bool
var hit_from_above: bool = false

@onready var player = Thunder._current_player

@onready var cast_top: ShapeCast2D = $Top
@onready var cast_bottom: ShapeCast2D = $Bottom


func _physics_process(delta: float) -> void:
	delta = Thunder.get_delta(delta)
	
	if cast_top:
		if Input.is_action_just_pressed("m_jump"):
			jump_timer = 8
		if Input.is_action_just_released("m_jump"):
			jump_timer = 0
		
		if jump_timer > 0: jump_timer -= delta
		
		if is_player_colliding(cast_top):
			if player.global_position.rotated(player.global_rotation).y > cast_top.global_position.rotated(global_rotation).y:
				player.global_position -= Vector2(0, 1).rotated(global_rotation)
			if jump_timer > 0:
				player.speed.y = strong_jump_velocity * player.suit.physics_config.jump_stomp_multiplicator
			else:
				player.speed.y = weak_jump_velocity * player.suit.physics_config.jump_stomp_multiplicator
			
			hit_from_above = true
			bump(false, 180, true)
			return
	
	if cast_bottom && is_player_colliding(cast_bottom) && player.speed.y <= 50 && !player.is_on_floor():
		bump(false)
		return


func call_bump() -> void:
	bump(true)


func _creation(creation: InstanceNode2D) -> void:
	if hit_from_above:
		creation.trans_offset += Vector2(0, 32).rotated(global_rotation)
	super(creation)
	
	result = null
	
