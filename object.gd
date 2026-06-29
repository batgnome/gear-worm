extends Node2D


@export var item: ItemType = load("res://Gear.tres")

func _ready():
	init(item)
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
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

