extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var amount = 0
var duration = 0
var maxDuration = 0

var zoomAmount = 1
var zoomDuration = 0
var maxZoomDuration = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(duration > 0):
		offset = Vector2(rand_range(-amount, amount) * (duration / maxDuration),rand_range(-amount, amount) * (duration / maxDuration))
		duration -= delta;
	
	if(duration <= 0):
		offset = Vector2(0,0)
	
	if(zoomDuration > (maxZoomDuration / 2.0)):
		var toZoom = 1 - (zoomAmount * (maxZoomDuration - zoomDuration)/ maxZoomDuration)
		zoom = Vector2(toZoom,toZoom)
		zoomDuration -= delta;
		print("Zoom1" + " " + String(zoomDuration) + " " + String(maxZoomDuration))
	elif(zoomDuration > 0):
		var toZoom = 1 - (zoomAmount * zoomDuration / maxZoomDuration)
		zoom = Vector2(toZoom,toZoom)
		zoomDuration -= delta;
		print("Zoom2" + " " + String(zoomDuration) + " " + String(maxZoomDuration))
	else:
		zoom = Vector2(1,1)
		

func _set_shake(var amountToShake, var durationToShake):
	if(amount< amountToShake):
		 amount = amountToShake
	if(duration < durationToShake):
		duration = durationToShake
		maxDuration = durationToShake
	#print("Setting Shake")
	
func _set_zoom(var amountToZoom, var durationOfZoom):
	zoomAmount = amountToZoom
	zoomDuration = durationOfZoom
	maxZoomDuration = durationOfZoom
	
	