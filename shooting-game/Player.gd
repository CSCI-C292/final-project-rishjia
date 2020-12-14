extends KinematicBody2D

var  movespeed = 200

var reload_speed = 0.1
var default_speed = reload_speed 
var power_up_reset = []

var bullet = preload("res://bullet.tscn")
var can_shoot = true
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

	
	if Input.is_action_pressed("LM") and can_shoot:
		fire()
#		Global.instance_node(bullet, global_positon , Global.node_creation_parent)
		$Reload_attack.start()
		can_shoot = false

func fire():
	fire_helper(bullet)

func fire_helper(bullet):
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	#bullet_instance.rotation_degrees = rotation_degrees
	#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)
	
func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
	if "enemy_2" in body.name:
		kill()


func _on_Timer_timeout():
	can_shoot = true
	$Reload_attack.wait_time = reload_speed


func _on_power_up_cool_down_timeout():
	if power_up_reset.find("power_up") != null:
		reload_speed = default_speed
		power_up_reset.erase("power_up")
