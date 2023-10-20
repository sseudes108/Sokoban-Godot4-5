extends Node

const SCOREFILE: String = "user://scores.dat"
const NOBESTSCORE: int = 10800

var bestScores: Dictionary = {}

func _ready():
	LoadScores() 

func LoadScores():
	if FileAccess.file_exists(SCOREFILE) == false:
		return
	var scoreFile = FileAccess.open(SCOREFILE, FileAccess.READ)
	bestScores = JSON.parse_string(scoreFile.get_as_text())
	print("Best Scores:", bestScores)

func SaveScores():
	var scoreFile = FileAccess.open(SCOREFILE, FileAccess.WRITE)
	scoreFile.store_string(JSON.stringify(bestScores))

func HasLevelBestScore(level: String) -> bool:
	return level in bestScores

func GetLevelBestScore(level: String) -> int:
	if HasLevelBestScore(level) == true:
		return bestScores[level]
	return NOBESTSCORE

func ScoreIsTheNewBest(level: String, moves: int) -> bool:
	if HasLevelBestScore(level) == false:
		return true
	if GetLevelBestScore(level) > moves:
		return true
	return false

func LevelCompleted(level: String, moves: int):
	if ScoreIsTheNewBest(level, moves) == true:
		bestScores[level] = moves
	SaveScores()

