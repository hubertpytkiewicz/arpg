extends State

var is_attacking: bool = false
var current_angle: float

func enter(msg := {}) -> void:
	print("Enter Attack")
	subject.velocity = Vector2.ZERO
	subject.idle.visible = false
	subject.walk.visible = false
	subject.attack.visible = true
	subject.weapon.visible = false

func exit() -> void:
	print("Exit attack")
	subject.weapon.visible = false

func update(_delta) -> void:
	#print(subject.anim.current_animation_position)
	if !Input.is_action_pressed("attack") and !is_attacking:
		if subject.anim.is_playing():
			subject.anim.stop()
		transitioned.emit("idle")
	if subject.anim.is_playing() and subject.anim.current_animation_position > 0.25/subject.anim.speed_scale and subject.anim.current_animation_position < 0.55/subject.anim.speed_scale:
		is_attacking = true
		subject.weapon.rotation = deg_to_rad(current_angle)
		subject.weapon.set_collision_mask_value(1, true)
		subject.weapon.visible = true
		
	if subject.anim.is_playing() and subject.anim.current_animation_position > 0.56/subject.anim.speed_scale:
		is_attacking = false
		subject.weapon.visible = false
		subject.weapon.set_collision_mask_value(1, false)
	
	
func physics_update(_delta) -> void:
	
	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
	
	var direction_available = int(round(mouse_angle/45)*45)
	match direction_available:
		-90:
			subject.anim.play("attack_up")
			current_angle = -90
		-45:
			subject.anim.play("attack_up_right")
			current_angle = -45
		0:
			subject.anim.play("attack_right")
			current_angle = 0
		45:
			subject.anim.play("attack_down_right")
			current_angle = 45
		90:
			subject.anim.play("attack_down")
			current_angle = 90
		135:
			subject.anim.play("attack_down_left")
			current_angle = 135
		180:
			subject.anim.play("attack_left")
			current_angle = -180
		-135:
			subject.anim.play("attack_up_left")
			current_angle = -135
	if subject.velocity != Vector2.ZERO and !is_attacking:
		transitioned.emit("walk")
