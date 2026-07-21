extends Node2D

@export var input_type : ItemType = load("res://resources/Gear.tres")
@export var output_type : ItemType = load("res://resources/Arrow.tres")
#@export var output_type : ItemType = load("res://resources/Wheel.tres")

var output_num = 0
var output_object = preload("res://object.tscn")
var Dir : Vector2
var pos_cell : Vector2
func _ready():
	$input.texture = input_type.stored_texture
	$output.texture = output_type.stored_texture
#dir_tile.init(item, rot, global_position)
func init(item,rot,pos):
	print(rot)
	Dir = Vector2.from_angle(deg_to_rad(rot-90))
	#print(Dir)
	global_position = pos
	pos_cell = global_position/32
	rotation_degrees = rot
func get_type():
	return input_type
	
func process():
	$grabber.play()
	output_num += 1

func get_grid_pos():
	return global_position/32


func _on_out_box_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	var tail = area.get_parent()
	if tail.is_in_group("tail") and tail.has_object() and output_num >0:
		tail.parent.add_factory_object(output_type,tail.get_sIndex())
		output_num -= 1
		$pusher.play()
		


func _on_pusher_animation_finished():
	$pusher.set_frame_and_progress(0,0)
	



func _on_grabber_animation_finished():
	$grabber.set_frame_and_progress(0,0)
