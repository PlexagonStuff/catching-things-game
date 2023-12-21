extends Node2D

onready var FishPreload = load("res://Fish/FishShadow.tscn")
var rng = RandomNumberGenerator.new()

var fishSpawnID
#0 is basic function, 1 is when spawned by fish bait
export var mode = 0
#0 equals freshwater, 1 equals ocean
export var location = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerDetectionArea_area_entered(area):
	if mode == 0:
		if (rng.randi_range(1,1) == 1):
			spawn_fish()
	else:
		#Fish Bait Part
		if (rng.randi_range(1,1) == 1):
			spawn_fish()
		
		
func spawn_fish():
	var fishNumber = rng.randi_range(19,19)
	var spawnChance = rng.randi_range(1,100)
	if spawnChance <= 60: #Common
		if location == 0:
			fishNumber = FishData.commonfresh[rng.randi_range(0,FishData.commonfresh.size()-1)]
		else:
			fishNumber = FishData.commonocean[rng.randi_range(0,FishData.commonocean.size()-1)]
	elif spawnChance > 60 and spawnChance <= 90: #Rare
		if location == 0:
			fishNumber = FishData.rarefresh[rng.randi_range(0,FishData.rarefresh.size()-1)]
		else:
			fishNumber = FishData.rareocean[rng.randi_range(0,FishData.rareocean.size()-1)]
	elif spawnChance > 90 and spawnChance <= 98: #Super Rare
		if location == 0:
			fishNumber = FishData.superrarefresh[rng.randi_range(0,FishData.superrarefresh.size()-1)]
		else:
			fishNumber = FishData.superrareocean[rng.randi_range(0,FishData.superrareocean.size()-1)]
	else: #Legendary
		if location == 0:
			fishNumber = FishData.legendaryfresh[rng.randi_range(0,FishData.legendaryfresh.size()-1)]
		else:
			fishNumber = FishData.legendaryocean[rng.randi_range(0,FishData.legendaryocean.size()-1)]
	
	var fish = FishPreload.instance()
	fishSpawnID = FishData.fishSpawnedNumber
	fish.global_position = global_position
	fish.id = fishSpawnID
	fish.catalogID = fishNumber
	fish.scale = Vector2(FishData.fishStats["Sizes"][FishData.fishStats[str(fishNumber)]["size"]-1],FishData.fishStats["Sizes"][FishData.fishStats[str(fishNumber)]["size"]-1])
	FishData.connect("despawn", fish, "despawned")
	FishData.connect("leave", fish, "left")
	FishData.connect("catch", fish, "caught")
	FishData.fishSpawnedNumber += 1
	get_parent().add_child(fish)
	

func _on_PlayerDetectionArea_area_exited(area):
	FishData.emit_signal("despawn", fishSpawnID)
	if mode == 1:
		queue_free()
