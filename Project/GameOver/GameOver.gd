extends Control

@onready var movesLabel = $"MarginContainer/NinePatchRect/MC Texts/VBoxContainer/Moves label"
@onready var recordLabel = $"MarginContainer/NinePatchRect/MC Texts/VBoxContainer/Record Label"

func _ready():
	pass

func _process(delta):
	pass

func NewGame():
	hide()
	recordLabel.hide()

func GameOver(level: String, moves: int):
	show()
	movesLabel.text = "Moves taken: " + str(moves) + "\nCurrent record: " + str(ScoreSync.GetLevelBestScore(level))
	if ScoreSync.ScoreIsTheNewBest(level, moves) == true:
		recordLabel.show()
