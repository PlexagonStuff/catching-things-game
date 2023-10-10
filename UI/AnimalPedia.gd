extends Node2D
onready var pediaBoxPreload = load("res://UI/AnimalPediaBox.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	AnimalPediaData.connect("showPedia",self,"renderPedia")
	AnimalPediaData.connect("showAnimalLayout",self,"showAnimalLayout")


func showAnimalLayout(mode,animalID):
	#Wipe the slate clean of all icons
	for n in get_children():
		if "AnimalPedia" in n.name and n.name != "AnimalPediaBoxPlacer":
			remove_child(n)
			n.queue_free()
	#Show the layout and then change some labels (TODO)
	$AnimalLayout.visible = true

func renderPedia(mode):
	$AnimalLayout.visible = false
	for n in get_children():
		if "AnimalPedia" in n.name and n.name != "AnimalPediaBoxPlacer":
			remove_child(n)
			n.queue_free()
	for n in get_children():
		print(n.name)
		#remove_child(n)
		#n.queue_free()
	$AnimalPediaBoxPlacer.position = Vector2(-70,-19)
	var id = 0
	for y in range(2):
		#Each subset has 20 animals each, so this can just be simplified to 10
		for x in range(10):
			id += 1
			var inventoryIcon = pediaBoxPreload.instance()
			inventoryIcon.id = id
			inventoryIcon.mode = mode
			inventoryIcon.global_position = $AnimalPediaBoxPlacer.position
			add_child(inventoryIcon)
			$AnimalPediaBoxPlacer.position.x += 16
		$AnimalPediaBoxPlacer.position.x = -70
		$AnimalPediaBoxPlacer.position.y += 32
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
