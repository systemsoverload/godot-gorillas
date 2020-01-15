extends Node

onready var Gorilla = preload("res://Gorilla.tscn")

export var friction: float = 10.0
export var wind: int = 0

var player_1
var player_2
var points_to_win: int
var gravity: Vector2 = Vector2(friction, 98.0)

var players = []
var active_player setget set_active_player
var current_scene = null

func _ready():
	# Seed random
	randomize()
	
	# Turn the god damn volume down
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func start_game(player_1_name, player_2_name, gravity, points_to_win):
	player_1 = add_player(player_1_name)
	player_2 = add_player(player_2_name)
	self.points_to_win = int(points_to_win)
	if gravity != "9.8":
		self.gravity = Vector2(friction, float(gravity))
	goto_scene("res://StartMenu.tscn")

func level_ready(buildings):
	place_gorilla(player_1, buildings[randi_range(0, 3)])
	place_gorilla(player_2, buildings[randi_range(5, 7)])
	self.active_player = player_1
	var Scoreboard = current_scene.get_node('/root/World/Scoreboard')
	Scoreboard.player_1 = player_1.score
	Scoreboard.player_2 = player_2.score

func load_level():
	goto_scene("res://World.tscn")

func add_player(player_name):
	var player = Gorilla.instance()
	players.append(player)
	
	# XXX - Bit of a weird hack, but we need to invert the angles for player 1 and player 2
	# to ensure that they are always throwing bananas towards each other
	var direction = Vector2(-1, -1) if players.size() == 1 else Vector2(1, -1)
	player.init(players.size(), player_name, direction)
		
	return player

func change_turn():
	self.active_player = players[active_player.player_number % players.size()]

func place_gorilla(gorilla, building):
	var gorilla_height = gorilla.get_node('Sprite').get_texture().get_size().y
	gorilla.position.x = building.position.x
	gorilla.position.y = building.position.y - building.extents.y - (gorilla_height / 2)
	add_child(gorilla)

	return gorilla
	
func set_active_player(_active_player):
	active_player = _active_player
	var PlayerUI = current_scene.get_node('/root/World/PlayerUI')
	if active_player.player_number == 1:
		PlayerUI.rect_global_position = Vector2(10, 0)
	else:
		PlayerUI.rect_global_position = Vector2(520, 0)
	PlayerUI.angle = ""
	PlayerUI.velocity = ""
	PlayerUI.angle_node.grab_focus()
	PlayerUI.player_name = active_player.player_name

func gorilla_hit(hit_gorilla):
	var Scoreboard = current_scene.get_node('/root/World/Scoreboard')
	var other_gorilla = players[hit_gorilla.player_number % players.size()]
	other_gorilla.dance()
	other_gorilla.score += 1
	Scoreboard.player_1 = player_1.score
	Scoreboard.player_2 = player_2.score

	if player_1.score + player_2.score >= points_to_win:
		yield(get_tree().create_timer(6), "timeout")
		goto_scene("res://GameOver.tscn")
	else:
		# Wait 6 seconds
		yield(get_tree().create_timer(6), "timeout")
		load_level()

func goto_scene(path):
    # This function will usually be called from a signal callback,
    # or some other function in the current scene.
    # Deleting the current scene at this point is
    # a bad idea, because it may still be executing code.
    # This will result in a crash or unexpected behavior.

    # The solution is to defer the load to a later time, when
    # we can be sure that no code from the current scene is running:

    call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
    # It is now safe to remove the current scene
    current_scene.free()

    # Load the new scene.
    var s = ResourceLoader.load(path)

    # Instance the new scene.
    current_scene = s.instance()

    # Add it to the active scene, as child of root.
    get_tree().get_root().add_child(current_scene)

    # Optionally, to make it compatible with the SceneTree.change_scene() API.
    get_tree().set_current_scene(current_scene)
	
func randi_range(x, y):
	"""Utility function to return an integer between two values"""
	return x + randi() % (y - x)
