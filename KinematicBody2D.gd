extends KinematicBody2D

const MOVESPEED = 2500
const GRAVITY = 300.0
const MAX_GRAVITY = 500

var rayCast
var rayCast2
var sprite
var movingLeft = true
var velocity = Vector2()
var die = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	rayCast = get_node("RayCast2D")
	rayCast2 = get_node("RayCast2D2")
	sprite = get_node("Node2D")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	if(movingLeft):
		velocity = Vector2(-MOVESPEED,0)
	else:
		velocity = Vector2(MOVESPEED,0)
		
	if(GRAVITY < MAX_GRAVITY):
		velocity.y += GRAVITY
		
	move_and_slide(velocity * delta, Vector2(0,-12))
	
	if(rayCast.is_colliding() == false) or rayCast2.is_colliding() == true:
		rayCast.position = -rayCast.position
		if(rayCast2.is_colliding()):
			do_collision(rayCast2.get_collider())
		if(not die):
			rayCast2.position = - rayCast2.position
			rayCast2.cast_to = - rayCast2.cast_to;
			movingLeft = !movingLeft
			sprite.flip_h = !sprite.flip_h
		
func do_collision(collision):
	if(collision.has_meta("Player")):
		die = true
		timeScale._die_time_scale(0.5,0.5,5)

	