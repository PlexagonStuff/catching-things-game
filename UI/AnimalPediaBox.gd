extends Node2D

var id
var mode
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if mode == AnimalPediaData.Tab.Butterfly:
		$ButterflyIcon.visible = true
		$FishIcon.visible = false
		$ButterflyIcon.frame = id-1
		var counter = 0
		for bugs in ButterflyData.caughtButterflys:
			if bugs == id:
				counter = counter + 1
		if counter == 0:
			$ButterflyIcon.modulate = Color(0,0,0)
	if mode == AnimalPediaData.Tab.Freshwater or mode == AnimalPediaData.Tab.Ocean:
		$ButterflyIcon.visible = false
		$FishIcon.visible = true
		$FishIcon.frame = id-1
		var counter = 0
		for bugs in FishData.caughtFish:
			if bugs == id:
				counter = counter + 1
		if counter == 0:
			$FishIcon.modulate = Color(0,0,0)
			 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	AnimalPediaData.emit_signal("showAnimalLayout", mode, id) # Replace with function body.
