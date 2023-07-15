extends Node2D

export var maxCatchCycles = 0

export var catchRingStartScale = Vector2(0,0)

var catchCycles
export var movingRingScaleFactor = 0.0
var time = 0

var bugID
var movingScale


var catalogID
var catchData
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	catchRingStartScale = Vector2(catchData["catchScale"],catchData["catchScale"])
	$CatchRing.scale = catchRingStartScale
	movingRingScaleFactor = catchData["ringSpeed"]
	maxCatchCycles = catchData["cycles"]
	catchCycles = 0
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("mainButton"):
		process_catch()
		yield()
	movingScale = (-movingRingScaleFactor * pow(time,2)) + 1.3
	print(movingScale)
	time = time + delta
	$MovingRing.scale = Vector2(movingScale, movingScale)
	if movingScale <= 0.3:
		time = 0
		catchCycles = catchCycles + 1
	if catchCycles == maxCatchCycles:
		print("leave")
		ButterflyData.emit_signal("leave",  bugID, catalogID)
		queue_free()
		
		
func process_catch():
	print("At catch: " + str(movingScale))
	var caught = (movingScale <= catchRingStartScale.x)
	if (caught):
		print("success!")
		ButterflyData.emit_signal("catch",  bugID, catalogID)
		queue_free()
	else:
		print("leave")
		ButterflyData.emit_signal("leave", bugID, catalogID)
		queue_free()
