extends Node2D
var pos_cell
var active = false
@export var Dir = Vector2.UP
func _ready():
	pos_cell = global_position/32
	#print(pos_cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active and not $Area2D.visible:
		$Area2D.visible =true
	#else:
		#position = get_global_mouse_position()
	#if Input.is_action_just_pressed("MOUSE_LEFT"):
		#active = false
func init(item,rot,pos):
	Dir = Vector2.from_angle(deg_to_rad(rot))
	print(Dir)
	global_position = pos
	pos_cell = global_position/32
	$Sprite2D.rotation_degrees = rot
func get_direction():
	return Dir

func get_grid_pos():
	return pos_cell
