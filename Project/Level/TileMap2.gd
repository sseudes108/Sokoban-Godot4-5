extends TileMap

@onready var backgroundTileMap = $"."

func _ready():
	SetBackground()

func SetBackground():
	var tileRectangle = backgroundTileMap.get_used_rect()
	
	var tileRecStartX = tileRectangle.position.x * GameData.TILE_SIZE
	var tileRecEndX = tileRectangle.size.x * GameData.TILE_SIZE + tileRecStartX
	
	var tileRecStartY = tileRectangle.position.y * GameData.TILE_SIZE
	var tileRecEndY = tileRectangle.size.y * GameData.TILE_SIZE + tileRecStartY
	
	for x in range(int(tileRecStartX), int(tileRecEndX), GameData.TILE_SIZE):
		for y in range(int(tileRecStartY), int(tileRecEndY), GameData.TILE_SIZE):
			var cell_x = int(x / GameData.TILE_SIZE)
			var cell_y = int(y / GameData.TILE_SIZE)
			#Background Layer (Floor)
			backgroundTileMap.set_cell(0, Vector2i(cell_x, cell_y), 2, Vector2i(randi_range(0,12),0))
			#Background Layer (Props)
			backgroundTileMap.set_cell(1, Vector2i(cell_x, cell_y), 1, Vector2i(randi_range(0,17),0))
