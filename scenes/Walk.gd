extends State

func enter(msg := {}) -> void:

	print("Enter Walk")
	subject.idle.visible = false
	subject.walk.visible = true
	subject.attack.visible = false

func exit() -> void:
	print("Exit walk")

func update(_delta) -> void:
	pass 
	
func physics_update(_delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed = subject.base_speed
	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
	
	var direction_available = int(round(mouse_angle/45)*45)
	match direction_available:
		-90:
			subject.anim.play("walk_up")
		-45:
			subject.anim.play("walk_up_right")
		0:
			subject.anim.play("walk_right")
		45:
			subject.anim.play("walk_down_right")
		90:
			subject.anim.play("walk_down")
		135:
			subject.anim.play("walk_down_left")
		180:
			subject.anim.play("walk_left")
		-135:
			subject.anim.play("walk_up_left")
	subject.velocity = direction * speed
	subject.move_and_slide()
	if subject.velocity == Vector2.ZERO:
		transitioned.emit("idle")
