extends Node

onready var Gorilla = preload("res://Gorilla.tscn")
onready var Building = preload("res://Building.tscn")
onready var Banana = preload("res://Banana.tscn")


func _ready():
	VisualServer.set_default_clear_color(Color.blue)
	generate_buildings()
	
func _process(delta):
#	# XXX - just for debugging
	if Input.is_action_just_pressed("ui_accept"):
		for d in get_tree().get_nodes_in_group("Dynamic"):
			d.queue_free()

		generate_buildings()
	
func generate_buildings():
	var last_x = 0
	var next_x = 0
	var vp_size = get_viewport().size
	
	# XXX - 12 is just enough buildings to fill the test resolution
	# this should be smarter
	var buildings = []
	for x in 12:
		var building = Building.instance()		
		buildings.append(building)
		add_child(building)
		
		# Always place the first building against the left edge of the screen
		# and the remaining buildings n+1 to the right
		if last_x == 0:
			next_x = building.extents.x
		else:
			next_x += building.extents.x * 2
			
		last_x = next_x
		building.position.x = next_x
		building.position.y = vp_size.y / 2 - building.extents.y

	# Place player1
	place_gorilla(buildings[randi_range(0, 3)])
	place_gorilla(buildings[randi_range(5, 7)])


func place_gorilla(building):
	var gorilla = Gorilla.instance()
	var gorilla_height = gorilla.get_node('Sprite').get_texture().get_size().y
	gorilla.position.x = building.position.x
	gorilla.position.y = building.position.y - building.extents.y - (gorilla_height / 2)
	add_child(gorilla)
	
	# FIXME - just debugging
	throw_banana(gorilla, 45, 45)


func throw_banana(gorilla, velocity, angle):
	var banana = Banana.instance()
	banana.owner = gorilla
	banana.position = gorilla.position
	add_child(banana)
	
	banana.apply_impulse(Vector2(), Vector2(145, -65))
	
func randi_range(x, y):
	"""Utility function to return an integer between two values"""
	return x + randi() % (y - x)