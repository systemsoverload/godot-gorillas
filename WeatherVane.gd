extends Node

const shaft_length = 10
const head_length = 10

var total_size
var hp
var wind_speed setget set_wind_speed

func _ready():
	hp = $ArrowHead.polygon

## Single scene debugger	
#	self.position = Vector2(get_viewport().get_visible_rect().size.x / 2, 
#							  (get_viewport().get_visible_rect().size.y) - 7)
#
#func _process(delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		# Randomize self.direction
#		self.wind_speed = Global.randi_range(-10000, 10000)

func init(wind):
	self.wind_speed = wind

func set_wind_speed(_wind_speed):
	wind_speed = _wind_speed / 2 * -1

	if wind_speed >= 0:
		$ArrowHead.polygon[0] = Vector2(hp[1].x, hp[0].y)
		$ArrowHead.polygon[1] = Vector2(hp[0].x, hp[1].y)
		$ArrowHead.polygon[2] = Vector2(hp[0].x, hp[2].y)
	else:
		$ArrowHead.polygon = hp
		
	#Always anchor the "base" of the arrow shaft to the "base" of the arrow head
	$ArrowShaft.polygon[1].x = $ArrowHead.polygon[1].x 
	$ArrowShaft.polygon[0].x = $ArrowHead.polygon[1].x
	
	#Then extrude the shaft in the proper direction at the proper length to a given wind speed
	$ArrowShaft.polygon[2].x = $ArrowHead.polygon[1].x + shaft_length * wind_speed
	$ArrowShaft.polygon[3].x = $ArrowHead.polygon[1].x + shaft_length * wind_speed
	
	# Expose the size of the arrow shaft + 10 (the size of the arrow head) for doing centering calculation
	total_size = $ArrowHead.polygon[1].x + shaft_length * wind_speed + 10
	