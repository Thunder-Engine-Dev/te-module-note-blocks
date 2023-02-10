extends StaticBumpingBlock

@export var weak_jump_velocity: float = -450
@export var strong_jump_velocity: float = -950
var jump_timer: float

var hit_from_above = false

func _ready() -> void:
	area_below.body_entered.connect(_detect_below)
	area_above.body_entered.connect(_detect_above)

func _physics_process(delta: float) -> void:
	delta = Thunder.get_delta(delta)
	if Input.is_action_just_pressed("m_jump"):
		jump_timer = 8
	if Input.is_action_just_released("m_jump"):
		jump_timer = 0
	
	if jump_timer > 0: jump_timer -= delta


func _detect_below(body) -> void:
	if triggered: return
	
	if body is Player:
		if body.velocity_local.y < body.config.max_fall_speed:
			bump(false)
			return

func _detect_above(body) -> void:
	if body is Player:
		body.states.set_state("jump")
		if jump_timer > 0:
			body.velocity_local.y = strong_jump_velocity * body.config.stomp_multiplicator
		else:
			body.velocity_local.y = weak_jump_velocity * body.config.stomp_multiplicator
		
		hit_from_above = true
		bump(false, 180, true)
		
		return

func call_bump() -> void:
	bump(true)


func _creation(creation: Node2DCreation) -> void:
	if hit_from_above:
		creation.creation_offset += Vector2(0, 32).rotated(global_rotation)
		#if creation.node.appear_distance:
	#		creation.node.appear_distance = 0
#			creation.node.appear_speed = -32
	super(creation)
	
	result = null
	
