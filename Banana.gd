extends RigidBody2D


const small_explosion_effect = preload("res://SmallExplosionEffect.tscn")
const large_explosion_effect = preload("res://LargeExplosionEffect.tscn")


func create_hit_effect(size):
	var main = get_tree().current_scene
	var hit_effect
	
	if size == "small":
		hit_effect = small_explosion_effect.instance()
	elif size == "large":
		hit_effect = large_explosion_effect.instance()
		
	main.add_child(hit_effect)
	hit_effect.global_position = global_position