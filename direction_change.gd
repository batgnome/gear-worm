extends Node2D

var pos_cell =[]

var Dir = Vector2.UP
func _ready():
	pos_cell[0] = position.x/32
	pos_cell[1] = position.y/32
	print(pos_cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_direction():
	return Dir
