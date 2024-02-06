extends Area2D

var enemy: PackedScene = load("res://scenes/enemy.tscn")
@onready var spawner_area: CollisionShape2D = $SpawnerArea

func spawn_enemy():
	print("enemy spawned")
	var size_x = spawner_area.shape.size[0]
	var size_y = spawner_area.shape.size[1]
	var enemy_position = Vector2(randf_range(-size_x/2,size_x/2), randf_range(-size_y/2,size_y/2))
	print(position)
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = position + enemy_position
	get_parent().add_child(enemy_instance)


func _on_timer_timeout():
	if get_tree().get_nodes_in_group("enemies").size() < 3:
		$Timer.wait_time = randf_range(0.5,1.5)
		spawn_enemy()
