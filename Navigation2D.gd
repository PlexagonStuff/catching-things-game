extends Navigation2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("checkNavMesh", self, "checkNavMesh") # Replace with function body.

func checkNavMesh(positionX, positionY):
	print(get_closest_point_owner(Vector2(positionX,positionY)).get_id())
	var navID = get_closest_point_owner(Vector2(positionX,positionY)).get_id()
	if (navID == 281):
		Global.navLocation = 1
	else:
		Global.navLocation = 0
	Global.navTarget = get_closest_point(Vector2(positionX,positionY))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
