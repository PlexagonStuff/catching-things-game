extends Node2D

onready var butterflyPreload = load("res://Butterflies/Butterflies.tscn")
var rng = RandomNumberGenerator.new()

var butterflySpawnID
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$Sprite.frame = rng.randi_range(0,4)# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerDetectionArea_area_entered(area):
	if (rng.randi_range(1,3) == 1):
		spawn_butterfly()
		
		
func spawn_butterfly():
	var butterfly = butterflyPreload.instance()
	var butterflyNumber = 1
	var butterflyCatchData
	var spawnChance = rng.randi_range(1,100)
	if spawnChance <= 60:
		butterflyNumber = ButterflyData.common[rng.randi_range(0,ButterflyData.common.size()-1)]
		butterflyCatchData = ButterflyData.butterflyCatchData["Common"]
	elif spawnChance > 60 and spawnChance <= 90:
		butterflyNumber = ButterflyData.rare[rng.randi_range(0,ButterflyData.rare.size()-1)]
		butterflyCatchData = ButterflyData.butterflyCatchData["Rare"]
	elif spawnChance > 90 and spawnChance <= 98:
		butterflyNumber = ButterflyData.superrare[rng.randi_range(0,ButterflyData.superrare.size()-1)]
		butterflyCatchData = ButterflyData.butterflyCatchData["SuperRare"]
	else:
		butterflyNumber = 16
		butterflyCatchData = ButterflyData.butterflyCatchData["Legendary"]
	butterflySpawnID = ButterflyData.bugSpawnedNumber
	butterfly.origin_point = global_position
	butterfly.uniqueID = butterflySpawnID
	butterfly.butterflyID = butterflyNumber
	butterfly.butterflyCatchData = butterflyCatchData
	butterfly.butterflySpawnData = ButterflyData.butterflyStats[str(butterflyNumber)]
	ButterflyData.connect("despawn", butterfly, "despawned")
	ButterflyData.connect("leave", butterfly, "left")
	ButterflyData.connect("catch", butterfly, "caught")
	ButterflyData.bugSpawnedNumber += 1
	get_node("../../ButterflyContainer").add_child(butterfly)

func _on_PlayerDetectionArea_area_exited(area):
	ButterflyData.emit_signal("despawn", butterflySpawnID) # Replace with function body.
