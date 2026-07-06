extends Control

@onready var parent = get_parent().get_parent()
var worm

func _process(delta: float) -> void:
	if parent.focus:
		worm = parent.focus
	if worm and worm.has_method("get_tails"):
		$GridContainer.set_columns(worm.object_storage.size())
