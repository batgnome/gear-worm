extends Node2D
var focus

func _ready() -> void:
	focus = $Snake
	
func _process(delta: float) -> void:
	if focus:
		$Focus.position = focus.position
	if Input.is_action_just_pressed("ESCAPE"):
		focus = null
