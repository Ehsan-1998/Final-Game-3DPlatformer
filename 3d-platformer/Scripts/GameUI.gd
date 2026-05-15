extends Control

# ---------- VARIABLES ---------- #

@onready var coinsLabel = $CoinsLabel
@onready var game_manager = get_tree().current_scene.get_node("GameManager")

# ---------- FUNCTIONS ---------- #

func _process(_delta):
	coinsLabel.text = "x %d" % game_manager.score
