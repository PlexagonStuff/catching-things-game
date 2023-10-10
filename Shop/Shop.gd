extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ShopEntrance_area_entered(area):
	InventoryData.emit_signal("showInventory",InventoryData.Mode.Sell)
	InventoryData.inStore = true
	Dialogue.emit_signal("sendDialogue","Welcome to the Pet Store!","We want your pets! Press E to exit at any time") # Replace with function body.
	InventoryData.normalInventoryOpen = true

func _on_ShopEntrance_area_exited(area):
	InventoryData.inStore = false # Replace with function body.
