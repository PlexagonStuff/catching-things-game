extends KinematicBody2D
onready var waterCatcher = preload("res://Fish/WaterChecker.tscn")
onready var bobberResource = preload("res://Fish/FishBobber.tscn")
export var ACCELERATION = 200
export var SPEED = 150
export var FRICTION = 700
var velocity = Vector2.ZERO
var touchingWater = true
enum State {Catching,Fishing}
var currentState = State.Catching
onready var bugArea = $NetArea/CollisionShape2D
onready var fishArea = $FishingArea/CollisionShape2D
var casted = false
var fishBobber 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	Global.playerPosition = global_position
	var input_vector = Vector2.ZERO
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
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
				casted = true
				
				
				
				
func switch_tools():
	if currentState == State.Catching:
		currentState = State.Fishing
		bugArea.disabled = true
		fishArea.disabled = false
		$Tools.frame = 1
	else:
		currentState = State.Catching
		bugArea.disabled = false
		fishArea.disabled = true
		$Tools.frame = 2
		
func _on_FishingArea_body_entered(body):
	if "WaterTiles" in str(body):
		touchingWater = true # Replace with function body.


func _on_FishingArea_body_exited(body):
	touchingWater = false # Replace with function body.
