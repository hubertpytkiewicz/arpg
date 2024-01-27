extends State

@export var subject_sprite: Sprite2D

func enter(msg := {}) -> void:
	print("Enter Following")
	subject_sprite.modulate = Color(1,1,1,1)

func exit() -> void:
	print("Exit Following")

func update(_delta) -> void:
	pass
	
func physics_update(_delta) -> void:
	for player in get_tree().get_nodes_in_group("players"):
		var distance = (player.position - subject.position).length()
		if ( distance < 100 and distance > 20) :
			subject.velocity = (player.position - subject.position).normalized() * subject.idle_speed*3
			subject.move_and_slide()
		elif distance <= 20:
			transitioned.emit("attack")
		else:
			transitioned.emit("idle")
	
