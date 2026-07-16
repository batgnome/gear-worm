extends Node2D
var focus
var children_positions ={}
var inv_set = false
signal set_inv(focus)
signal update
@export var edge_margin := 30.0
@export var camera_speed := 500.0
func _ready() -> void:
	#focus = $Gameables/Snake
	for i in $Gameables.get_children():
		children_positions[i.get_grid_pos()] = i

func add_kid(kid,pos):
	add_child(kid)
	children_positions[pos/32] = kid
	#print(children_positions)
func _process(delta: float) -> void:
	#print(get_viewport().get_canvas_transform().origin)
	if focus:
		
		$Focus.position = focus.position
		if !inv_set:
			set_inv.emit(focus)
			inv_set = true
	else:
		inv_set = false
		move_camera_at_screen_edge(delta)
	if Input.is_action_just_pressed("ESCAPE"):
		focus = null
func move_camera_at_screen_edge(delta: float):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport_rect().size
	var direction = Vector2.ZERO
	
	if mouse_pos.x <= edge_margin:
		direction.x = -1
	elif mouse_pos.x >= screen_size.x - edge_margin:
		direction.x = 1
		
	if mouse_pos.y <= edge_margin:
		direction.y = -1
	elif mouse_pos.y >= screen_size.y - edge_margin:
		direction.y = 1

	$Focus.position += direction.normalized() * camera_speed * delta
func get_grid_col(pos):
	if pos in children_positions:
		return children_positions[pos]
	return null


func _on_snake_update():
	update.emit()
