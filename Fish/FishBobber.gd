extends StaticBody2D

var fishID

var fishCatchable = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible = false
	FishData.connect("registerFish",self,"fishRegister") # Replace with function body.
	FishData.connect("onBobber",self,"fishOnBobber")
	FishData.connect("deleteBobber",self,"delete")
	
func fishRegister(id):
	fishID = id 

func delete():
	FishData.emit_signal("bobberLeft",fishID)
	queue_free()

func fishOnBobber(id):
	$Label.visible = true
	fishCatchable = true
	$TimeToCatchFishTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if Input.is_action_just_pressed("mainButton"):
		if fishCatchable == true:
			FishData.emit_signal("catch",fishID)


func _on_TimeToCatchFishTimer_timeout():
	$Label.visible = false
	fishCatchable = false
	FishData.emit_signal("bobberLeft",fishID) # Replace with function body.
