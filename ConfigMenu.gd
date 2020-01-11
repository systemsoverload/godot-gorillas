extends Node


func _input(e):
	var key_pressed = e.as_text()
	if key_pressed == "P":
		get_tree().change_scene("res://StartMenu.tscn")
	elif key_pressed == "V":
		# TODO - Figure out what the Gorilla.bas "Intro" was?
		pass