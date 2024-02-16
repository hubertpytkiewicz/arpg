extends State

var idle_direction: Vector2
var idle_time: float

@export var subject_sprite: Sprite2D


func random_wandering() -> void:
	idle_direction = Vector2(randf_range(-0.5,0.5), randf_range(-0.5,0.5)).normalized()
	idle_time = randf_range(1,4)
	var angle = rad_to_deg(idle_direction.angle_to(Vector2.UP))
	if angle < 0:
		subject_sprite.flip_h = false
	else:
		subject_sprite.flip_h = true

func enter(msg := {}) -> void:
	random_wandering()

func exit() -> void:
	pass

func update(_delta) -> void:
	for player in get_tree().get_nodes_in_group("players"):
		if (player.position - subject.position).length() < 50:
			transitioned.emit("following")
	if idle_time > 0:
		idle_time -= _delta
		
	if idle_time <= 0:
		random_wandering()
	
func physics_update(_delta) -> void:
	subject.velocity = idle_direction * subject.idle_speed
	subject.move_and_slide()
