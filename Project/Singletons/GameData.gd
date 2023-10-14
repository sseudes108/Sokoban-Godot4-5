extends Node

const LEVEL_DATA_PATH: String = "res://Project/Data/LevelData.json"
const TILE_SIZE: int = 32

var leveldata: Dictionary = {}

func _ready():
	LoadLevelData()

func LoadLevelData():
	var file: = FileAccess.open(LEVEL_DATA_PATH,FileAccess.READ)
	leveldata = JSON.parse_string(file.get_as_text())
	pass

func GetLevelData(level: String) -> Dictionary:
	return leveldata[level]
