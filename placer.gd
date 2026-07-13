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
@onready var sprite = $Sprite2D.texture

func _process(delta: float) -> void:
	position = (get_global_mouse_position() / GRID_SIZE).floor() * GRID_SIZE + Vector2.ONE * GRID_SIZE / 2
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MOUSE_RIGHT"):
		rot = (rot +90)%360
		$Sprite2D.rotation_degrees = rot
func init(item):
	$Sprite2D.texture = item.texture
	
