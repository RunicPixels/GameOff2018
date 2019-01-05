extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 300.0
const MAX_GRAVITY = 500
const WALK_SPEED = 15
const JUMP_HEIGHT = 196
const MAX_WALK_SPEED = 135
const FALL_DELAY = 0.1

var canJump = true;
var canFall = true;
var fallTimer = 0
var velocity = Vector2()
var body

func _ready():
	set_meta("Player", true)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if(canFall == true):
		fallTimer -= delta
		
	if(fallTimer < 0):
		canFall = false

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		get_node("Sprite").flip_h = false;
		if(get_node("Sprite").animation != "walking"):
			get_node("Sprite").play("walking")
		if(velocity.x > 0.1):
			velocity.x = 0;
		if(velocity.x > -MAX_WALK_SPEED):
			velocity.x += -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		get_node("Sprite").flip_h = true;
		if(get_node("Sprite").animation != "walking"):
			get_node("Sprite").play("walking")
		if(velocity.x < -0.1):
			velocity.x = 0;
		if(velocity.x < MAX_WALK_SPEED):
			velocity.x += WALK_SPEED
	else:
		velocity.x *= 0.5
		if(get_node("Sprite").animation != "idle"):
			get_node("Sprite").play("idle")
	
	if(velocity.x > MAX_WALK_SPEED):
		velocity.x -= 4;
	elif(velocity.x < -MAX_WALK_SPEED):
		velocity.x += 4;
	
	if(GRAVITY < MAX_GRAVITY):
		if (velocity.y < - 10):
			velocity.y += delta * GRAVITY * 1.5
		elif(velocity.y > 5 or velocity.y < -8):
			velocity.y += delta * GRAVITY
		else:
			velocity.y += delta * GRAVITY / 2
	
	var motion = velocity

	move_and_slide(motion, Vector2(0,-8))
	
	
	if(is_on_floor() == true):
		if(Input.is_action_pressed("ui_up")):
			velocity.y = -JUMP_HEIGHT;
		else:
			velocity.y = 0;
			
	if(velocity.y < -0.1 or Input.is_action_pressed("ui_down")):
		set_collision_layer_bit (3, false)
		set_collision_mask_bit(3,false)
		if(Input.is_action_pressed("ui_down")):
			canFall = true
			fallTimer = FALL_DELAY
	elif(velocity.y > 40 and canFall == false):
		set_collision_layer_bit (3, true)
		set_collision_mask_bit(3,true)
	
	
