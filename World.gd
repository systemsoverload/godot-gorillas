extends Node

onready var Building = preload("res://Building.tscn")

signal level_ready

func _ready():
	VisualServer.set_default_clear_color(Color.blue)
	# Seed random
	randomize()
	
	generate_buildings()
	
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
		building.global_position.x = next_x
		
		# Place bottom edge of building on the bottom of the screen
		building.global_position.y = vp_size.y / 2 - building.extents.y
		
	Global.level_ready(buildings)

func _on_PlayerUI_throw_values_entered(angle, velocity):
	# FIXME - Disable all controls while in this state
	Global.active_player.throw_banana(angle, velocity)