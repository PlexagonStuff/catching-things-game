extends Node2D

onready var FishPreload = load("res://Fish/FishShadow.tscn")
var rng = RandomNumberGenerator.new()

var fishSpawnID
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
	if (rng.randi_range(1,1) == 1):
		spawn_fish()
		
		
func spawn_fish():
	var fishNumber = rng.randi_range(19,19)
	var fish = FishPreload.instance()
	fishSpawnID = FishData.fishSpawnedNumber
	fish.global_position = global_position
	fish.id = fishSpawnID
	fish.catalogID = fishNumber
	FishData.connect("despawn", fish, "despawned")
	FishData.connect("leave", fish, "left")
	FishData.connect("catch", fish, "caught")
	FishData.fishSpawnedNumber += 1
	get_node("../Navigation2D/FishContainer").add_child(fish)

func _on_PlayerDetectionArea_area_exited(area):
	FishData.emit_signal("despawn", fishSpawnID)
