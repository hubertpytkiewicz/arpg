class_name State
extends Node

@export var subject: CharacterBody2D 

signal transitioned(target_state_name: String)

func enter(msg := {}) -> void:
	pass

func exit() -> void:
	pass

func update(_delta) -> void:
	pass 
	
func physics_update(_delta) -> void:
	pass 
