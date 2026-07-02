extends Node2D
var focus
var children_positions ={}
func _ready() -> void:
	focus = $Snake
	for i in $Gameables.get_children():
		children_positions[i.get_grid_pos()] = i
	
func _process(delta: float) -> void:
	if focus:
		$Focus.position = focus.position
	if Input.is_action_just_pressed("ESCAPE"):
		focus = null

func get_grid_col(pos):
	if pos in children_positions:
		print("Gott")
		return children_positions[pos]
	return null
