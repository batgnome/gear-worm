extends Panel
var itemType : ItemType

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_item(item):
	if item:
		$item.texture = item.stored_texture
		$item.visible = true
		itemType = item
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
