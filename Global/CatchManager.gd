extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ButterflyData.connect("catch", self, "onButterflyCatch")
	FishData.connect("catch",self,"onFishCatch") # Replace with function body.


func onButterflyCatch(butterflyID, catalogID):
	if (ButterflyData.caughtButterflys.has(catalogID)):
		Dialogue.emit_signal("sendDialogue", "","I caught the " + ButterflyData.butterflyStats[str(catalogID)]["name"])
	else:
		ButterflyData.caughtButterflys.append(catalogID)
		Dialogue.emit_signal("sendDialogue", "Wow!","I caught the " + ButterflyData.butterflyStats[str(catalogID)]["name"])
	InventoryData.emit_signal("addInventory","Bug",catalogID)
	
		
func onFishCatch(fishID, catalogID):
	if (FishData.caughtFish.has(catalogID)):
		Dialogue.emit_signal("sendDialogue", "","I caught the " + FishData.fishStats[str(catalogID)]["name"])
	else:
		FishData.caughtFish.append(catalogID)
		Dialogue.emit_signal("sendDialogue", "Wow!","I caught the " + FishData.fishStats[str(catalogID)]["name"])
	InventoryData.emit_signal("addInventory","Fish",catalogID)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
