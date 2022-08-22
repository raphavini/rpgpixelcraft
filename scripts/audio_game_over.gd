extends AudioStreamPlayer

var played = false
func _process(_delta) -> void:
	if Global.game_over and not played:
		play()
		played=true
		
	if not Global.game_over and played:
		played=false
