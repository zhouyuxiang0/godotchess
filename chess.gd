extends Node2D
tool

signal clickChess(chessName)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var text = 'che'
enum ChessType {che,ma,xiang,shi,jiang,pao,bing}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite/Label.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click'):
		if not get_tree().is_input_handled():
			emit_signal("clickChess", self.name)
			get_tree().set_input_as_handled()
	elif event is InputEventScreenTouch:
		if not get_tree().is_input_handled():
			emit_signal("clickChess", self.name)
			get_tree().set_input_as_handled()
