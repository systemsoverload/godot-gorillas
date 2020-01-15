extends CenterContainer

export(int) var velocity setget set_velocity, get_velocity
export(int) var angle setget set_angle, get_angle
onready var velocity_node = $VBoxContainer/Velocity/Value
onready var angle_node = $VBoxContainer/Angle/Value
export(String) var player_name setget set_player_name, get_player_name
var position setget set_position

signal throw_values_entered

func _ready():
	angle_node.grab_focus()
	
func get_velocity():
	return int(velocity_node.text)

func set_velocity(_velocity):
	velocity_node.text = _velocity

func get_angle():
	return int(angle_node.text)

func set_angle(_angle):
	angle_node.text = _angle

func get_player_name():
	return $VBoxContainer/Name.text
	
func set_player_name(_player_name):
	$VBoxContainer/Name.text = _player_name

func set_position(_position):
    rect_global_position = _position
	
func _on_AngleValue_text_entered(new_text):
	velocity_node.grab_focus()

func _on_VelocityValue_text_entered(new_text):
	# NOTE - not sure why, but the getters for angle and value always return zero here, re-fetch from input
	var _angle = int($VBoxContainer/Angle/Value.text)
	var _velocity = int($VBoxContainer/Velocity/Value.text)
	velocity_node.release_focus()
	emit_signal("throw_values_entered", _angle, _velocity)
