extends Control

#level
@onready var levelLabel = $"MarginContainer/Labels HBoxContainer/level VBoxContainer/Label"
@onready var levelNumberLabel = $"MarginContainer/Labels HBoxContainer/level VBoxContainer/Label2"

#Moves
@onready var movesLabel = $"MarginContainer/Labels HBoxContainer/Moves VBoxContainer2/Label"
@onready var movesNumberLabel = $"MarginContainer/Labels HBoxContainer/Moves VBoxContainer2/Label2"

#Best
@onready var bestLabel = $"MarginContainer/Labels HBoxContainer/Best VBoxContainer3/Label"
@onready var bestNumberLabel = $"MarginContainer/Labels HBoxContainer/Best VBoxContainer3/Label2"

var best: int = 0
var moves: int = 0

func _ready():
	pass

func _process(delta):
	pass

func SetLevelNumber(levelNumber: String):
	levelNumberLabel.text = levelNumber

func SetMovesMade(moves: int):
	movesNumberLabel.text = str(moves)

func SetBest(best: int):
	bestNumberLabel.text = str(best)
