extends State

@export var subject_sprite: Sprite2D

func enter(msg := {}) -> void:
	print("Enter Enemy Attack")

func exit() -> void:
	print("Exit Enemy Attack")

func update(_delta) -> void:
	pass
	
func physics_update(_delta) -> void:
	for player in get_tree().get_nodes_in_group("players"):
		var distance = (player.global_position - subject.global_position).length()
		print("Distance ", distance)
		if distance < 20 and subject.is_attack_ready:
			subject.is_attack_ready = false
			subject.get_node("AttackTimer").start()
			var damage = {"damage": subject.base_damage}
			player.get_node("Hitbox").take_damage(damage)
			subject_sprite.modulate = Color(10,1,1,1)
		else:
			transitioned.emit("following")
