extends Node2D

var playerPosition = Vector2.ZERO
var bobberPosition = Vector2.ZERO
var playerAtShop = false
var money = 0

signal checkNavMesh

var navTarget
var navLocation# Declare member variables here. Examples:
	
var flowersPlaced = {"num":0}
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	InventoryData.connect("hideInventory",self,"save") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	OS.set_window_title("Piggel's Sanctuary" + " | FPS: " + str(Engine.get_frames_per_second()))

func save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var data = {}
	data["money"] = money
	data["baitOwned"] = InventoryData.baitOwned
	data["flowersOwned"] = InventoryData.flowersOwned
	data["inventory"] = InventoryData.inventory
	data["fishCaught"] = FishData.caughtFish
	data["fishDonated"] = FishData.donateFish
	data["butterfliesCaught"] = ButterflyData.caughtButterflys
	data["butterfliesDonated"] = ButterflyData.donateButterflys
	data["sound"] = Settings.sound
	data["playerPositionX"] = playerPosition.x
	data["playerPositionY"] = playerPosition.y
	data["flowersPlaced"] = flowersPlaced
	
	save_game.store_line(to_json(data))
	save_game.close()
	
func loading():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.READ)
	var data = JSON.parse(save_game.get_as_text()).result
	playerPosition = Vector2(data["playerPositionX"],data["playerPositionY"])
	InventoryData.inventory = data["inventory"]
	InventoryData.baitOwned = data["baitOwned"]
	InventoryData.flowersOwned = data["flowersOwned"]
	FishData.caughtFish = data["fishCaught"]
	FishData.donateFish = data["fishDonated"]
	ButterflyData.caughtButterflys = data["butterfliesCaught"]
	ButterflyData.donateButterflys = data["butterfliesDonated"]
	Settings.sound = data["sound"]
	money = data["money"]
	flowersPlaced = data["flowersPlaced"]
	save_game.close()
	get_tree().change_scene("res://World.tscn")
	

