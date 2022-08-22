extends Label

func _process(delta) -> void:
	if Global.game_finished or Global.game_over:
		visible=true
	else:
		visible=false
