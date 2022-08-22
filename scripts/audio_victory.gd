extends AudioStreamPlayer

var played = false
func _process(_delta) -> void:
	if Global.game_finished and not played:
		play()
		played=true
		
	if not Global.game_finished and played:
		played=false
