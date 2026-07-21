extends Node2D


@export var item: ItemType = load("res://resources/Gear.tres")

func _ready():
	init(item)
func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	var snake = area.get_parent()
	if snake.name=="Snake":
		if !snake.isFull():
			snake.add_object(self)
			queue_free()	
			
func get_type():
	return item
func init(new_type):
	item = new_type
	$Sprite2D.texture = item.world_texture

func get_grid_pos():
	return global_position/32
