extends Node2D

@onready var tail = preload("res://tail.tscn")
var tails = []
var direction = Vector2.UP
var history = []    
var object_storage = []
const GRID = 32                  # cell size — was your segment_gap
var step_time = 0.6      # seconds per cell (lower = faster)
var step_accum = 0.0
var forward = true
var first_move = true
var current_tails = 0
var max_tails = 4
var pos_cell
signal update
@onready var main = get_parent().get_parent()
func _ready():
	pass
	#
	#for i in range(4):
		#add_tails()

func add_tails(pos):
	var pre_tail = tail.instantiate()
	pre_tail.position = pos
	pre_tail.z_index= -current_tails -1
	add_child(pre_tail)
	pre_tail.set_sIndex(tails.size())
	tails.append(pre_tail)
	
	object_storage.append(null)
	current_tails += 1
	update.emit()
	
	

func _process(delta):
	if Input.is_action_just_pressed("DOWN"):
		direction = Vector2.DOWN
		$ahead.rotation = PI
	if Input.is_action_just_pressed("UP"):
		direction = Vector2.UP
		$ahead.rotation = 0
	if Input.is_action_just_pressed("LEFT"):
		direction = Vector2.LEFT
		$ahead.rotation = -PI/2
	if Input.is_action_just_pressed("RIGHT"):
		direction = Vector2.RIGHT
		$ahead.rotation = PI/2
	if Input.is_action_just_pressed("MOUSE_LEFT") and inHead:
		main.focus = self
	match direction:
		Vector2.RIGHT:
			$ahead.rotation = PI/2
		Vector2.LEFT:
			$ahead.rotation = -PI/2
		Vector2.UP:
			$ahead.rotation = 0
		Vector2.DOWN:
			$ahead.rotation = PI
				
	if forward:
		step_accum += delta
		if step_accum >= step_time:
			step_accum -= step_time
			step()
	else:
		step_accum = 0

func check_position():
	if global_position/32:
		pass
		
func step():
	var tile = main.get_grid_col(global_position/32)
	
	if tile and is_instance_valid(tile) and  tile.is_in_group("direction"):
		print("here gott")
		direction = tile.get_direction();
	history.push_front(global_position)
	position += direction * GRID
	pos_cell = global_position/32
	#print(pos_cell)
	if current_tails < max_tails:
		add_tails(history[0])
	for index in tails.size():
		tails[index].global_position = history[index]


func isFull():
	for i in object_storage:
		if i==null:
			return false
	return true
	
func add_object(object):
	
	#print(object_storage)
	for i in range(object_storage.size()):
		if object_storage[i] ==null:
			object_storage[i] = object.get_type()
			tails[i].set_object(object.get_type())
			update.emit()
			return
func add_factory_object(object,i):
	if object_storage[i] ==null:
		object_storage[i] = object
		tails[i].set_object(object)		
		update.emit()

func remove_object(i):
	object_storage[i] =null
	tails[i].remove_object();
	update.emit()
	
#func _on_ahead_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	#if area.is_in_group("wall"):
		#forward = false


func _on_ahead_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	forward = true


var inHead = false
func _on_area_2d_mouse_entered() -> void:
	inHead = true
	
func _on_area_2d_mouse_exited() -> void:
	inHead = false
	
func get_grid_pos():
	return global_position/32
func get_tails():
	return tails
