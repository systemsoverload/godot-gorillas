extends Node

onready var Gorilla = preload("res://Gorilla.tscn")
onready var Building = preload("res://Building.tscn")
onready var Banana = preload("res://Banana.tscn")

var player_1 = null
var player_2 = null

var active_player 


#func play_turn():
#	yield(active_player.play_turn(), "completed")
#	var new_index = active_player.index % players.length()
#	active_player = get_child(new_index)


func _ready():
	VisualServer.set_default_clear_color(Color.blue)
	# Seed random
	randomize()

	player_1 = Gorilla.instance()
	player_1.init(1, "Player 1")
	player_2 = Gorilla.instance()
	player_2.init(2, "Player 2")
		
	generate_buildings()

	
func _process(delta):
#	# XXX - just for debugging
	if Input.is_action_just_pressed("ui_refresh"):
		for d in get_tree().get_nodes_in_group("Dynamic"):
			d.queue_free()
		generate_buildings()
		
	if Input.is_action_just_pressed("ui_select"):
		player_2.throw_banana()
		player_1.throw_banana()
	
func generate_buildings():
	var last_x = 0
	var next_x = 0
	var vp_size = get_viewport().size
	var buildings = []
		
	# XXX - 12 is just enough buildings to fill the test resolution
	# this should be smarter
	for x in 12:
		var building = Building.instance()		
		buildings.append(building)
		add_child(building)
		
		# Always place the first building against the left edge of the screen
		# and the remaining buildings n+1 to the right
		if last_x == 0:
			next_x = building.extents.x
		else:
			# Place all subsequent buildings 1 building + 2 px over to create small amount of 
			# daylight between them
			next_x += building.extents.x * 2 + 2
			
		last_x = next_x
		building.position.x = next_x
		
		# Place bottom edge of building on the bottom of the screen
		building.position.y = vp_size.y / 2 - building.extents.y

	# Place players
	place_gorilla(player_1, buildings[randi_range(0, 3)])
	place_gorilla(player_2, buildings[randi_range(5, 7)])
	

func place_gorilla(gorilla, building):
	var gorilla_height = gorilla.get_node('Sprite').get_texture().get_size().y
	gorilla.position.x = building.position.x
	gorilla.position.y = building.position.y - building.extents.y - (gorilla_height / 2)
	add_child(gorilla)
	return gorilla
	
	
func randi_range(x, y):
	"""Utility function to return an integer between two values"""
	return x + randi() % (y - x)