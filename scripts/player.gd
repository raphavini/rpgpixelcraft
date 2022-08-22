extends KinematicBody2D

const PARTICLES: PackedScene = preload("res://player/run_particles.tscn")

onready var urr: AudioStreamPlayer = get_node("Urr")
onready var animation: AnimationPlayer = get_node("Animation")
onready var collision: CollisionShape2D = get_node("AttackArea/Collision")
onready var sprite: Sprite = get_node("Sprite")

var can_atack: bool = false
var can_died: bool = false
var velocity: Vector2

export(int) var spped

func _physics_process(_delta: float) -> void:
	move()
	animate()
	verify_direction()
	attack()
	finish()
	
func finish() -> void:
	if Global.game_finished:
		set_physics_process(false)
	
func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = direction_vector * spped
	velocity = move_and_slide(velocity)

func animate() -> void:
	if can_died:
		animation.play("dead")
		set_physics_process(false)
	elif can_atack:
		animation.play("attack")
		set_physics_process(false)
	elif velocity != Vector2.ZERO:
		animation.play("run")
	else:
		animation.play("idle")

func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
		collision.position = Vector2(20,8)
	elif velocity.x < 0:
		sprite.flip_h = true
		collision.position = Vector2(-20,8)

func attack() -> void:
	if Input.is_action_just_pressed("ui_select") and not can_atack:
		can_atack = true

func instance_particles() -> void:
	var particle = PARTICLES.instance()
	get_tree().root.call_deferred("add_child", particle)
	particle.global_position = global_position + Vector2(0, 16)
	particle.play_particles()

func hit() -> void:
	Global.hp_player=Global.hp_player-1
	urr.play()
	if Global.hp_player == 0:
		can_died = true
		Global.hp_player=3
	
func _on_Animation_animation_finished(anim_name):
	if anim_name == "dead":
		Global.game_over=true
	elif anim_name == "attack":
		set_physics_process(true)
		can_atack = false
