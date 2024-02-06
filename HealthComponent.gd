extends Node2D
class_name HealthComponent

@export var max_health: float
var current_health: float

func _ready():
	current_health = max_health
	
func take_damage(damage: Dictionary) -> void:
	var dealt_damage = damage.get("damage")
	print("dictionary get:", dealt_damage)
	
	current_health -= dealt_damage
	print("Current health: ", current_health)
	if current_health <= 0 and get_parent().is_in_group("players"):
		get_tree().quit()
	elif current_health <=0 and !get_parent().is_in_group("players"):
		print(get_parent().position)
		get_parent().queue_free()
