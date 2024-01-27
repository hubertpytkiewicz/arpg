extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}
var subject = get_parent()

func _ready():
	await get_parent().ready
	get_parent().move_and_slide()
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
	
func on_child_transitioned(target_state_name: String):

	var new_state = states.get(target_state_name)
	if new_state != null:
		current_state.exit()
		new_state.enter()
		current_state = new_state
