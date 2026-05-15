extends Area3D

@export_category("Properties")
@export var follow_speed := 6
@export var amplitude := 0.2
@export var frequency := 4

var time_passed = 0
var is_in_range = false
var initial_position := Vector3.ZERO
var game_manager

@onready var player := get_tree().get_first_node_in_group("Player")

func _ready():
	initial_position = position
	game_manager = get_tree().current_scene.get_node("GameManager")

func _process(delta):
	coin_hover(delta)
	rotate_y(deg_to_rad(3))
	
	if is_in_range and player:
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector3.ZERO, 0.4).set_ease(Tween.EASE_IN_OUT)
		follow_player(delta)

func coin_hover(delta):
	time_passed += delta
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y

func follow_player(delta):
	position += global_position.direction_to(player.global_position) * follow_speed * delta

func _on_body_entered(body):
	if body.is_in_group("Player"):
		game_manager.add_score()
		AudioManager.coin_sfx.play()
		queue_free()

func _on_range_body_entered(body):
	if body.is_in_group("Player"):
		is_in_range = true
