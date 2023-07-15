extends Node

signal despawn
signal spawn
signal leave
signal catch

#This is used for a unique idea for each bug, so that signals can be unique
var bugSpawnedNumber = 1


var caughtButterflys = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var butterflyStats = {
	"19":{"name":"Great Eggfly", "speed":40, "acceleration":150}
}
#Min scale is 0.3
var butterflyCatchData = {
	"19":{"catchScale":1, "ringSpeed":1.3, "cycles":2}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
