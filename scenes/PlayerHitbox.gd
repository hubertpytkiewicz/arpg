extends Area2D

@export var healt_component: HealthComponent

func take_damage(damage: Dictionary):
	if healt_component:
		print("Hitbox")
		healt_component.take_damage(damage)
