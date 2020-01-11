extends Area2D

onready var Banana = preload("res://Banana.tscn")
onready var controls = $PlayerInput

var player_name
var player_number


func _ready():
	controls.player_name = player_name
	
	if player_number == 1:
		controls.rect_global_position = Vector2(10, 0)
	else:
		controls.rect_global_position = Vector2(520, 0)


func init(player_number, player_name):
	self.player_name = player_name
	self.player_number = player_number

	
func throw_banana():
	var banana = Banana.instance()
	var angle = controls.angle
	
	if player_number == 1:
		angle += 180
	else:
		angle += 270

	banana.init(angle, controls.velocity)
	add_child(banana)
