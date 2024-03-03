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
	"1":{"name":"Bass", "catchTime":0.5,"size":3,"price":100},
	"2":{"name":"Trout", "catchTime":0.5,"size":3,"price":100},
	"3":{"name":"Pike", "catchTime":0.5,"size":3,"price":100},
	"4":{"name":"Walleye", "catchTime":0.5,"size":3,"price":100},
	"5":{"name":"Sea Lamprey", "catchTime":0.5,"size":2,"price":75},
	"6":{"name":"Bullfrog", "catchTime":0.5,"size":1,"price":75},
	"7":{"name":"Slider Turtle", "catchTime":0.5,"size":1,"price":125},
	"8":{"name":"Snapping Turtle", "catchTime":0.5,"size":2,"price":225},
	"9":{"name":"Musk Turtle", "catchTime":0.5,"size":1,"price":125},
	"10":{"name":"Mudskipper", "catchTime":0.5,"size":1,"price":75},
	"11":{"name":"Giant Salamander", "catchTime":0.5,"size":3,"price":1000},
	"12":{"name":"Red Salamander", "catchTime":0.5,"size":2,"price":100},
	"13":{"name":"Hellbender", "catchTime":0.5,"size":2,"price":125},
	"14":{"name":"Tadpole", "catchTime":0.5,"size":1,"price":75},
	"15":{"name":"Carp", "catchTime":0.5,"size":2,"price":100},
	"16":{"name":"Goldfish", "catchTime":0.5,"size":1,"price":75},
	"17":{"name":"Catfish", "catchTime":0.5,"size":3,"price":225},
	"18":{"name":"Arapaima", "catchTime":0.5,"size":4,"price":1200},
	"19":{"name":"Piranha", "catchTime":0.5,"size":1,"price":125},
	"20":{"name":"Sturgeon", "catchTime":0.5,"size":3,"price":200},
	"21":{"name":"Jellyfish", "catchTime":0.5,"size":2,"price":75},
	"22":{"name":"Moon Jellyfish", "catchTime":0.5,"size":1,"price":75},
	"23":{"name":"One-Eyed Fish", "catchTime":0.5,"size":2,"price":500},
	"24":{"name":"Blobfish", "catchTime":0.5,"size":2,"price":125},
	"25":{"name":"Great Pacific Octopus", "catchTime":0.5,"size":4,"price":300},
	"26":{"name":"Anglerfish", "catchTime":0.5,"size":3,"price":125},
	"27":{"name":"King Crab", "catchTime":0.5,"size":3,"price":200},
	"28":{"name":"Moray Eel", "catchTime":0.5,"size":3,"price":100},
	"29":{"name":"Sea Bass", "catchTime":0.5,"size":3,"price":100},
	"30":{"name":"Red Snapper", "catchTime":0.5,"size":3,"price":100},
	"31":{"name":"Mahi-Mahi", "catchTime":0.5,"size":4,"price":200},
	"32":{"name":"Leatherback", "catchTime":0.5,"size":4,"price":1000},
	"33":{"name":"Sea Turtle", "catchTime":0.5,"size":4,"price":200},
	"34":{"name":"Pufferfish", "catchTime":0.5,"size":2,"price":125},
	"35":{"name":"Manta Ray", "catchTime":0.5,"size":4,"price":175},
	"36":{"name":"Stingray", "catchTime":0.5,"size":2,"price":150},
	"37":{"name":"Tuna", "catchTime":0.5,"size":4,"price":125},
	"38":{"name":"Goldfish?", "catchTime":0.5,"size":1,"price":10000},
	"39":{"name":"Sailfish", "catchTime":0.5,"size":3,"price":125},
	"40":{"name":"Umbrella Octopus", "catchTime":0.5,"size":1,"price":100}
	
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
