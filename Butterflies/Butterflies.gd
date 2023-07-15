extends KinematicBody2D


onready var butterflyCatchRing = preload("res://CatchingArea/BugCatchArea.tscn")
#uniqueID is only used for signals.
var uniqueID
var origin_point
var target_point

var butterflyState = ""
var butterflyCatchState = ""
var stopper = 1
var butterflySpawnData
#These will be sent in by the flower
var butterflyID
var speed
var acceleration
var catchRing
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fly")
	rng.randomize()
	global_position = origin_point
	speed = butterflySpawnData["speed"]
	acceleration = butterflySpawnData["acceleration"]
	butterflyState = "Flies"
	var point = Vector2(rng.randi_range(-200,200),rng.randi_range(-200,200))
	target_point = Vector2((origin_point.x + point.x), (origin_point.y + point.y)) # Replace with function body.


func _physics_process(delta):
	
	var direction = global_position.direction_to(target_point)
	if global_position.distance_to(target_point) < 2:
		stopper = 0
	else: 
		stopper = 1
	velocity = velocity.move_toward(direction * speed * stopper, acceleration * delta)
	velocity = move_and_slide(velocity)
	
	#var tween = get_node("Tween")
	#tween.interpolate_property(self, "position",
	#global_position, target_point, 2,
	#Tween.TRANS_LINEAR, Tween.EASE_OUT)
	#tween.start()



func despawned(id):
	if id == uniqueID:
		queue_free()
		
func left(id, catalogID):
	if id == uniqueID:
		print("I made it here")
		$AnimationPlayer.play("Leave")
		catchRing.queue_free()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func caught(id, catalogID):
	if id == uniqueID:
		print("You caught a thing!")
		CameraData.emit_signal("changeCameraState", CameraData.ZOOMONPLAYER)
		queue_free()

func _on_StateTimer_timeout():
	if butterflyState == "Flies":
		target_point = origin_point
		butterflyState = "OnFlower"
	elif butterflyState == "OnFlower":
		$AnimationPlayer.play("Idle")
		if (rng.randi_range(1,2) == 1):
			target_point = origin_point
			butterflyState = "OnFlower"
			
		else:
			$AnimationPlayer.play("Fly")
			var point = Vector2(rng.randi_range(-200,200),rng.randi_range(-200,200))
			target_point = Vector2(origin_point.x + point.x, origin_point.y + point.y)
			butterflyState = "Flies"
			


func _on_CatchArea_area_entered(area):
	catchRing = butterflyCatchRing.instance()
	catchRing.bugID = uniqueID
	catchRing.catalogID = butterflyID
	catchRing.catchData = ButterflyData.butterflyCatchData[str(butterflyID)]
	self.add_child(catchRing)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Leave":
		print("Did this happen?")
		queue_free()


func _on_CatchArea_area_exited(area):
	$AnimationPlayer.play("Leave")
	print(str(catchRing))
	if str(catchRing) != "[Deleted Object]":
		catchRing.visible = false # Replace with function body.
