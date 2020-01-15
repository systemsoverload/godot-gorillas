extends Node

var player_1_name: String
var player_2_name: String
var gravity: String
var points_to_win: String

func _ready():
	$Player1Name/Value.grab_focus()
	
func _input(e):
	var key_pressed = e.as_text()
	if key_pressed == "P" and $Instructions2.visible:
		Global.start_game(player_1_name, player_2_name, gravity, points_to_win)
	elif key_pressed == "V":
		# TODO - Figure out what the Gorilla.bas "Intro" was?
		pass

func _on_Player1Name_Value_text_entered(new_text):
	if new_text == "":
		player_1_name = "Player 1"
	else:
		player_1_name = new_text
		
	$Player2Name.visible = true
	$Player2Name/Value.grab_focus()

func _on_Player2Name_Value_text_entered(new_text):
	if new_text == "":
		player_2_name = "Player 2"
	else:
		player_2_name = new_text
		
	$Points.visible = true
	$Points/Value.grab_focus()

func _on_PointsValue_text_entered(new_text):
	if new_text == "":
		points_to_win = "3"
	else:
		points_to_win = new_text
		
	$Gravity.visible = true
	$Gravity/Value.grab_focus()

func _on_Gravity_Value_text_entered(new_text):
	if new_text == "":
		gravity = "9.8"
	else:
		gravity = new_text
		
	$HR.visible = true
	$Instructions2.visible = true
