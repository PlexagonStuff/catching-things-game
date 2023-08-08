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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if InventoryData.normalMode == true:
			if InventoryData.normalInventoryOpen == false:
				InventoryData.emit_signal("showInventory",InventoryData.Mode.Normal)
				InventoryData.normalInventoryOpen = true
			else:
				InventoryData.emit_signal("hideInventory")
				InventoryData.normalInventoryOpen = false
				
func showInventory(mode):
	$CanvasLayer/Inventory.visible = true
	get_tree().paused = true

func hideInventory():
	$CanvasLayer/Inventory.visible = false
	get_tree().paused = false

func _physics_process(delta):
	
	if cameraState == "followPlayer":
		global_position = Global.playerPosition
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
			self.zoom, Vector2(1.25,1.25), 3,
			Tween.TRANS_EXPO, Tween.EASE_OUT)
			tween.start()
			get_tree().paused = false
			#This hideInventory is strategically placed here
			#to trigger autosaving after every catch
			#It is very tacky, but it seems to work so far?
			InventoryData.emit_signal("hideInventory")
			Dialogue.emit_signal("endDialogue")
			
