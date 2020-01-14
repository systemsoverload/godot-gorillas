extends Area2D

onready var controls = $PlayerInput

var player_name
var player_number
var direction
var score = 0


func init(player_number, player_name, direction):
	self.player_name = player_name
	self.player_number = player_number
	self.direction = direction
	
func throw_banana(angle, velocity):
	var Banana = preload("res://Banana.tscn")
	var banana = Banana.instance()
	banana.init(angle, velocity, direction)
	add_child(banana)

func dance():
	$Sprite/SpriteAnimator.play('Dance')

func _on_SpriteAnimator_animation_finished(anim_name):
	if anim_name == "Dance":
		$Sprite/SpriteAnimator.play("Stand")
