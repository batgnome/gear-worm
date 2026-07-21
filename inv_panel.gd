extends Panel

@export var itemType: ItemType

var is_mouse_inside := false
@onready var parent = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()
func _ready() -> void:
	set_item(itemType)

	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta: float) -> void:
	
		
	if is_mouse_inside and material:
		var local_mouse := get_local_mouse_position()
		var normalized := local_mouse / size
		if parent.placer and Input.is_action_pressed("MOUSE_LEFT") and itemType:
			parent.placer.set_item(itemType)
			
		material.set_shader_parameter("mouse_position", normalized)

func set_item(item: ItemType) -> void:
	if item:
		$item.texture = item.stored_texture
		$item.visible = true
		itemType = item

func _on_mouse_entered() -> void:
	
	is_mouse_inside = true
	modulate = Color(1.2, 1.2, 1.2)

func _on_mouse_exited() -> void:
	is_mouse_inside = false
	modulate = Color.WHITE
