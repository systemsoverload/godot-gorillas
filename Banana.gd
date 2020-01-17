extends Area2D

signal hit_enemy_gorilla

const explosion_effect = preload("res://ExplosionEffect.tscn")

var hit_building = false
var hit_gorilla = false
var overlapping = false
var stopped = false
var offscreen = false
var age = 0
var velocity

func create_hit_effect(size):
	var main = get_tree().current_scene
	var hit_effect

	hit_effect = explosion_effect.instance()
	hit_effect.init(size)

	main.add_child(hit_effect)
	hit_effect.global_position = global_position

func init(angle, impulse, direction):
	# NOTE - Fudge factor to bring the "velocity" values closer to inline with the original
	impulse *= 1.75
	velocity = Vector2(cos(deg2rad(angle)) * impulse * direction.x, 
					   sin(deg2rad(angle)) * impulse) * direction.y
	
func _physics_process(delta):
	if not stopped:
		age += delta
		position += velocity * delta
		# TODO - Implement wind friction
		velocity = velocity + (Vector2(Global.wind, Global.gravity) * delta)
		hit_check()

func hit_check():
	overlapping = false
	var enemy_gorilla_hit
	for x in get_overlapping_areas():
		if x.is_in_group("CollisionBuildings"):
			hit_building = true
		
		# Gorillas get ~1s worth of immunity frames to suicide bananas
		if x.is_in_group("CollisionGorillas"):
			if x != self.get_parent() or age > 0.85:
				hit_gorilla = true
				enemy_gorilla_hit = x
			
		if x.is_in_group('CollisionA'):
			# NOTE - reset  hit_building here otherwise _exiting_ an overlap collision causes an explosion
			hit_building = false
			overlapping = true
			
	if hit_gorilla:
			velocity = Vector2.ZERO
			Global.gorilla_hit(enemy_gorilla_hit)
			emit_signal("hit_enemy_gorilla", enemy_gorilla_hit)
			create_hit_effect("large")
			Global.change_turn()
			queue_free()
			
	if hit_building and not overlapping:
		velocity = Vector2.ZERO
		create_hit_effect("small")
		Global.change_turn()
		queue_free()

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	# If a banana flies off the screen and doesnt come back for 6 full seconds, nuke it
	offscreen = true
	yield(get_tree().create_timer(4), "timeout")
	if offscreen:
		Global.change_turn()
		queue_free()

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	offscreen = false
