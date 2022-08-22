extends AudioStreamPlayer

func _process(_delta) -> void:
	if Global.game_finished or Global.game_over:
		stop()
	
func on_ready():
	play()

func on_finished():
	play()
