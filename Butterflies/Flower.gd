extends Node2D

onready var butterflyPreload = load("res://Butterflies/Butterflies.tscn")
var rng = RandomNumberGenerator.new()

var butterflySpawnID
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerDetectionArea_area_entered(area):
	if (rng.randi_range(1,3) == 1):
		spawn_butterfly()
		
		
func spawn_butterfly():
	var butterflyNumber = rng.randi_range(1,20)
	var butterfly = butterflyPreload.instance()
	butterflySpawnID = ButterflyData.bugSpawnedNumber
	butterfly.origin_point = global_position
	butterfly.uniqueID = butterflySpawnID
	butterfly.butterflyID = butterflyNumber
	butterfly.butterflySpawnData = ButterflyData.butterflyStats[str(butterflyNumber)]
	ButterflyData.connect("despawn", butterfly, "despawned")
	ButterflyData.connect("leave", butterfly, "left")
	ButterflyData.connect("catch", butterfly, "caught")
	ButterflyData.bugSpawnedNumber += 1
	get_node("../ButterflyContainer").add_child(butterfly)

func _on_PlayerDetectionArea_area_exited(area):
	ButterflyData.emit_signal("despawn", butterflySpawnID) # Replace with function body.
