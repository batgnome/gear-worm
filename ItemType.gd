# item_type.gd
extends Resource
class_name ItemType

@export var id: String = "gear"
@export var stored_texture: Texture2D   = load("res://assets/gear_1_stored.png")# how it looks on the tail
@export var world_texture: Texture2D    = load("res://assets/gear_1_stored.png")# how it looks as a pickup
