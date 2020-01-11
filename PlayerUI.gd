extends CenterContainer

export(int) var velocity setget ,get_velocity
export(int) var angle setget ,get_angle
export(String) var player_name setget set_player_name, get_player_name

func get_velocity():
	return int($VBoxContainer/Velocity/Value.text)

func get_angle():
	return int($VBoxContainer/Angle/Value.text)

func get_player_name():
	$VBoxContainer/Name.textpass
	
func set_player_name(_player_name):
	$VBoxContainer/Name.text = _player_name