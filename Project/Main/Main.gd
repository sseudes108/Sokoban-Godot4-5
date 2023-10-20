extends CanvasLayer

@onready var gridContainer = $MarginContainer/VBoxContainer/GridContainer
var buttonScene: PackedScene = preload("res://Project/LevelButton/LevelButton.tscn")
@onready var sound = $sound

const ROWS: int = 6
const COLS: int = 5

func _ready():
	##########################################################
	SoundManager.PlaySound(sound, SoundManager.MUSIC8)
	##########################################################
	SetGrid() 

func _process(delta):
	pass

func SetGrid():
	for level in range(ROWS * COLS):
		var lvlButtonScene = buttonScene.instantiate()
		lvlButtonScene.SetLevelNumber(str(level + 1))
		gridContainer.add_child(lvlButtonScene)
