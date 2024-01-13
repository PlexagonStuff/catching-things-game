extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_ShopEntrance_area_entered(area):
	InventoryData.shopOpen
	InventoryData.inStore = true
	InventoryData.emit_signal("showItemShop") # Replace with function body.
	InventoryData.normalInventoryOpen = true

func _on_ShopEntrance_area_exited(area):
	InventoryData.inStore = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
