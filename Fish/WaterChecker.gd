extends Node2D

var touchingWater = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass# # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print(str(body))
	if "WaterTiles" in str(body):
		touchingWater = true
	else:
		touchingWater = false
	print("hello") # Replace with function body.


func _on_Timer_timeout():
	$Area2D/CollisionShape2D.disabled = false # Replace with function body.
