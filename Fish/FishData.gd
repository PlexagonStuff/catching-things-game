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
var commonfresh = [1,2,4,5,12,14,15,16]

var rarefresh = [3,6,7,9,13,19]

var superrarefresh = [8,10,17,20]

var legendaryfresh = [11,18]

var commonocean = [21,22,24,29,30,34,36,40]

var rareocean = [26,27,28,33,37,39]

var superrareocean = [23,31,25,35]

var legendaryocean = [32,38]

var caughtFish = []
var donateFish = []

var fishStats = {
	"Common": {}
	"Rare":
	"Super Rare":
	"Legendary": 
	"19":{"name":"Sturgeon", "catchTime":0.5,"size":5}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
