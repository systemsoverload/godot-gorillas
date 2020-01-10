extends Node

onready var gorilla_1 = $Gorilla_1/Sprite/SpriteAnimator
onready var gorilla_2 = $Gorilla_2/Sprite/SpriteAnimator

func _ready():
	VisualServer.set_default_clear_color(Color.blue)
	gorilla_1.play('Dance')
	gorilla_2.play('Dance')