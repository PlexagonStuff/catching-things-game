extends Node2D

signal onBobber
signal bobberLeft
signal deleteBobber
signal leave
signal catch
signal registerFish
signal spawn
signal despawn

var fishOnBobber = false

var fishSpawnedNumber = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var caughtFish = []
var donateFish = []

var fishStats = {
	"19":{"name":"Sturgeon", "catchTime":0.5,"size":5}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
