extends State

var is_attacking: bool = false
var current_angle: float
var weapon_hitbox: CollisionPolygon2D
@export var weapon_timer: Timer
@export var animation_player: AnimationPlayer

func enter(msg := {}) -> void:
	print("Enter Attack")
	subject.weapon.visible = false
	weapon_hitbox = subject.weapon.get_node("WeaponHitbox")
	
	subject.anim.speed_scale = subject.attack_speed
	print(subject.anim.speed_scale)
#
#	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
#	var direction_available = int(floor(mouse_angle/90)*90)
#	match direction_available:
#		-180:
#			subject.anim.play("attack_up_left")
#		-90:
#			subject.anim.play("attack_up_right")
#		0:
#			subject.anim.play("attack_down_right")
#		90:
#			subject.anim.play("attack_down_left")

func exit() -> void:
	print("Exit attack")
	subject.weapon.visible = false

	subject.anim.speed_scale = 1
	

func update(_delta) -> void:
	var mouse_angle = rad_to_deg((subject.get_global_mouse_position() - subject.position).angle())
	current_angle = deg_to_rad(int(floor(mouse_angle/15)*15))
	var direction_available = int(floor(mouse_angle/90)*90)
	match direction_available:
		-180:
			subject.anim.play("attack_up_left")
		-90:
			subject.anim.play("attack_up_right")
		0:
			subject.anim.play("attack_down_right")
		90:
			subject.anim.play("attack_down_left")
	
func physics_update(_delta) -> void:
			
	if !Input.is_action_pressed("attack"): #and subject.anim.current_animation_position < 0.3: 
		transitioned.emit("idle")
		
	if subject.anim.frame == 2:
		subject.weapon.rotation = current_angle
		subject.weapon.visible = true
		weapon_hitbox.disabled = false
		weapon_timer.start()
		

func _on_weapon_timer_timeout():
	subject.weapon.visible = false
	weapon_hitbox.disabled = true


func _on_animation_player_animation_finished(anim_name):
	transitioned.emit("idle")
