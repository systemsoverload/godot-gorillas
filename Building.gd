extends Area2D

onready var collision_shape = $CollisionShape2D
onready var _sprite = $Sprite

var textures = {
	red = preload("res://assets/building_red.png"),
	blue = preload("res://assets/building_blue.png"),
	gray  = preload("res://assets/building_gray.png")
}
var colors = textures.keys()

export(Vector2) var extents setget extents_set


func _ready():
	"""When creating a new building instance, randomize the height and width and 
	reshape collision objects to match"""
	self.extents = Vector2(Global.randi_range(22,38), Global.randi_range(44, 120))
	var building_color = colors[Global.randi_range(0, colors.size())]
	_sprite.texture = textures[building_color]
	_sprite.region_rect = Rect2(Vector2(4,0), extents * 2)
	_sprite.visible = true
	collision_shape.set_shape(collision_shape.shape.duplicate())


func extents_set(_extents):
	$CollisionShape2D.shape.extents = _extents
	extents = _extents
