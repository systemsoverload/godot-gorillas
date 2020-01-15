extends Area2D

signal hit_enemy_gorilla

var player_name
var player_number
var direction
var score = 0


func init(player_number, player_name, direction):
	self.player_name = player_name
	self.player_number = player_number
	self.direction = direction
	if self.direction.x == 1:
		$Sprite.flip_h = true
	
func throw_banana(angle, velocity):
	var Banana = preload("res://Banana.tscn")
	var banana = Banana.instance()
	banana.init(angle, velocity, direction)
	add_child(banana)
	# This sets the banana position roughly into the throwing hand of the corresponding gorilla
	banana.position = Vector2(10, 14) * direction
	$Sprite/SpriteAnimator.play("Throw")
	banana.connect("hit_enemy_gorilla", self, "_on_Banana_hit_enemy_gorilla")

func _on_Banana_hit_enemy_gorilla(enemy_gorilla):
	# TODO - replace global function calls by bubbling these signals up to game state obj
	print("Hit %s" % enemy_gorilla)

func dance():
	$Sprite/SpriteAnimator.play('Dance')

func _on_SpriteAnimator_animation_finished(anim_name):
	$Sprite/SpriteAnimator.play("Stand")