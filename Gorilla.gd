extends Area2D

onready var Banana = preload("res://Banana.tscn")
export(String) var Name = "Monkey"


func _on_Gorilla_body_entered(body):
	print(body.owner)
	
	if body.owner != self:
		body.queue_free()
		body.create_hit_effect("large")

