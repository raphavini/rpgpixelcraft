extends KinematicBody2D

onready var audio_slime_dead: AudioStreamPlayer = get_node("AudioSlimeDead")
onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")

var can_die: bool = false
var player_ref = null
var velocity: Vector2

export(int) var speed

func _physics_process(_delta) -> void:
	move()
	animate()
	verify_direction()
	finish()
	
func finish() -> void:
	if Global.game_finished:
		set_physics_process(false)
		
func move() -> void:
	if player_ref != null:
		var distance: Vector2 = player_ref.global_position - global_position
		var direction: Vector2 = distance.normalized()
		var distance_lenght: float = distance.length()
		if distance_lenght <= 5:
			player_ref.hit()
			velocity = Vector2.ZERO
			can_die=true
		else:
			velocity = speed * direction
	else:
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity)

func animate() -> void:
	if can_die:
		audio_slime_dead.play()
		animation.play("dead")
		set_physics_process(false)
	elif velocity != Vector2.ZERO:
		animation.play("walk")
	else:
		animation.play("idle")

func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

func on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func on_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null

func on_animation_finished(anim_name):
	if anim_name == "dead":
		Global.slime_dead=Global.slime_dead+1
		queue_free()
		
func on_area_entered(area):
	if area.is_in_group("player_attack"):
		can_die = true
