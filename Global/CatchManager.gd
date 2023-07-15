extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ButterflyData.connect("catch", self, "onButterflyCatch") # Replace with function body.


func onButterflyCatch(butterflyID, catalogID):
	if (ButterflyData.caughtButterflys.has(catalogID)):
		Dialogue.emit_signal("sendDialogue", "","I caught the " + ButterflyData.butterflyStats[str(catalogID)]["name"])
	else:
		ButterflyData.caughtButterflys.append(catalogID)
		Dialogue.emit_signal("sendDialogue", "Wow!","I caught the " + ButterflyData.butterflyStats[str(catalogID)]["name"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
