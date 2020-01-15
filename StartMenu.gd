extends Node

onready var gorilla_1 = $Gorilla_1/Sprite/SpriteAnimator
onready var gorilla_2 = $Gorilla_2/Sprite/SpriteAnimator

func _ready():
	VisualServer.set_default_clear_color(Color.blue)
	$CenterContainer3/PlayerNames.text = "{p1_name} AND {p2_name}".format({"p1_name": Global.player_1.player_name,
																		   "p2_name": Global.player_2.player_name})
	gorilla_1.play('DanceQuiet')
	gorilla_2.play('DanceQuiet')
	$Gorilla_2/Sprite.flip_h = true

	# XXX - hack, signal off of animation end instead of relying on approximate length of intro music
	yield(get_tree().create_timer(12), "timeout")
	gorilla_1.play("Dance")
	gorilla_1.playback_speed = 1.5
	
	gorilla_2.play("Dance")
	gorilla_2.playback_speed = 1.5
	
	yield(get_tree().create_timer(6), "timeout")
	Global.load_level()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Global.load_level()