extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MoneyLabel.text = "Money: " + str(Global.money)


func _on_BaitTextureButton_pressed():
	if Global.money >= 300:
		Global.money = Global.money - 300
		InventoryData.baitOwned += 1


func _on_FlowerTextureButton_pressed():
	if Global.money >= 400:
		Global.money = Global.money - 400
		InventoryData.flowersOwned += 1 # Replace with function body.
