extends State

func enter(msg := {}) -> void:
	print("Enter Walk")
	
	var speed = subject.base_speed
	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
	
	var direction_available = int(floor(mouse_angle/90)*90)
	match direction_available:
		-180:
			subject.anim.play("walk_up_left")
		-90:
			subject.anim.play("walk_up_right")
		0:
			subject.anim.play("walk_down_right")
		90:
			subject.anim.play("walk_down_left")

func exit() -> void:
	print("Exit walk")

func update(_delta) -> void:
	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
	
	var direction_available = int(floor(mouse_angle/90)*90)
	match direction_available:
		-180:
			subject.anim.play("walk_up_left")
		-90:
			subject.anim.play("walk_up_right")
		0:
			subject.anim.play("walk_down_right")
		90:
			subject.anim.play("walk_down_left")
	
func physics_update(_delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed = subject.base_speed
	
			
	subject.velocity = direction * speed
	subject.move_and_slide()
	if Input.is_action_pressed("attack"):
		transitioned.emit("attack")
	if subject.velocity == Vector2.ZERO:
		transitioned.emit("idle")
