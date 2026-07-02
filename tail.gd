extends Node2D


var item : ItemType = null
var unload = true
var unload_sprite = preload("res://assets/unlocked_unload.png")
var unload_sprite_locked = preload("res://assets/locked_unload.png")
@onready var index
@onready var parent = get_parent()

func set_sIndex(i):
	index = i
func get_sIndex():
	return index
func set_sprite(sprite):
	$Object_storage.texture = sprite
	
func set_object(new_item):
	$Object_storage.visible = true
	item=new_item
	set_sprite(item.stored_texture)
	
func get_object():
	return item

func remove_object():
	if item!= null:
		item=null
		$Object_storage.visible = false
		parent.remove_object(get_sIndex())
		

func unloadable():
	return unload

func _on_unload_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		unload = !unload
		if unload:
			$unload.texture = unload_sprite_locked
		else:
			$unload.texture = unload_sprite

func request_item(item):
	if unload and (item == get_object()):
		return true
	return false


func _on_area_2d_2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("depot") and unload:
		var factory = area.get_parent()
		if request_item(factory.get_type()):
			remove_object();
			factory.process();
			
func get_grid_pos():
	return global_position/32
