extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_ShopEntrance_area_entered(area):
	InventoryData.emit_signal("showInventory",InventoryData.Mode.Donate)
	InventoryData.inStore = true
	Dialogue.emit_signal("sendDialogue","Welcome to the Donation Barge!","All new specimens will be sent to conservatories across the world!") # Replace with function body.
	InventoryData.normalInventoryOpen = true

func _on_ShopEntrance_area_exited(area):
	InventoryData.inStore = false
