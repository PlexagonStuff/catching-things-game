extends Node2D

#Corresponds to ID in the Inventory json
var id
var mode
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var catalogID = InventoryData.inventory[str(id)]["catalogID"]
	var type = InventoryData.inventory[str(id)]["type"]
	if type == "Bug":
		$ButterflyIcon.frame = catalogID-1
		 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	if mode == InventoryData.Mode.Release:
		InventoryData.inventory[str(id)] = InventoryData.quarantinedItem
		InventoryData.emit_signal("hideInventory") # Replace with function body.
		InventoryData.normalMode = true

func _on_TextureButton_mouse_entered():
	get_parent().get_node("TitleCard").get_node("ItemName").text = InventoryData.inventory[str(id)]["name"] # Replace with function body.


func _on_TextureButton_mouse_exited():
	get_parent().get_node("TitleCard").get_node("ItemName").text = ""
