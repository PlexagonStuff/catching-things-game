extends Node2D

signal showPedia
signal hidePedia
signal showAnimalLayout

enum Tab {Butterfly,Freshwater,Ocean}

#Use this to store the previous tab after switching to animal details
var currentState

var open = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
