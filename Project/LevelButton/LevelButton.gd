extends NinePatchRect

const GREEN_BUTTON = preload("res://assets/green_panel.png")

@onready var levelLabel = $levelLabel
@onready var checkmark = $Checkmark

var levelNumber: String = "42"

func _ready():
	SetLevelNumber(levelNumber)
	levelLabel.text = levelNumber

func _process(delta):
	pass

func SetLevelNumber(lvNb: String):
	levelNumber = lvNb

func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("select") == true:
		texture = GREEN_BUTTON;
		print("Selected: ", levelNumber)
		SignalManager.LevelSelected.emit(levelNumber)
