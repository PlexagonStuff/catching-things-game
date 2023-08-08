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
	"1":{"name":"Template Butterfly", "speed":40, "acceleration":150},
	"2":{"name":"Monarch Butterfly", "speed":40, "acceleration":150},
	"3":{"name":"Agrias Butterfly", "speed":60, "acceleration":150},
	"4":{"name":"Eastern Tiger Swallowtail", "speed":40, "acceleration":150},
	"5":{"name":"Cabbage White Butterfly", "speed":40, "acceleration":150},
	"6":{"name":"Common Blue Butterfly", "speed":40, "acceleration":150},
	"7":{"name":"Falcate Orangetip", "speed":40, "acceleration":150},
	"8":{"name":"Grey Hairstreak", "speed":40, "acceleration":150},
	"9":{"name":"Common Sootywing", "speed":40, "acceleration":150},
	"10":{"name":"Milbert's Tortoiseshell", "speed":40, "acceleration":150},
	"11":{"name":"Common Bluebottle", "speed":40, "acceleration":150},
	"12":{"name":"Old World Swallowtail", "speed":40, "acceleration":150},
	"13":{"name":"Peacock Butterfly", "speed":40, "acceleration":150},
	"14":{"name":"Rajah Brooke's Birdwing", "speed":40, "acceleration":150},
	"15":{"name":"Great Purple Emperor", "speed":40, "acceleration":150},
	"16":{"name":"Queen Alexandria's Birdwing", "speed":40, "acceleration":150},
	"17":{"name":"Chinese Peacock Butterfly", "speed":40, "acceleration":150},
	"18":{"name":"Blue Morphos Butterfly", "speed":40, "acceleration":150},
	"19":{"name":"Clouded Yellow Butterfly", "speed":40, "acceleration":150},
	"20":{"name":"Great Eggfly", "speed":40, "acceleration":150}
}
#Min scale is 0.3
var butterflyCatchData = {
	"1":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"2":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"3":{"catchScale":1, "ringSpeed":1.3, "cycles":2},
	"4":{"catchScale":0.9, "ringSpeed":1.2, "cycles":2},
	"5":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"6":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"7":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"8":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"9":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"10":{"catchScale":1, "ringSpeed":1, "cycles":2},
	"11":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"12":{"catchScale":1.2, "ringSpeed":1, "cycles":1},
	"13":{"catchScale":0.9, "ringSpeed":1.4, "cycles":2},
	"14":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"15":{"catchScale":1.3, "ringSpeed":1.6, "cycles":2},
	"16":{"catchScale":0.7, "ringSpeed":1.6, "cycles":1},
	"17":{"catchScale":1.2, "ringSpeed":1, "cycles":1},
	"18":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"19":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	"20":{"catchScale":1, "ringSpeed":1.3, "cycles":1}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
