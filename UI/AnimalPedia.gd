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
	if mode == AnimalPediaData.Tab.Butterfly:
		var rarity
		$AnimalLayout/FishSize.visible = false
		$AnimalLayout/Bug.visible = true
		$AnimalLayout/Fish.visible = false
		$AnimalLayout/FishNo.visible = false
		$AnimalLayout/Bug.frame = animalID - 1
		$AnimalLayout/BugNo.frame = animalID - 1
		var rarityCounter = 0
		for rare in ButterflyData.common:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Common"
		rarityCounter = 0
		for rare in ButterflyData.rare:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Rare"
		rarityCounter = 0
		for rare in ButterflyData.superrare:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Super-Rare"
		rarityCounter = 0
		for rare in ButterflyData.legendary:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Legendary"
		var counter = 0
		for bugs in ButterflyData.caughtButterflys:
			if bugs == animalID:
				counter = counter + 1
		if counter == 0:
			$AnimalLayout/Bug.visible = false
			$AnimalLayout/BugNo.visible = true
			$AnimalLayout/Name.text = "Name: " + "???"
			$AnimalLayout/Price.text = "Price: " + "???"
			$AnimalLayout/Rarity.text = "Rarity: " + rarity
			
		else:
			$AnimalLayout/Bug.visible = true
			$AnimalLayout/BugNo.visible = false
			$AnimalLayout/Name.text = "Name: " + ButterflyData.butterflyStats[str(animalID)]["name"]
			$AnimalLayout/Price.text = "Price: " + "???"
			$AnimalLayout/Rarity.text = "Rarity: " + rarity
		
	else:
		var rarity
		$AnimalLayout/FishSize.visible = true
		$AnimalLayout/Bug.visible = false
		$AnimalLayout/BugNo.visible = false
		$AnimalLayout/Fish.visible = true
		$AnimalLayout/FishNo.visible = true
		$AnimalLayout/Fish.frame = animalID - 1
		$AnimalLayout/FishNo.frame = animalID - 1
		var sizeNumber = FishData.fishStats[str(animalID)]["size"]
		var size
		if sizeNumber == 1:
			size = "Tiny"
		if sizeNumber == 2:
			size = "Small"
		if sizeNumber == 3:
			size = "Medium"
		if sizeNumber == 4:
			size = "Large"
			
		var rarityCounter = 0
		for rare in FishData.commonfresh:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		for rare in FishData.commonocean:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Common"
		rarityCounter = 0
		for rare in FishData.rarefresh:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		for rare in FishData.rareocean:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Rare"
		rarityCounter = 0
		for rare in FishData.superrarefresh:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		for rare in FishData.superrareocean:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Super-Rare"
		rarityCounter = 0
		for rare in FishData.legendaryfresh:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		for rare in FishData.legendaryocean:
			if rare == animalID:
				rarityCounter = rarityCounter + 1
		if rarityCounter == 1:
			rarity = "Legendary"
		rarityCounter = 0
		
		var counter = 0
		for bugs in FishData.caughtFish:
			if bugs == animalID:
				counter = counter + 1
		if counter == 0:
			$AnimalLayout/FishNo.visible = true
			$AnimalLayout/Fish.visible = false
			$AnimalLayout/Name.text = "Name: " + "???"
			$AnimalLayout/Price.text = "Price: " + "???"
			$AnimalLayout/Rarity.text = "Rarity: " + rarity
			$AnimalLayout/FishSize.text = "Fish Size: " + size
			
		else:
			$AnimalLayout/FishNo.visible = false
			$AnimalLayout/Fish.visible = true
			$AnimalLayout/Name.text = "Name: " + FishData.fishStats[str(animalID)]["name"]
			$AnimalLayout/Price.text = "Price: " + "???"
			$AnimalLayout/Rarity.text = "Rarity: " + rarity
			$AnimalLayout/FishSize.text = "Fish Size: " + size

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
	if mode == AnimalPediaData.Tab.Ocean:
		id = 20
	else:
		id = 0
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


func _on_Butterflies_TextureButton_pressed():
	renderPedia(AnimalPediaData.Tab.Butterfly)

#Fresh
func _on_TextureButton_pressed():
	renderPedia(AnimalPediaData.Tab.Freshwater) # Replace with function body.


func _on_OceanFish_TextureButton_pressed():
	renderPedia(AnimalPediaData.Tab.Ocean) # Replace with function body.
