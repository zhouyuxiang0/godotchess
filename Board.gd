extends Node2D
tool

export var rows = 4
export var cols = 4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gridCls = preload("res://BoardGrid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var startY = 0
	var startX = 0
	for rowIdx in rows: 
		startX = 0
		for colIdx in cols:
			var grid = gridCls.instance()
			grid.set("position", Vector2(startX,startY))
			if rowIdx == 0 and colIdx == 0:
				grid.gridType = grid.GridType.leftTop
			elif rowIdx == 0 and colIdx == cols - 1:
				grid.gridType = grid.GridType.rightTop
			elif rowIdx == rows - 1 and colIdx == 0:
				grid.gridType = grid.GridType.leftBottom
			elif rowIdx == rows - 1 and colIdx == cols - 1:
				grid.gridType = grid.GridType.rightBottom
			elif rowIdx == 0:
				grid.gridType = grid.GridType.top
			elif rowIdx == rows - 1:
				grid.gridType = grid.GridType.bottom
			elif colIdx == 0:
				grid.gridType = grid.GridType.left
			elif colIdx == cols - 1:
				grid.gridType = grid.GridType.right
			add_child(grid)
			startX += 32
		startY += 32
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
