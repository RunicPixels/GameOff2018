extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const ATTACK_RANGE = 12
const ATTACK_MODE = 1
const DASH_RANGE = 275
const JUMP_RANGE = 160
var offset_begin
var area
var body
var collisionShape
var mainSprite

func _ready():
	offset_begin = offset
	frame = 0
	flip_v = true
	mainSprite = get_parent()
	body = mainSprite.get_parent()
	area = get_node("Area2D")
	collisionShape = area.get_node("CollisionShape2D")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("animation_finished",self,"_finished");
	pass

func _process(delta):
	delta *= timeScale.timeScale
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	if(frame == 1):
		collisionShape.disabled = false
		
	else:
		collisionShape.disabled = true
		
	if(not is_playing()):
		if(get_global_mouse_position().x < global_position.x and ATTACK_MODE == 0 or mainSprite.flip_h == false and ATTACK_MODE == 1):
			flip_h = false;
			offset = offset_begin
			collisionShape.position.x = -ATTACK_RANGE
		elif(ATTACK_MODE == 0 or mainSprite.flip_h == true and ATTACK_MODE == 1):
			flip_h = true;
			offset = -offset_begin
			collisionShape.position.x = ATTACK_RANGE
		if(Input.is_action_pressed("ui_select")):
			visible = true;
			flip_v = !flip_v;
			flip_h = !flip_h;
			offset = -offset;
			frame = 0;
			area.get_node("AudioStreamPlayer2D").pitch_scale = rand_range(0.8,1.2)
			area.get_node("AudioStreamPlayer2D").play()
			body.get_node("Camera2D")._set_shake(0.3,0.2);
			body.get_node("Camera2D")._set_zoom(0.1,0.33);
			body.velocity.y *= 0.2
			if(flip_v== true):
				body.velocity.y += JUMP_RANGE
			else:
				body.velocity.y -= JUMP_RANGE
			if(body.is_on_floor() == false):
				if(body.velocity.x > 0):
					body.velocity.x = DASH_RANGE
				elif(body.velocity.x < 0):
					body.velocity.x = -DASH_RANGE
			play()
#	pass

func _finished():
	#visible = false;
	stop()
