extends CanvasLayer

@onready var gridContainer = $MarginContainer/VBoxContainer/GridContainer
var buttonScene: PackedScene = preload("res://Project/LevelButton/LevelButton.tscn")

const ROWS: int = 6
const COLS: int = 5

func _ready():
	SetGrid() 

func _process(delta):
	pass

func SetGrid():
	for level in range(ROWS * COLS):
		var lvlButtonScene = buttonScene.instantiate()
		lvlButtonScene.SetLevelNumber(str(level + 1))
		gridContainer.add_child(lvlButtonScene)
