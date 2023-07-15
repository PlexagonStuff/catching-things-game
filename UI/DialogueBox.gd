extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogue.connect("sendDialogue", self, "processDialogue" ) # Replace with function body.

func processDialogue(topText, bottomText):
	$TopText.text = topText
	$BottomText.text = bottomText
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
