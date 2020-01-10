extends Area2D

onready var collision_shape = $CollisionShape2D
onready var color_rect = $ColorRect

export(Vector2) var extents setget extents_set


func _ready():
	"""When creating a new building instance, randomize the height and width and 
	reshape collision objects to match"""
	# FIXME - there is some kind of bug with dynamic building width + the layout
	# code in World.gd::generate_buildings, hardcoded to 40 for now
	self.extents = Vector2(35, randi_range(44, 100))
	collision_shape.set_shape(collision_shape.shape.duplicate())
	
	# TODO - These are just debugging shapes, delete them when sprites work
	color_rect.rect_position = extents * -1 
	color_rect.rect_size = extents * 2


func extents_set(_extents):
	#print("Setting new building h:{h} w:{w}".format({"w":_extents.x, "h": _extents.y}))
	collision_shape.shape.extents = _extents
	extents = _extents


func randi_range(x, y):
	"""Utility function to return an integer between two values"""
	return x + randi() % (y - x)


func _on_Building_body_entered(body):
	body.queue_free()
	body.create_hit_effect("large")
