extends Node2D



export(Array, PackedScene) var enemies
export(Array, PackedScene) var power_ups


func _ready():
	Global.points = 0


func _on_enemy_spawn_timeout():
	var enemy_position = Vector2(rand_range(-150,670), rand_range(-90,390))

	var enemy_number = round(rand_range(0, enemies.size() -1))
	var enemy_instance = enemies[enemy_number].instance()
	self.add_child(enemy_instance)
	enemy_instance.position = enemy_position
	return enemy_instance


func _on_power_up_spawn_timer_timeout():
	var spawn_position = Vector2(rand_range(0, 1024), rand_range(0, 600))
	var power_up_number = round(rand_range(0, power_ups.size() -1))
	var power_up_instance = power_ups[power_up_number].instance()
	self.add_child(power_up_instance)
	power_up_instance.position = spawn_position
	return power_up_instance
