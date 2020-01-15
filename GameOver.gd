extends Node

func _input(event):
	if event is InputEventKey and event.pressed:
		Global.player_1.queue_free()
		Global.player_2.queue_free()
		Global.goto_scene("res://ConfigMenu.tscn")
		
func _ready():
	$CenterContainer/VBoxContainer/VBoxContainer/Player1Name.text = Global.player_1.player_name
	$CenterContainer/VBoxContainer/VBoxContainer/Player1Score.text = str(Global.player_1.score)
	$CenterContainer/VBoxContainer/VBoxContainer2/Player2Name.text = Global.player_2.player_name
	$CenterContainer/VBoxContainer/VBoxContainer2/Player2Score.text = str(Global.player_2.score)