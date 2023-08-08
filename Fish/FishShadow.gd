extends KinematicBody2D
onready var waterCatcher = preload("res://Fish/WaterChecker.tscn")
enum State {Swimming, CatchProcess, FindingPoint, Reel}
var currentState = State.FindingPoint
var rng = RandomNumberGenerator.new()

var id
var catalogID

var catchCycles = 0
var bobberPoint
var currentCatchCycle = 0
var catchCycleTime = 2

var target_point
var velocity = Vector2.ZERO
var speed = 60
var acceleration = 10
var stopper
onready var navagent = $NavigationAgent2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	FishData.connect("bobberLeft",self,"leave")
	FishData.connect("catch",self,"caught")
	rng.randomize()
	currentState = State.Swimming
	target_point = Vector2(global_position.x + rng.randi_range(-100,100), global_position.y + rng.randi_range(-100,100))
	navagent.set_target_location(target_point)
	#print(navagent.get_target_location())

func _physics_process(delta):
	if $RayCast2D.is_colliding() && currentState == State.Swimming && FishData.fishOnBobber == false:
		currentState = State.CatchProcess
		FishData.emit_signal("registerFish",id, catalogID)
		bobberPoint = $RayCast2D.get_collision_point()
		catch_process()
	if (currentState == State.Swimming):
		look_at(target_point)
	if (currentState == State.CatchProcess):
		look_at(bobberPoint)
	if (navagent.is_navigation_finished()):
		return
	stopper = 1
	var direction = global_position.direction_to(navagent.get_next_location())
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * (acceleration * delta)
	#print(steering)
	velocity = velocity + steering
	#print(velocity)
	velocity = move_and_slide(velocity)
	
	
func catch_process():
	var time = 2
	var startPoint = global_position
	catchCycles = (rng.randi_range(1,3)*2)
	target_point = bobberPoint
	navagent.set_target_location(target_point)
	#look_at(bobberPoint)
	$CatchPhaseTimer.start(catchCycleTime)
	
func _on_CatchPhaseTimer_timeout():
	currentCatchCycle +=1
	print(currentCatchCycle) 
	if (currentCatchCycle < (catchCycles + 1)):
		if ((currentCatchCycle % 2) != 0):
			target_point = Vector2(bobberPoint.x + rng.randi_range(-50,50), bobberPoint.y + rng.randi_range(-50,50))
			navagent.set_target_location(target_point)
			$CatchPhaseTimer.start(catchCycleTime)
		else:
			target_point = bobberPoint
			navagent.set_target_location(target_point)
			$CatchPhaseTimer.start(catchCycleTime)
	else:
		FishData.emit_signal("onBobber",id)
		
		
func leave(fishID):
	if (fishID == id):
		$AnimationPlayer.play("Leave")
		FishData.fishOnBobber = false
		
func despawned(fishID):
	if (fishID == id):
		queue_free()
		
func caught(id, catalogID):
	print("You caught a thing!")
	CameraData.emit_signal("changeCameraState", CameraData.ZOOMONPLAYER)
	queue_free()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Leave":
		print("Did this happen?")
		queue_free()
			 # Replace with function body.
#		look_at(bobberPoint)
#		target_point = Vector2(bobberPoint.x + rng.randi_range(-50,50), bobberPoint.y + rng.randi_range(-50,50))
#		yield(get_tree().create_timer(time), "timeout")
# Called when the node enters the scene tree for the first time.
#func _ready():
#	var currentState = State.FindingPoint
#	rng.randomize()
#	find_target_point(1)
#	print(target_point)
#	# Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
#func _physics_process(delta):
#	#print(currentState)
#	if currentState == State.CatchProcess or currentState == State.Reel:
#		pass
#	else:
#		if $RayCast2D.is_colliding():
#			currentState = State.CatchProcess
#			target_point = $RayCast2D.get_collision_point()
#			catch_process()
#	if currentState == State.Swimming:
#		var direction = global_position.direction_to(target_point)
#		if global_position.distance_to(target_point) < 30:
#			stopper = 0
#		else: 
#			stopper = 1
#		velocity = velocity.move_toward(direction * speed * stopper, acceleration * delta)
#		velocity = move_and_slide(velocity)
#
#func find_target_point(var tries):
#	var targetPoint = Vector2(global_position.x + rng.randi_range(-200,200), global_position.y + rng.randi_range(-200,200))
#	var waterChecker = waterCatcher.instance()
#	waterChecker.global_position = targetPoint
#	get_tree().get_current_scene().add_child(waterChecker)
#	yield(get_tree().create_timer(0.1), "timeout")
#	if waterChecker.touchingWater == false:
#		waterChecker.queue_free()
#		return find_target_point(tries + 1)
#	else:
#		waterChecker.queue_free()
#		currentState = State.Swimming
#		print(targetPoint)
#		look_at(targetPoint)		
#		target_point = targetPoint
#		return 
#
#
#func catch_process():
#	for n in (rng.randi_range(1,3)):
#		var time = rng.randf_range(1,2)
#		var startPos = global_position
#		var tween = get_node("Tween")
#		tween.interpolate_property(self, "position",
#		global_position, target_point, time,
#		Tween.TRANS_LINEAR, Tween.EASE_OUT)
#		tween.start()
#		look_at(target_point)
#		print("Going Back")
#		yield(get_tree().create_timer(time), "timeout")
#		tween = get_node("Tween")
#		tween.interpolate_property(self, "position",
#		global_position, target_point + Vector2(rng.randi_range(-20,20),rng.randi_range(-20,20)), time,
#		Tween.TRANS_LINEAR, Tween.EASE_OUT)
#		tween.start()
#		#look_at(target_point)
#		print("Going Forward")
#		yield(get_tree().create_timer(time), "timeout")
#
#	var tween = get_node("Tween")
#	tween.interpolate_property(self, "position",
#	global_position, target_point, 1,
#	Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	tween.start()
#	look_at(target_point)
#	yield(get_tree().create_timer(1), "timeout")
#	print("Gonna Bite")
#	currentState = State.Reel
#	return
#
#
#func _on_Timer_timeout():
#	if currentState == State.Swimming:
#		currentState = State.FindingPoint
#		find_target_point(1)
#		 # Replace with function body.

func _on_Timer_timeout():
	if (currentState == State.Swimming):
		target_point = Vector2(global_position.x + rng.randi_range(-50,50), global_position.y + rng.randi_range(-50,50))
		navagent.set_target_location(target_point) # Replace with function body.



