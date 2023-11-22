extends KinematicBody2D
onready var waterCatcher = preload("res://Fish/WaterChecker.tscn")
onready var bobberResource = preload("res://Fish/FishBobber.tscn")
onready var fishResource = preload("res://Fish/FishSpawner.tscn")
export var ACCELERATION = 200
export var SPEED = 150
export var FRICTION = 700
var velocity = Vector2.ZERO
var touchingWater = true
enum State {Catching,Fishing,Bait,Flowers,Length}
var currentState = State.Catching

var catchAnimation = false

onready var bugArea = $NetArea/CollisionShape2D
onready var fishArea = $FishingArea/CollisionShape2D
var casted = false
var fishBobber 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Global.playerPosition
	CameraData.connect("changeCameraState",self,"beHappy") # Replace with function body.
	InventoryData.connect("hideInventory",self,"beNormal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func beHappy(cameraState):
	print("Don't worry, be happy")
	catchAnimation = true
	$AnimationPlayer.play("Catch")
	
func beNormal():
	catchAnimation = false

func _physics_process(delta):
	Global.playerPosition = global_position
	var input_vector = Vector2.ZERO
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
	if catchAnimation == false:
		if (velocity != Vector2.ZERO):
			$AnimationPlayer.play("Walk")
		else:
			$AnimationPlayer.play("Idle")
	if (currentState == State.Fishing && casted == true && touchingWater == true):
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("switchTools"):
		switch_tools()
	if Input.is_action_just_pressed("mainButton"):
		button_check()
	

func button_check():
	if currentState == State.Fishing:
		if casted == true:
			casted = false
			FishData.emit_signal("deleteBobber")
			$Tools.frame = 1
			return
		if touchingWater == true:
			var waterChecker = waterCatcher.instance()
			waterChecker.global_position = get_global_mouse_position()
			get_tree().get_current_scene().add_child(waterChecker)
			yield(get_tree().create_timer(0.1), "timeout")
			if waterChecker.touchingWater == true:
				waterChecker.queue_free()
				fishBobber = bobberResource.instance()
				fishBobber.global_position = get_global_mouse_position()
				get_tree().get_current_scene().add_child(fishBobber)
				$Tools.frame = 3
				casted = true
	
	if currentState == State.Bait:
		if touchingWater == true:
			var waterChecker = waterCatcher.instance()
			waterChecker.global_position = get_global_mouse_position()
			get_tree().get_current_scene().add_child(waterChecker)
			yield(get_tree().create_timer(0.1), "timeout")
			if waterChecker.touchingWater == true:
				waterChecker.queue_free()
				Global.emit_signal("checkNavMesh", get_global_mouse_position().x,get_global_mouse_position().y)
				yield(get_tree().create_timer(0.1), "timeout")
				var fishPosition = Global.navTarget
				var fishInstance = fishResource.instance()
				fishInstance.global_position = fishPosition
				fishInstance.mode = 1
				get_node("../Navigation2D/FishContainer").add_child(fishInstance)
				
				
				
				
				
func switch_tools():
	print(currentState)
	if currentState == State.Fishing:
		casted = false
		FishData.emit_signal("deleteBobber")
		$Tools.frame = 1
	#https://www.reddit.com/r/godot/comments/14bagn1/iterating_through_enums/
	currentState = wrapi(currentState+1,0, State.Length)
	if currentState == State.Fishing:
		#currentState = State.Fishing
		bugArea.disabled = true
		fishArea.disabled = false
		$Tools.frame = 1
	if currentState == State.Catching:
		#currentState = State.Catching
		bugArea.disabled = false
		fishArea.disabled = true
		$Tools.frame = 2
	if currentState == State.Bait:
		if InventoryData.baitOwned != 0:
			bugArea.disabled = true
			fishArea.disabled = false
			$Tools.frame = 4
		else:
			switch_tools()
	if currentState == State.Flowers:
		if InventoryData.flowersOwned != 0:
			bugArea.disabled = true
			fishArea.disabled = true
			$Tools.frame = 5
		else:
			switch_tools()
		
		
func _on_FishingArea_body_entered(body):
	if "WaterTiles" in str(body):
		touchingWater = true # Replace with function body.


func _on_FishingArea_body_exited(body):
	touchingWater = false # Replace with function body.
