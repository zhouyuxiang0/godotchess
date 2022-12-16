extends Node2D
tool

export var rows = 4
export var cols = 4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gridCls = preload("res://BoardGrid.tscn")
var chessCls = preload("res://chess.tscn")
var chessPosition = {Vector2(0,0): 'che', Vector2(1,0): 'ma', Vector2(2,0): 'xiang', Vector2(3,0): 'shi', Vector2(4,0): 'jiang',Vector2(5,0): 'shi',Vector2(6,0): 'xiang',Vector2(7,0): 'ma', Vector2(8,0): 'che',\
Vector2(1,2): 'pao',Vector2(7,2): 'pao',Vector2(0,3): 'zu', Vector2(2,3): 'zu',Vector2(4,3):'zu',Vector2(6,3):'zu',Vector2(8,3):'zu',\
Vector2(0,9): 'ju', Vector2(1,9): 'm', Vector2(2,9): 'x', Vector2(3,9): 's', Vector2(4,9): 'shuai',Vector2(5,9): 's',Vector2(6,9): 'x',Vector2(7,9): 'm', Vector2(8,9): 'ju',\
Vector2(1,7): 'p',Vector2(7,7): 'p',Vector2(0,6): 'bing', Vector2(2,6): 'bing',Vector2(4,6):'bing',Vector2(6,6):'bing',Vector2(8,6):'bing'}
var targetChessName = ''
var globalPostion = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var startY = 0
	var startX = 0
	var x = 0
	var y = 0
	for rowIdx in rows: 
		startX = 0
		x = 0
		for colIdx in cols:
			var grid = gridCls.instance()
			if (y == 0 or (y == 2 and (x == 1 or x == 7)) or (y == 3 and x % 2 == 0)) or \
			(y == 9 or (y == 7 and (x == 1 or x == 7)) or (y == 6 and x%2==0)):
				var text = chessPosition[Vector2(x,y)]
				if text:
					var chess = chessCls.instance()
					chess.set("position", Vector2(startX, startY))
					globalPostion.append(Vector2(startX, startY))
					chess.text = text
					chess.name = 'chess-' + str(rowIdx) + '-' + str(colIdx)
					if (y > 4):
						chess.add_to_group('red')
					else:
						chess.add_to_group('black')
					chess.connect("clickChess", self, 'onChessClick')
					add_child(chess)
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
			grid.name = 'grid-' + str(rowIdx) + '-' + str(colIdx)
			grid.connect("onGridClick", self, 'onGridClick')
			add_child(grid)
			startX += 32
			x += 1
		startY += 32
		y += 1
			
func onChessClick(chessName: String):
	targetChessName = chessName
	print(targetChessName)
func onGridClick(gridName: String):
	if not targetChessName:
		return
	var gridLoc = gridName.lstrip('grid-').split('-', false)
	var gridVec = Vector2(int(gridLoc[1]), int(gridLoc[0]))
	move(targetChessName, gridVec)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func move(chessName: String,targetVec: Vector2):
	var node = get_node(chessName)
	var chessVec = node.get('position')
	targetVec = targetVec * 32
	if node.text == 'che' or node.text == 'c':
		if not chessVec.x == targetVec.x and not chessVec.y == targetVec.y:
			return
	elif node.text == 'ma' or node.text == 'm':
		# x +- 2 y +- 1   y +- 2 x +- 1
		var v = chessVec - targetVec
		var vec = v.abs()
		if vec.x == 0 or vec.y == 0:
			return
		if (not vec.x / vec.y == 2) and (not vec.x / vec.y == 0.5):
			return
		if vec.x / vec.y == 0.5:
			# 纵向 32 64 左上 -32 64 右上   32 -64 左下 -32 -64 右下
			if v.y < 0:
				# 方向 下
				if globalPostion.has(Vector2(chessVec.x, chessVec.y + 32)):
					return
			else:
				# 上
				if globalPostion.has(Vector2(chessVec.x, chessVec.y - 32)):
					return
		else:
			# 横向 左下 64 -32 左上 64 32  右上 -64 32 右下 -64 -32
			if v.x < 0:
				# 方向 右
				if globalPostion.has(Vector2(chessVec.x + 32, chessVec.y)):
					return
			else:
				if globalPostion.has(Vector2(chessVec.x - 32, chessVec.y)):
					return
	elif node.text == 'xiang' or node.text == 'x':
		
		pass
	node.set('position', targetVec)
