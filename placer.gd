extends Node2D
#Placer object, used to place the tiles, factories, direction, etc.
#when inv item is selected, spawns placer object with item.
#placing item destroys placer
#player can rotate object ✅
#deselect by destroying itself
#places objects in a grid ✅
var rot = 0
var item : ItemType
const GRID_SIZE = 32
var temp = preload("res://direction_change.tscn")
@onready var sprite = $Sprite2D.texture

func _process(delta: float) -> void:
	position = (get_global_mouse_position() / GRID_SIZE).floor() * GRID_SIZE + Vector2.ONE * GRID_SIZE 
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MOUSE_RIGHT"):
		rot = (rot +90)%360
		$Sprite2D.rotation_degrees = rot
	if event.is_action_pressed("MOUSE_LEFT") and temp:
		var dir_tile = temp.instantiate()
		dir_tile.init(item, rot, global_position)
		get_parent().add_kid(dir_tile,global_position)
func init(item):
	$Sprite2D.texture = item.texture

func set_item(item):
	$Sprite2D.texture = item.world_texture
	temp = load(item.node_object)
