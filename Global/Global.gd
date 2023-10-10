extends Node2D

var playerPosition = Vector2.ZERO
var playerAtShop = false
var money = 0
# Declare member variables here. Examples:
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
	data["inventory"] = InventoryData.inventory
	data["fishCaught"] = FishData.caughtFish
	data["fishDonated"] = FishData.donateFish
	data["butterfliesCaught"] = ButterflyData.caughtButterflys
	data["butterfliesDonated"] = ButterflyData.donateButterflys
	data["playerPositionX"] = playerPosition.x
	data["playerPositionY"] = playerPosition.y
	save_game.store_line(to_json(data))
	save_game.close()
	
func loading():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.READ)
	var data = JSON.parse(save_game.get_as_text()).result
	playerPosition = Vector2(data["playerPositionX"],data["playerPositionY"])
	InventoryData.inventory = data["inventory"]
	FishData.caughtFish = data["fishCaught"]
	FishData.donateFish = data["fishDonated"]
	ButterflyData.caughtButterflys = data["butterfliesCaught"]
	ButterflyData.donateButterflys = data["butterfliesDonated"]
	money = data["money"]
	save_game.close()
	get_tree().change_scene("res://World.tscn")
	

