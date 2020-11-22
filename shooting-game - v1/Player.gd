extends KinematicBody2D

var  movespeed = 200
var bullet_speed = 1500
var bullet = preload("res://bullet.tscn")
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * movespeed)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LM"):
		fire()

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)

func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
