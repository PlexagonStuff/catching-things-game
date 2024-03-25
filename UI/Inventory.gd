extends Node2D
onready var inventoryIconPreload = load("res://UI/InventoryBox.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	InventoryData.connect("showInventory",self,"renderInventory")
	
func renderInventory(mode):
	for n in get_children():
		if "InventoryBox" in n.name and n.name != "InventoryBoxPlacer":
			remove_child(n)
			n.queue_free()
	for n in get_children():
		print(n.name)
	
	if mode == InventoryData.Mode.Normal:
		$OtherItems.visible = true
		$OtherItems/FishBaitCounter.text =  str(InventoryData.baitOwned)
		$OtherItems/FlowerCounter.text = str(InventoryData.flowersOwned)
	else:
		$OtherItems.visible = false
		#remove_child(n)
		#n.queue_free()
	$InventoryBoxPlacer.position = Vector2(-81,-27)
	var id = 0
	for y in range(2):
		#print(InventoryData.inventory[str(id)])
		for x in range(InventoryData.maxInventorySize/2):
			id += 1
			if InventoryData.inventory.get(str(id)) != null:
				var inventoryIcon = inventoryIconPreload.instance()
				inventoryIcon.id = id
				inventoryIcon.mode = mode
				inventoryIcon.global_position = $InventoryBoxPlacer.position
				add_child(inventoryIcon)
				$InventoryBoxPlacer.position.x += 16
		$InventoryBoxPlacer.position.x = -81
		$InventoryBoxPlacer.position.y += 16


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
