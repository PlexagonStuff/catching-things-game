extends Camera2D

var cameraState = "followPlayer"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	CameraData.connect("changeCameraState", self, "changeCameraState")
	InventoryData.connect("showInventory",self,"showInventory")
	InventoryData.connect("hideInventory",self,"hideInventory")
	InventoryData.connect("showItemShop",self,"showItemShop")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/Money.text = str(Global.money)
	if Input.is_action_just_pressed("inventory"):
		if InventoryData.shopOpen == true:
			InventoryData.shopOpen = false
			InventoryData.normalMode = true
			InventoryData.inStore = false
			$CanvasLayer/ShopInterface.visible = false
			get_tree().paused = false
		if InventoryData.normalMode == true and $CanvasLayer/AnimalPedia.visible == false:
			if InventoryData.normalInventoryOpen == false:
				InventoryData.emit_signal("showInventory",InventoryData.Mode.Normal)
				InventoryData.normalInventoryOpen = true
			else:
				InventoryData.emit_signal("hideInventory")
				InventoryData.normalInventoryOpen = false
	if Input.is_action_just_pressed("encyclopedia"):
		print(str(InventoryData.normalMode))
		print(str(InventoryData.inStore))
		
		print(str($CanvasLayer/Inventory.visible))
		
		if InventoryData.normalMode == true and InventoryData.inStore == false and $CanvasLayer/Inventory.visible == false:
			if AnimalPediaData.open == false:
				AnimalPediaData.emit_signal("showPedia",AnimalPediaData.Tab.Butterfly)
				get_tree().paused = true
				$CanvasLayer/AnimalPedia.visible = true
				AnimalPediaData.open = true
			else:
				$CanvasLayer/AnimalPedia.visible = false
				AnimalPediaData.open = false
				get_tree().paused = false
			
				
				
func showItemShop():
	InventoryData.shopOpen = true
	$CanvasLayer/ShopInterface.visible = true
	get_tree().paused = true
				
func showInventory(mode):
	$CanvasLayer/Inventory.visible = true
	get_tree().paused = true
	if mode == InventoryData.Mode.Normal:
		$CanvasLayer/DialogueBox.visible = false
	if mode == InventoryData.Mode.Release or mode == InventoryData.Mode.Sell or mode == InventoryData.Mode.Donate:
		$CanvasLayer/DialogueBox.visible = true

func hideInventory():
	$CanvasLayer/Inventory.visible = false
	get_tree().paused = false
	$CanvasLayer/DialogueBox.visible = false

func _physics_process(delta):
	
	if cameraState == "followPlayer":
		global_position = Global.playerPosition
	if cameraState == "followBobber":
		global_position = Global.bobberPosition
	elif cameraState == "zoomPlayer":
		pass
		#get_tree().paused = true
#		var tween = get_node("Tween")
#		tween.interpolate_property(self, "zoom",
#		self.zoom, self.zoom+Vector2(0.5,0.5), 2,
#		Tween.TRANS_BOUNCE, Tween.EASE_OUT)
#		tween.start()

func changeCameraState(var state):
	cameraState = state
	if cameraState == "zoomPlayer":
		global_position = Global.playerPosition
		yield(get_tree().create_timer(0.05), "timeout")
		$CanvasLayer/DialogueBox.visible = true
		get_tree().paused = true
		var tween = get_node("Tween")
		tween.interpolate_property(self, "zoom",
		self.zoom, self.zoom-Vector2(0.55,0.55), 1.25,
		Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()
		#get_tree().paused = true
		


func _on_Tween_tween_completed(object, key):
	if (key == ":zoom"):
		if (cameraState == "zoomPlayer"):
			$CanvasLayer/DialogueBox.visible = false
			cameraState = "followPlayer"
			var tween = get_node("Tween")
			tween.interpolate_property(self, "zoom",
			self.zoom, Vector2(0.9,0.9), 3,
			Tween.TRANS_EXPO, Tween.EASE_OUT)
			tween.start()
			get_tree().paused = false
			#This hideInventory is strategically placed here
			#to trigger autosaving after every catch
			#It is very tacky, but it seems to work so far?
			InventoryData.emit_signal("hideInventory")
			Dialogue.emit_signal("endDialogue")
			
