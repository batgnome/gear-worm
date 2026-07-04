extends Node2D

@export var input_type : ItemType = load("res://Gear.tres")
@export var output_type : ItemType = load("res://Wheel.tres")
var output_num = 0
var output_object = preload("res://object.tscn")

func _ready():
	$input.texture = input_type.stored_texture
	$output.texture = output_type.stored_texture
func get_type():
	return input_type
	
func process():
	$grabber.play()
	output_num += 1

func get_grid_pos():
	return global_position/32


func _on_out_box_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	var tail = area.get_parent()
	if tail.is_in_group("tail") and tail.has_object():
		tail.parent.add_factory_object(output_type,tail.get_sIndex())
		$pusher.play()
		output_num -=1


func _on_pusher_animation_finished():
	$pusher.set_frame_and_progress(0,0)



func _on_grabber_animation_finished():
	$grabber.set_frame_and_progress(0,0)
