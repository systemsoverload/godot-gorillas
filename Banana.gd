extends Area2D


const explosion_effect = preload("res://ExplosionEffect.tscn")

export(int) var velocity
export(int) var angle

# Physics variables
export (Vector2) var GRAVITY = Vector2(0, 200)
export (Vector2) var motion = Vector2.ZERO
export (bool) var stopped = false

var is_banana = true
export(bool) var hit_building = false
export(bool) var hit_gorilla = false
export(bool) var overlapping = false


func create_hit_effect(size):
	var main = get_tree().current_scene
	var hit_effect

	hit_effect = explosion_effect.instance()
	hit_effect.init(size)

	main.add_child(hit_effect)
	hit_effect.global_position = global_position

func init(angle, impulse):
	velocity = Vector2(cos(deg2rad(angle)) * impulse * -1, 
					   sin(deg2rad(angle)) * impulse)
	
func _physics_process(delta):
	if not stopped:
		position += velocity * delta
		velocity = velocity + delta * GRAVITY
		hit_check()

func hit_check():	
	overlapping = false
	
	for x in get_overlapping_areas():
		# XXX - Gross duck-typing for isinstance checks, better way maybe?
		if x.is_in_group("CollisionBuildings"):
			hit_building = true
		
		# Don't collide with yourself
		# FIXME - you should be able to hit yourself _after_ throwing banana a minimal distance
		if x.is_in_group("CollisionGorillas") and x != self.get_parent():
			hit_gorilla = true
			
		if x.is_in_group('CollisionA'):
			# NOTE - reset  hit_building here otherwise _exiting_ an overlap collision causes an explosion
			hit_building = false
			overlapping = true
			
	if not overlapping:
		if hit_building:
			velocity = Vector2.ZERO
			create_hit_effect("small")
			queue_free()
		elif hit_gorilla:
			velocity = Vector2.ZERO
			create_hit_effect("large")
			queue_free()	