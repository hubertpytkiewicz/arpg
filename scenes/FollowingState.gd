extends State

func enter(msg := {}) -> void:
	#print("Enter Idle")
	subject.velocity = Vector2.ZERO
	subject.idle.visible = true
	subject.walk.visible = false
	subject.attack.visible = false

func exit() -> void:
	print("Exit Idle")

func update(_delta) -> void:
	if Input.is_action_pressed("attack"):
		transitioned.emit("attack")
	
func physics_update(_delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed = subject.base_speed
	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
	
	var direction_available = int(round(mouse_angle/45)*45)
	match direction_available:
		-90:
			subject.anim.play("idle_up")
		-45:
			subject.anim.play("idle_up_right")
		0:
			subject.anim.play("idle_right")
		45:
			subject.anim.play("idle_down_right")
		90:
			subject.anim.play("idle_down")
		135:
			subject.anim.play("idle_down_left")
		180:
			subject.anim.play("idle_left")
		-135:
			subject.anim.play("idle_up_left")
	subject.velocity = direction * speed
	subject.move_and_slide()
	if subject.velocity != Vector2.ZERO:
		transitioned.emit("walk")
