extends Control

@onready var parent = get_parent().get_parent()
var worm
var column = preload("res://inv_panel.tscn")
var columns = []
@onready var grid = $Panel/NinePatchRect/GridContainer
func _ready():
	parent.set_inv.connect(_on_main_set_inv)
	parent.update.connect(_on_main_update)

func _set_inv(focus):
	if focus:
		worm = focus

	if worm and worm.has_method("get_tails"):
		var tails = worm.get_tails()
		grid.set_columns(tails.size())
		for i in tails:
			var grid_obj = column.instantiate()
			grid_obj.set_item(i.get_object())
			grid.add_child(grid_obj)
			columns.append(grid_obj)
func reset():
	for slot in grid.get_children():
		slot.free()

func update():
	if not worm or not worm.has_method("get_tails"):
		return
	reset()
	var tails = worm.get_tails()
	grid.set_columns(tails.size())
	for i in tails:
		var grid_obj = column.instantiate()
		grid_obj.set_item(i.get_object())
		grid.add_child(grid_obj)
	print("tails: ", tails.size(), ", \n", "grid: ",grid.get_children().size())
func _on_main_set_inv(focus):
	_set_inv(focus)


func _on_main_update():
	update()
