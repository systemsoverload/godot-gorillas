extends Node

const shaft_length = 10
const head_length = 10

var shaft_origin
var hp
var wind_force
var direction setget set_direction

func _ready():
	shaft_origin = $ArrowShaft.polygon
	hp = $ArrowHead.polygon

func init(direction, wind_force):
	wind_force = Global.randi_range(1, 10)
	self.direction = "right"

func set_direction(_direction):
	# TODO - I think I just realized this would be way easier as a single shape. RIP ArrowShaft
	# FIXME - this generates a good arrow but not centered :(
	direction = _direction
	set_head_direction()
	#2|--------|1
	#3|--------|0
	
	#Always anchor the "base" of the arrow shaft to the "base" of the arrow head
	$ArrowShaft.polygon[1].x = $ArrowHead.polygon[1].x 
	$ArrowShaft.polygon[0].x = $ArrowHead.polygon[1].x
	
	#Then extrude the shaft in the proper direction at the proper length to a given wind speed
	if direction == "left":
		$ArrowShaft.polygon[2].x = $ArrowHead.polygon[1].x + shaft_length * wind_force
		$ArrowShaft.polygon[3].x = $ArrowHead.polygon[1].x + shaft_length * wind_force
	else:
		$ArrowShaft.polygon[2].x = $ArrowHead.polygon[1].x - shaft_length * wind_force
		$ArrowShaft.polygon[3].x = $ArrowHead.polygon[1].x - shaft_length * wind_force
	
	
func set_head_direction():
	if direction == "left":
		$ArrowHead.polygon[0] = Vector2(hp[1].x, hp[0].y)
		$ArrowHead.polygon[1] = Vector2(hp[0].x, hp[1].y)
		$ArrowHead.polygon[2] = Vector2(hp[0].x, hp[2].y)
	else:
		$ArrowHead.polygon = hp