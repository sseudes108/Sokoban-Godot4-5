extends Node

const LEVELSCENE: PackedScene = preload("res://Project/Level/level.tscn")
const MAINSCENE: PackedScene = preload("res://Project/Main/Main.tscn")

var selectedLevel: String

func _ready():
	SignalManager.LevelSelected.connect(LoadLevel) 

func GetSelectedLevel() -> String:
	return selectedLevel

func LoadLevel(LevelSelected: String):
	selectedLevel = LevelSelected
	get_tree().change_scene_to_packed(LEVELSCENE)

func LoadMainScene():
	get_tree().change_scene_to_packed(MAINSCENE)
