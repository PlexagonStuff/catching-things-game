extends Node2D
onready var flowerResource = preload("res://Butterflies/Flower.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (Global.flowersPlaced["num"] > 0):
		for n in Global.flowersPlaced["num"]:
			var flower = flowerResource.instance()
			flower.global_position = Vector2(Global.flowersPlaced[str(n+1)]["x"],Global.flowersPlaced[str(n+1)]["y"])
			$FlowerContainer.add_child(flower)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
