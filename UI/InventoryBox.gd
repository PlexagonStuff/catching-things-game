extends Node2D

#Corresponds to ID in the Inventory json
var id
var mode
var type
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var catalogID = InventoryData.inventory[str(id)]["catalogID"]
	type = InventoryData.inventory[str(id)]["type"]
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
	if mode == InventoryData.Mode.Sell:
		#MAKE SURE TO ADD THE WHOLE EARNING MONEY PART HERE
		InventoryData.shiftInventory(id)
		InventoryData.emit_signal("hideInventory")
		InventoryData.emit_signal("showInventory",InventoryData.Mode.Sell)
		queue_free()
	if mode == InventoryData.Mode.Donate:
		var catalogID = InventoryData.inventory[str(id)]["catalogID"]
		if type == "Bug":
			var counter = 0
			for bugs in ButterflyData.donateButterflys:
				if bugs == catalogID:
					counter = counter + 1
			if counter == 0:
				ButterflyData.donateButterflys.append(catalogID)
				InventoryData.shiftInventory(id)
				InventoryData.emit_signal("hideInventory")
				InventoryData.emit_signal("showInventory",InventoryData.Mode.Donate)
				queue_free()
		else:
			var counter = 0
			for fish in FishData.donateFish:
				if fish == catalogID:
					counter = counter + 1
			if counter == 0:
				FishData.donateFish.append(catalogID)
				InventoryData.shiftInventory(id)
				InventoryData.emit_signal("hideInventory")
				InventoryData.emit_signal("showInventory",InventoryData.Mode.Donate)
				queue_free()	
			
			
func _on_TextureButton_mouse_entered():
	get_parent().get_node("TitleCard").get_node("ItemName").text = InventoryData.inventory[str(id)]["name"] # Replace with function body.
	if mode == InventoryData.Mode.Sell:
		Dialogue.emit_signal("sendDialogue","","This is placeholder sell text")

func _on_TextureButton_mouse_exited():
	get_parent().get_node("TitleCard").get_node("ItemName").text = ""
		