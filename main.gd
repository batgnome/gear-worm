extends Node2D
var focus
var children_positions ={}
var inv_set = false
signal set_inv(focus)
signal update
@export var edge_margin := 30.0
@export var camera_speed := 500.0
@onready var placer = $placer
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

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				print("zooming")
				zoom_camera(zoom_speed)
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_camera(-zoom_speed)
var min_zoom=0.5
var max_zoom=3.0
var zoom_speed = 0.9
@onready var zoom = $Focus.zoom
func zoom_camera(amount: float):
	var new_zoom = zoom.x * amount
	new_zoom=clamp(new_zoom, min_zoom, max_zoom)
	$Focus.zoom = Vector2(new_zoom,new_zoom)		
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
