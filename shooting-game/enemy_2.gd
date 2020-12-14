extends KinematicBody2D

var velocity = Vector2()
var blood_particle = preload("res://blood_particle.tscn")
var points = 0
var hp = 5


func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position)/150
	look_at(Player.position)
	move_and_collide(velocity)
	if hp <= 0:
		Global.camera.screen_shake(80, 0.3)
		Global.points += 10
		var blood_instance = blood_particle.instance()
		get_tree().get_root().call_deferred("add_child",blood_instance)
		blood_instance.global_position = get_global_position()
		blood_instance.rotation_degrees = rad2deg(self.rotation)+ 180
		queue_free()



func _on_Area2D_body_entered(body):
	if "bullet" in body.name:
		hp -= 1

		body.queue_free()

