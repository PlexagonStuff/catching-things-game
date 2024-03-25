extends AudioStreamPlayer2D
export var audioType : String
var rng = RandomNumberGenerator.new()
var beachAudio = "res://Sounds/beach.mp3"
var ambientAudio = ["res://Sounds/ambient1.mp3","res://Sounds/ambient2.mp3","res://Sounds/ambient3.mp3"]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	if audioType.to_lower() == "ambient":
		stream = load(ambientAudio[rng.randi_range(0,2)])
	else:
		stream = load(beachAudio)
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Settings.sound == true:
		volume_db = -10
		
	else:
		volume_db = -80
