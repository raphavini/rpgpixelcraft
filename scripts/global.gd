extends Node

var hp_player = 3
var slime_dead = 0
var game_finished = false
var game_over = false

func _process(delta) -> void:
	if slime_dead==10:
		game_finished=true
	if Input.is_key_pressed(KEY_F5):
		game_finished=false
		game_over=false
		hp_player=3
		slime_dead=0
		get_tree().reload_current_scene()
