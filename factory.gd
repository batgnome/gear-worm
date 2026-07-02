extends Node2D

@export var input_type : ItemType = load("res://Gear.tres")
@export var output_type : ItemType = load("res://Wheel.tres")
var output_object = preload("res://object.tscn")

func _ready():
	$input.texture = input_type.stored_texture
	$output.texture = output_type.stored_texture
func get_type():
	return input_type
	
func process():
	var product = output_object.instantiate()
	product.init(output_type)
	get_parent().add_child(product)
	product.position = position + Vector2(-64+16,-16)

func get_grid_pos():
	return global_position/32
