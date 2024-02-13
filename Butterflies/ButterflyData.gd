extends Node

signal despawn
signal spawn
signal leave
signal catch

enum Rarity {Common, Rare, SuperRare, Legendary}

#This is used for a unique idea for each bug, so that signals can be unique
var bugSpawnedNumber = 1

var common = [1,2,5,6,7,8,9,11,14,18,19]

var rare = [3,4,10,13,15]

var superrare = [12,17,20]

var legendary = [16]

var caughtButterflys = []
var donateButterflys = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var butterflyStats = {
	"1":{"name":"Template Butterfly", "speed":40, "acceleration":150,"price":75},
	"2":{"name":"Monarch Butterfly", "speed":40, "acceleration":150,"price":100},
	"3":{"name":"Agrias Butterfly", "speed":60, "acceleration":150,"price":150},
	"4":{"name":"Eastern Tiger Swallowtail", "speed":40, "acceleration":150,"price":150},
	"5":{"name":"Cabbage White Butterfly", "speed":40, "acceleration":150,"price":75},
	"6":{"name":"Common Blue Butterfly", "speed":40, "acceleration":150,"price":75},
	"7":{"name":"Falcate Orangetip", "speed":40, "acceleration":150,"price":100},
	"8":{"name":"Grey Hairstreak", "speed":40, "acceleration":150,"price":100},
	"9":{"name":"Common Sootywing", "speed":40, "acceleration":150,"price":100},
	"10":{"name":"Milbert's Tortoiseshell", "speed":40, "acceleration":150,"price":100},
	"11":{"name":"Common Bluebottle", "speed":40, "acceleration":150,"price":100},
	"12":{"name":"Old World Swallowtail", "speed":40, "acceleration":150,"price":200},
	"13":{"name":"Peacock Butterfly", "speed":40, "acceleration":150,"price":200},
	"14":{"name":"Rajah Brooke's Birdwing", "speed":40, "acceleration":150,"price":150},
	"15":{"name":"Great Purple Emperor", "speed":40, "acceleration":150,"price":175},
	"16":{"name":"Queen Alexandria's Birdwing", "speed":40, "acceleration":150,"price":2000},
	"17":{"name":"Chinese Peacock Butterfly", "speed":40, "acceleration":150,"price":200},
	"18":{"name":"Blue Morphos Butterfly", "speed":40, "acceleration":150,"price":100},
	"19":{"name":"Clouded Yellow Butterfly", "speed":40, "acceleration":150,"price":75},
	"20":{"name":"Great Eggfly", "speed":40, "acceleration":150,"price":175}
}
#Min scale is 0.3
var butterflyCatchData = {
	#Common
	"Common":{"catchScale":1.2, "ringSpeed":1, "cycles":3},
	
	#Rare
	"Rare":{"catchScale":1.0, "ringSpeed":1.2, "cycles":3},
	
	#Super Rare
	"SuperRare":{"catchScale":0.8, "ringSpeed":1.5, "cycles":2},
	
	#Legendary
	"Legendary":{"catchScale":0.6, "ringSpeed":2, "cycles":1},
	
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
