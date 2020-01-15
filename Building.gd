extends Area2D

onready var collision_shape = $CollisionShape2D
onready var gray_building = $GrayBuildingSprite
onready var red_building = $RedBuildingSprite
onready var blue_building = $BlueBuildingSprite

export(bool) var is_building = true
export(Vector2) var extents setget extents_set


func _ready():
	"""When creating a new building instance, randomize the height and width and 
	reshape collision objects to match"""
	# FIXME - there is some kind of bug with dynamic building width + the layout
	# code in World.gd::generate_buildings, hardcoded to 40 for now
	self.extents = Vector2(34, randi_range(44, 140))
	collision_shape.set_shape(collision_shape.shape.duplicate())
	
	var sprites = [gray_building, red_building, blue_building]	
	var sprite = sprites[Global.randi_range(0, sprites.size())]
	sprite.visible = true
	sprite.region_rect = Rect2(Vector2(4,0), extents * 2)


func extents_set(_extents):
	collision_shape.shape.extents = _extents
	extents = _extents


func randi_range(x, y):
	"""Utility function to return an integer between two values"""
	return x + randi() % (y - x)
