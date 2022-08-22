extends Label

func _process(_delta) -> void:
	text = String(Global.hp_player)
	if Global.hp_player==1:
		set("custom_colors/font_color", Color(1,0,0))
