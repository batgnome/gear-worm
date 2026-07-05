extends Node2D
var focus
var children_positions ={}
func _ready() -> void:
	focus = $Gameables/Snake
	for i in $Gameables.get_children():
		children_positions[i.get_grid_pos()] = i
	
func _process(_delta: float) -> void:
	if focus:
		$Focus.position = focus.position
	else:
		$Focus.position = get_global_mouse_position()
	if Input.is_action_just_pressed("ESCAPE"):
		focus = null

func get_grid_col(pos):
	if pos in children_positions:
		return children_positions[pos]
	return null
