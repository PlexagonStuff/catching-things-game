extends Camera2D

var cameraState = "followPlayer"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	CameraData.connect("changeCameraState", self, "changeCameraState")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
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
