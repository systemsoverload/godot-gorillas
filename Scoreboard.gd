extends Node2D

var player_1 setget set_player_1, get_player_1
var player_2 setget set_player_2, get_player_2

func set_player_1(_player_1):
	$Player1Score.text = str(_player_1)

func set_player_2(_player_2):
	$Player2Score.text = str(_player_2)
	
func get_player_1():
	return int($Player1Score.text)
	
func get_player_2():
	return int($Player2Score.text)