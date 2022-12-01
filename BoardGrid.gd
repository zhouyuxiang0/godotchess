extends Node2D
tool

enum GridType {cross,leftTop, rightTop, leftBottom, rightBottom, left, right, bottom, top}
export(GridType) var gridType = GridType.cross
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var resName = "Board_cross"
	match gridType:
		GridType.cross:
			resName = "Board_cross"
		GridType.leftTop:
			resName = "Board_left_top_corner"
		GridType.rightTop:
			resName = "Board_right_top_corner"
		GridType.leftBottom:
			resName = "Board_left_bottom_corner"
		GridType.rightBottom:
			resName = "Board_right_bottom_corner"
		GridType.left:
			resName = "Board_left_cross"
		GridType.right:
			resName = "Board_right_cross"
		GridType.bottom:
			resName = "Board_bottom_cross"
		GridType.top:
			resName = "Board_top_cross"
	var resPath = "res://assets/"+resName+".png"
	$Sprite.texture = load(resPath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
