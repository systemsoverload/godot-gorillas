extends Node

signal level_ready

onready var Building = preload("res://Building.tscn")
onready var WeatherVane = $WeatherVane


func _ready():
	VisualServer.set_default_clear_color(Color.blue)
	generate_buildings()
	set_wind()
	
func set_wind():
	"""Generate a random value to be applied as wind force with every level"""
	Global.wind = Global.randi_range(-45, 45)
	WeatherVane.init(Global.wind)
	# Place the weather vane  
	WeatherVane.global_position = Vector2((get_viewport().get_visible_rect().size.x / 2) - (WeatherVane.total_size / 2), 
										  (get_viewport().get_visible_rect().size.y) - 7)
	
	
func generate_buildings():
	var next_x = 0
	var buildings = []
	
	# Generate buildings until the visible screen is full
	while next_x <= get_viewport().get_visible_rect().size.x + 100:
		var building = Building.instance()
		buildings.append(building)
		add_child(building)
		
		# Always place the first building against the left edge of the screen
#		# and the remaining buildings n+1 to the right
		if next_x == 0:
			building.global_position.x = building.extents.x + 1
		else:
			building.global_position.x = next_x + building.extents.x + 1
		
		# Place all subsequent buildings 1 building + 2 px over to create small amount of 
		# daylight between them
		next_x = building.global_position.x + building.extents.x

		# Place bottom edge of building on the bottom of the screen + a bit of padding for the weather vane
		building.global_position.y = (get_viewport().get_visible_rect().size.y - building.extents.y) - 15
	Global.level_ready(buildings)

func _on_PlayerUI_throw_values_entered(angle, velocity):
	Global.active_player.throw_banana(angle, velocity)