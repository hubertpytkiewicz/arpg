extends CharacterBody2D

var idle
var walk
var attack
var weapon
var anim

#var down_left = Vector2(-1,1).normalized()
#var up_left = Vector2(-1,-1).normalized()
#var down_right = Vector2(1,1).normalized()
#var up_right = Vector2(1,-1).normalized()
#
#var right = Vector2(1,0).normalized()
#var down = Vector2(0,1).normalized()
#var up = Vector2(0,-1).normalized()
#var left = Vector2(-1,0).normalized()
@export var base_speed = 80 
@export var attack_speed = 1


func _ready():
	weapon = get_node("Weapon")
	anim = get_node("PlayerSprite")
#
#func _process(_delta):
#	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
#	var speed: int = 100
#	velocity = direction * speed
#	move_and_slide()

