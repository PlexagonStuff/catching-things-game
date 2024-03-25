extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HBoxContainer/Label.text = ": " + str(Settings.sound)


func _on_LinkButton_pressed():
	Global.save()
	get_tree().quit() # Replace with function body.


func _on_TextureButton_pressed():
	Settings.sound = !Settings.sound
