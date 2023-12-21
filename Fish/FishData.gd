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

var commonocean = [5,21,22,24,29,30,34,36,40]

var rareocean = [26,27,28,33,37,39]

var superrareocean = [23,31,25,35]

var legendaryocean = [32,38]

var caughtFish = []
var donateFish = []

var fishStats = {
	"Common": {},
	"Rare": {},
	"Super Rare": {},
	"Legendary": {},
	"Sizes": [0.6,1,1.5,2],
	"1":{"name":"Bass", "catchTime":0.5,"size":3},
	"2":{"name":"Trout", "catchTime":0.5,"size":3},
	"3":{"name":"Pike", "catchTime":0.5,"size":3},
	"4":{"name":"Walleye", "catchTime":0.5,"size":3},
	"5":{"name":"Sea Lamprey", "catchTime":0.5,"size":2},
	"6":{"name":"Bullfrog", "catchTime":0.5,"size":1},
	"7":{"name":"Slider Turtle", "catchTime":0.5,"size":1},
	"8":{"name":"Snapping Turtle", "catchTime":0.5,"size":2},
	"9":{"name":"Musk Turtle", "catchTime":0.5,"size":1},
	"10":{"name":"Mudskipper", "catchTime":0.5,"size":1},
	"11":{"name":"Giant Salamander", "catchTime":0.5,"size":3},
	"12":{"name":"Red Salamander", "catchTime":0.5,"size":2},
	"13":{"name":"Hellbender", "catchTime":0.5,"size":2},
	"14":{"name":"Tadpole", "catchTime":0.5,"size":1},
	"15":{"name":"Carp", "catchTime":0.5,"size":2},
	"16":{"name":"Goldfish", "catchTime":0.5,"size":1},
	"17":{"name":"Catfish", "catchTime":0.5,"size":3},
	"18":{"name":"Arapaima", "catchTime":0.5,"size":4},
	"19":{"name":"Piranha", "catchTime":0.5,"size":1},
	"20":{"name":"Sturgeon", "catchTime":0.5,"size":3},
	"21":{"name":"Jellyfish", "catchTime":0.5,"size":2},
	"22":{"name":"Moon Jellyfish", "catchTime":0.5,"size":1},
	"23":{"name":"One-Eyed Fish", "catchTime":0.5,"size":2},
	"24":{"name":"Blobfish", "catchTime":0.5,"size":2},
	"25":{"name":"Great Pacific Octopus", "catchTime":0.5,"size":4},
	"26":{"name":"Anglerfish", "catchTime":0.5,"size":3},
	"27":{"name":"King Crab", "catchTime":0.5,"size":3},
	"28":{"name":"Moray Eel", "catchTime":0.5,"size":3},
	"29":{"name":"Sea Bass", "catchTime":0.5,"size":3},
	"30":{"name":"Red Snapper", "catchTime":0.5,"size":3},
	"31":{"name":"Mahi-Mahi", "catchTime":0.5,"size":4},
	"32":{"name":"Leatherback", "catchTime":0.5,"size":4},
	"33":{"name":"Sea Turtle", "catchTime":0.5,"size":4},
	"34":{"name":"Pufferfish", "catchTime":0.5,"size":2},
	"35":{"name":"Manta Ray", "catchTime":0.5,"size":4},
	"36":{"name":"Stingray", "catchTime":0.5,"size":2},
	"37":{"name":"Tuna", "catchTime":0.5,"size":4},
	"38":{"name":"Goldfish?", "catchTime":0.5,"size":1},
	"39":{"name":"Sailfish", "catchTime":0.5,"size":3},
	"40":{"name":"Umbrella Octopus", "catchTime":0.5,"size":1}
	
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
