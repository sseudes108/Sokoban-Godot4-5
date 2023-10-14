extends Node2D

@onready var tileMap = $TileMap
@onready var player = $Player
@onready var camera = $Camera2D

const FLOOR_LAYER = 0
const WALL_LAYER = 1
const TARGET_LAYER = 2
const BOX_LAYER = 3

const SOURCE_ID = 0

const LAYER_KEY_FLOOR = "Floor"
const LAYER_KEY_WALLS = "Walls"
const LAYER_KEY_TARGETS = "Targets"
const LAYER_KEY_TARGET_BOXES = "TargetBoxes"
const LAYER_KEY_BOXES = "Boxes"

const LAYER_MAP = {
	LAYER_KEY_FLOOR: FLOOR_LAYER,
	LAYER_KEY_WALLS: WALL_LAYER,
	LAYER_KEY_TARGETS: TARGET_LAYER,
	LAYER_KEY_TARGET_BOXES: BOX_LAYER,
	LAYER_KEY_BOXES: BOX_LAYER
}

func _ready():
	SetUpLevel() 

func _process(delta):
	pass

func GetAtlasCordForLayerName(layerName: String) -> Vector2i:
	match layerName:
		LAYER_KEY_FLOOR:
			return Vector2i(randi_range(3,8),0)
		LAYER_KEY_WALLS:
			return Vector2i(2,0)
		LAYER_KEY_TARGETS:
			return Vector2i(9,0)
		LAYER_KEY_TARGET_BOXES:
			return Vector2i(0,0)
		LAYER_KEY_BOXES:
			return Vector2i(1,0)
	return Vector2i.ZERO

func AddTile(tileCoord: Dictionary, layerName: String):
	var layerNumber = LAYER_MAP[layerName]
	var coordVec: Vector2i = Vector2i(tileCoord.x, tileCoord.y)
	var atlasVec = GetAtlasCordForLayerName(layerName)
	
	tileMap.set_cell(layerNumber,coordVec,SOURCE_ID,atlasVec)

func AddLayerTiles(layerTiles, layerName: String):
	for tileCoord in layerTiles:
		AddTile(tileCoord.coord, layerName)

func SetUpLevel():
	tileMap.clear()
	var levelData = GameData.GetLevelData("12")
	var levelTiles = levelData.tiles
	var playerStart = levelData.player_start
	
	for layerName in LAYER_MAP.keys():
		AddLayerTiles(levelTiles[layerName], layerName)


















