extends Node2D

@onready var sound = $Sound

@onready var tileMap = $TileMap
@onready var player = $Finn
@onready var camera = $Camera2D

@onready var customTargets = $CustomTargets
var targetTile: PackedScene = preload("res://Project/Target/Target.tscn")
var targets

@onready var hud = $CanvasLayer/HUD
@onready var gameOverUi = $CanvasLayer/GameOverUI

const FLOOR_LAYER = 0
const WALL_LAYER = 1
const TARGET_LAYER = 2
const BOX_LAYER = 3

###########
const BACKGROUND_LAYER = 5
const PROPS_LAYER = 6
###########

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
	LAYER_KEY_BOXES: BOX_LAYER,
}

var isMoving: bool = false
var movesMade: int = 0

var selectedLevel: int = 11

func _ready():
	##########################################################
	var musicToPlay = SoundManager.SOUNDS.keys().pick_random()
	SoundManager.PlaySound(sound, musicToPlay)
	##########################################################
	SetUpLevel()

func _process(delta):
	
	if Input.is_action_just_pressed("quit"):
		GameManager.LoadMainScene()
	
	hud.SetMovesMade(movesMade)
	
	if isMoving == true:
		return
	
	var direction = Vector2i.ZERO
	
	if Input.is_action_just_pressed("right"):
		player.flip_h = false
		direction = Vector2i.RIGHT
	if Input.is_action_just_pressed("left"):
		player.flip_h = true
		direction = Vector2i.LEFT
	if Input.is_action_just_pressed("up"):
		direction = Vector2i.UP
	if Input.is_action_just_pressed("down"):
		direction = Vector2i.DOWN
	
	if Input.is_action_just_pressed("reload"):
		#gameOverUi.hide()
		#hud.show()
		##Remove Custom Tiles before setup the lvl again
		for ct in customTargets.get_children():
			ct.queue_free()
			
		SetUpLevel()
	
	if direction != Vector2i.ZERO:
		MovePlayer(direction)

############
#Game Logic#
############

func GetPlayerCurrentTile() -> Vector2i:
	var playerOffset = player.global_position - tileMap.global_position
	return Vector2i(playerOffset / GameData.TILE_SIZE)

## Check cell the player is trying to move to
####################################################
#Custom target replacer
func SetCustomTargets():
	targets = tileMap.get_used_cells(TARGET_LAYER)
	
	##spritsheet edited. No need to clear the layer
	#tileMap.clear_layer(TARGET_LAYER)
	
	for i in targets:
		var target = targetTile.instantiate()
		customTargets.add_child(target)
		target.position = Vector2(i.x * GameData.TILE_SIZE,i.y * GameData.TILE_SIZE)
####################################################

func CheckGameState():
	for i in tileMap.get_used_cells(TARGET_LAYER):
		if cellIsBox(i) == false:
			return
			
	hud.hide()
	gameOverUi.GameOver(GameManager.GetSelectedLevel(),movesMade)
	ScoreSync.LevelCompleted(GameManager.GetSelectedLevel(),movesMade)

func MoveBox(boxTile: Vector2i, direction: Vector2i):
	var dest = boxTile + direction
	
	tileMap.erase_cell(BOX_LAYER, boxTile)
	
	if dest in tileMap.get_used_cells(TARGET_LAYER):
		tileMap.set_cell(BOX_LAYER,dest,SOURCE_ID,
		GetAtlasCordForLayerName(LAYER_KEY_TARGET_BOXES))
		#############################
		#HideCustomTargets(dest)
		#############################
	else:
		tileMap.set_cell(BOX_LAYER,dest,SOURCE_ID, 
		GetAtlasCordForLayerName(LAYER_KEY_BOXES))

func cellIsWall(cell: Vector2i) -> bool:
	return cell in tileMap.get_used_cells(WALL_LAYER)

func cellIsBox(cell: Vector2i) -> bool:
	return cell in tileMap.get_used_cells(BOX_LAYER)

func cellIsEmpty(cell: Vector2i) -> bool:
	return cellIsWall(cell) == false and cellIsBox(cell) == false

func BoxCanMove(boxTile: Vector2i, direction: Vector2i) -> bool:
	var newBoxTile = boxTile + direction
	return cellIsEmpty(newBoxTile)

func MovePlayer(direction: Vector2i):
	isMoving = true
	
	var playerTile = GetPlayerCurrentTile()
	var newPlayerTile = playerTile + direction
	var canMove = true
	var boxSeen = false
	
	if cellIsWall(newPlayerTile):
		canMove = false
	if cellIsBox(newPlayerTile):
		boxSeen = true
		canMove = BoxCanMove(newPlayerTile, direction)
	
	if canMove:
		movesMade +=1
		
		hud.SetMovesMade(movesMade)
		
		if boxSeen:
			MoveBox(newPlayerTile,direction)
		
		SetPlayerOnTile(newPlayerTile);
		CheckGameState()
	isMoving = false

#######################################
# TileMap, camera and player placement #
####################################### 
func SetPlayerOnTile(tileCoord: Vector2i):
	var newPos: Vector2 = Vector2(
		tileCoord.x * GameData.TILE_SIZE,
		tileCoord.y * GameData.TILE_SIZE,
	) + tileMap.global_position
	player.global_position = newPos

func GetAtlasCordForLayerName(layerName: String) -> Vector2i:
	match layerName:
		LAYER_KEY_FLOOR:
			return Vector2i(randi_range(7,11),0)
		LAYER_KEY_WALLS:
			return Vector2i(randi_range(4,6),0)
		LAYER_KEY_TARGETS:
			return Vector2i(12,0)
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

	var lvlNum = GameManager.GetSelectedLevel()
	var levelData = GameData.GetLevelData(lvlNum)
	
	var levelTiles = levelData.tiles
	var playerStart = levelData.player_start
	
	movesMade = 0
	#hud.show()
	
	for layerName in LAYER_MAP.keys():
		AddLayerTiles(levelTiles[layerName], layerName)
	
	SetPlayerOnTile(Vector2i(playerStart.x,playerStart.y))
	#############################
	SetCustomTargets()
	#############################
	MoveCamera()
	hud.NewGame(lvlNum)
	gameOverUi.NewGame()

func MoveCamera():
	#Used tile rectangle
	var tileRectangle = tileMap.get_used_rect()

	var tileRecStartX = tileRectangle.position.x * GameData.TILE_SIZE
	var tileRecEndX = tileRectangle.size.x * GameData.TILE_SIZE + tileRecStartX
	
	var tileRecStartY = tileRectangle.position.y * GameData.TILE_SIZE
	var tileRecEndY = tileRectangle.size.y * GameData.TILE_SIZE + tileRecStartY
	
	var midX = tileRecStartX + (tileRecEndX - tileRecStartX) / 2
	var midY = tileRecStartY + (tileRecEndY - tileRecStartY) / 2
	
	camera.position = Vector2(midX, midY)




