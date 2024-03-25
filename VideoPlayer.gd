extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mainButton"):
		get_tree().change_scene("res://World.tscn")


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://World.tscn")# Replace with function body.
