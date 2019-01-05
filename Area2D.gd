extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MAXSPEED = 75

var camera
var hitSound


onready var headGore = preload("res://gore/MonsterGoreHead.tscn")
onready var tailGore = preload("res://gore/MonsterGoreTail.tscn")
onready var otherGore = preload("res://gore/MonsterGoreCrystal.tscn")

func _ready():
	camera = get_parent().get_parent().get_parent().get_node("Camera2D")
	hitSound = get_node("HitSound")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Area2D_body_entered(body):
	var gore = [ headGore.instance(), tailGore.instance(), otherGore.instance(), otherGore.instance()  ]

	for i in range (0,gore.size()):
		get_tree().get_root().get_node("Node2D").get_node("TileMap").add_child(gore[i])
		if(randi() % 2 == 1):
			gore[i].get_node("Sprite").flip_h = false
		else:
			gore[i].get_node("Sprite").flip_h = true
		gore[i].rotate(randf())
		gore[i].set_axis_velocity(Vector2(rand_range(-MAXSPEED,MAXSPEED),rand_range(-MAXSPEED,0)))
		gore[i].global_position = body.global_position + Vector2(rand_range(-15,15),rand_range(-10,0))
		
		
		
		
	
	timeScale._set_time_scale(0,5,3)
	camera._set_shake(2,0.5);
	camera._set_zoom(0.35,0.2);
	body.queue_free()
	hitSound.pitch_scale = rand_range(0.7,1.1)
	hitSound.play()
	pass # replace with function body
