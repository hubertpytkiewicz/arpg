extends Area2D

var enemy: PackedScene = load("res://scenes/enemy.tscn")

func spawn_enemy():
	print("enemy spawned")
	var position = Vector2(randf_range(-50,50), randf_range(-35,35))
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = position
	get_parent().add_child(enemy_instance)


func _on_timer_timeout():
	if get_tree().get_nodes_in_group("enemies").size() < 25:
		$Timer.wait_time = randf_range(0.5,1.5)
		spawn_enemy()
