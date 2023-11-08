extends Node2D
signal addInventory

signal showInventory
signal hideInventory
signal renderInventory

enum Mode {Normal, Release, Sell, Donate}

var extraBox = false
#This is the item that is in queue, in case an item gets replaced
var quarantinedItem = {}

#This is to determine when the E key can be used to show inventory
var normalMode = true

#This is just here to distinguish an open press from a closed press
var normalInventoryOpen = false


var baitOwned = 0
var flowersOwned = 0
#This so that you cannot open the encylopedia in the store
var inStore = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inventory = {
	
}

var maxInventorySize = 22

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("addInventory",self,"addInventoryItem")
	Dialogue.connect("endDialogue",self,"endDialogue")
	pass # Replace with function body.

func _physics_process(delta):
	pass

func addInventoryItem(type, catalogID):
	var name
	if type == "Fish":
		name = FishData.fishStats[str(catalogID)]["name"]	
	else:
		name = ButterflyData.butterflyStats[str(catalogID)]["name"]
	if inventory.size() < maxInventorySize:
		extraBox = false
		inventory[str(inventory.size()+1)] = {"name":name,"type":type,"catalogID":catalogID}
		normalMode = true
	else:
		#I am sure that trying to make a nice inventory system will go great...
		extraBox = true
		quarantinedItem = {"name":name,"type":type,"catalogID":catalogID}
		normalMode = false
	
func shiftInventory(removedID):
	var inventorySize = inventory.size()
	var newInventory = {}
	for index in range(inventorySize):
		if str(index+1) != str(removedID):
			if index+1 > removedID:
				newInventory[str(index)] = inventory[str(index+1)]
			else:
				newInventory[str(index+1)] = inventory[str(index+1)]
	print(newInventory)
	inventory = newInventory
	print(inventory)
			
		
		
		
func endDialogue():
	if extraBox == true:
		emit_signal("showInventory",Mode.Release)
		Dialogue.emit_signal("sendDialogue","","Click the animal you want to replace")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
