extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.target_fps = 60
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

 # Replace with function body.


func _on_LoadGame_pressed():
	Global.loading() # Replace with function body.


func _on_NewGame_pressed():
	get_tree().change_scene("res://VideoPlayer.tscn") # Replace with function body.
