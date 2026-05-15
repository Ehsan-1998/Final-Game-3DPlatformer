extends Node

const PARTICLES_SCENE := preload("res://Scenes/Particles.tscn")
@onready var win_music: AudioStreamPlayer = $"../WinMusic"

var score := 0
var total_coins := 0

var time_left := 3.0
var timer_started := false
var game_over := false

var win_label: Label
var timer_label: Label
var action_music: AudioStreamPlayer

func _ready():
	randomize()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	await get_tree().process_frame

	action_music = get_tree().current_scene.get_node("ActionMusic")

	win_label = get_tree().current_scene.get_node("CanvasLayer/GameUI/WinLabel")
	timer_label = get_tree().current_scene.get_node("CanvasLayer/GameUI/TimerLabel")

	total_coins = get_tree().get_nodes_in_group("Coin").size()

	win_label.visible = false
	timer_label.visible = false
	timer_label.text = tr("TIME_LABEL") + ": 02:00"

func _process(delta):
	show_mouse_cursor()

	if timer_started and not game_over:
		time_left -= delta

		var minutes = int(time_left / 60)
		var seconds = int(time_left) % 60

		timer_label.text = tr("TIME_LABEL") + ": %02d:%02d" % [minutes, seconds]

		if time_left <= 0:
			lose_game()

func show_mouse_cursor():
	if Input.is_action_just_pressed("mouse_visible"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func add_score():
	if game_over:
		return

	if not timer_started:
		timer_started = true
		timer_label.visible = true
		action_music.play()

	score += 1

	if score >= total_coins:
		win_game()

func win_game():
	game_over = true
	timer_started = false

	win_label.text = tr("WIN_TEXT")
	win_label.visible = true

	action_music.stop()
	timer_label.visible = false
	win_music.play()

	spawn_fireworks()

func lose_game():
	game_over = true

	win_label.text = tr("LOSE_TEXT")
	win_label.visible = true

	timer_label.visible = false
	action_music.stop()
	await get_tree().create_timer(3.0).timeout

	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func spawn_fireworks():
	for i in range(20):
		var fireworks = PARTICLES_SCENE.instantiate()

		var random_offset = Vector3(
			randf_range(-25, 25),
			randf_range(3, 15),
			randf_range(-25, 25)
		)

		fireworks.global_position = random_offset

		get_tree().current_scene.add_child(fireworks)
