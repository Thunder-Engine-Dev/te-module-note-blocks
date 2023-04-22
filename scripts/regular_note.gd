extends StaticBumpingBlock

@export var weak_jump_velocity: float = -450
@export var strong_jump_velocity: float = -950
var jump_timer: float

var hit_from_above = false

@onready var player = Thunder._current_player

#func _ready() -> void:
#	cast_below.body_entered.connect(_detect_below)
#	cast_above.body_entered.connect(_detect_above)

func _physics_process(delta: float) -> void:
	delta = Thunder.get_delta(delta)
	
	if cast_above:
		if Input.is_action_just_pressed("m_jump"):
			jump_timer = 8
		if Input.is_action_just_released("m_jump"):
			jump_timer = 0
		
		if jump_timer > 0: jump_timer -= delta
		
		if is_player_colliding(cast_above):
			if player.global_position.rotated(player.global_rotation).y > cast_above.global_position.rotated(global_rotation).y:
				player.global_position -= Vector2(0, 1).rotated(global_rotation)
			player.states.set_state("jump")
			if jump_timer > 0:
				player.velocity_local.y = strong_jump_velocity * player.config.stomp_multiplicator
			else:
				player.velocity_local.y = weak_jump_velocity * player.config.stomp_multiplicator
				
			
			hit_from_above = true
			bump(false, 180, true)
			return
	
	if cast_below && is_player_colliding(cast_below) && player.velocity_local.y <= 50 && !player.is_on_floor():
		bump(false)
		return


func call_bump() -> void:
	bump(true)


func _creation(creation: InstanceNode2D) -> void:
	if hit_from_above:
		creation.tans_offset += Vector2(0, 32).rotated(global_rotation)
		#if creation.node.appear_distance:
	#		creation.node.appear_distance = 0
#			creation.node.appear_speed = -32
	super(creation)
	
	result = null
	
