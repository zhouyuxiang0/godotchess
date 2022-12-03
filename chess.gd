extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var text = 'che'

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite/Label.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
