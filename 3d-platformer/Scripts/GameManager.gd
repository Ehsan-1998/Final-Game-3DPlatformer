extends Node

var score := 0
var total_coins := 0

var time_left := 20.0
var timer_started := false
var game_over := false

var win_label: Label
var timer_label: Label
var action_music: AudioStreamPlayer

func _ready():
	await get_tree().process_frame
	action_music = get_tree().current_scene.get_node("ActionMusic")
	
	win_label = get_tree().current_scene.get_node("CanvasLayer/GameUI/WinLabel")
	timer_label = get_tree().current_scene.get_node("CanvasLayer/GameUI/TimerLabel")
	
	total_coins = get_tree().get_nodes_in_group("Coin").size()
	
	
	win_label.visible = false
	timer_label.visible = false
	timer_label.text = "Time: 20"

func _process(delta):
	show_mouse_cursor()
	
	if timer_started and not game_over:
		time_left -= delta
		timer_label.text = "Time: " + str(int(time_left))
		
		if time_left <= 0:
			lose_game()

func show_mouse_cursor():
	if Input.is_action_just_pressed("mouse_visible"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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
	win_label.text = "You are fast! You won!"
	win_label.visible = true
	action_music.stop()
	timer_label.visible = false
	

func lose_game():
	game_over = true
	win_label.text = "Time is over! You lost coins!"
	win_label.visible = true
	timer_label.visible = false
	action_music.stop()
