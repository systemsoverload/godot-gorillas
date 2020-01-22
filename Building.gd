extends Area2D

onready var collision_shape = $CollisionShape2D
onready var building = $BuildingRect
onready var windows = $Windows

var colors = [
	"a80000", 
	"#00a8a8",
	"#a8a8a8"
]
var building_color

export(Vector2) var extents setget extents_set


func _ready():
	"""When creating a new building instance randomize the color, height, width and 
	reshape collision objects to match"""
	colors.shuffle()
	building_color = colors.front()
	self.extents = Vector2(Global.randi_range(20,50), Global.randi_range(44, 120))
	windows.region_rect = Rect2(Vector2(0,0), Vector2(round(extents.x * 2 / 10) * 10 - 6, round(extents.y * 2 / 10) * 10 - 6))
	collision_shape.set_shape(collision_shape.shape.duplicate())
	
func extents_set(_extents):
	extents = _extents
	$CollisionShape2D.shape.extents = _extents
	update()
	
func _draw():
	"""Draw a rectangle on top of the attached collision shape"""
	var points = [extents * -1, # Bottom left
				  extents * Vector2(-1, 1), # Top left
				  extents, # Top right
				  extents * Vector2(1, -1), # Bottom right
				  extents * -1] # Bottom left
	building.color = building_color
	building.z_index = 3
	building.polygon = PoolVector2Array(points)
