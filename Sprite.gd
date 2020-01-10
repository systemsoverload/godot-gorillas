extends Sprite

var building_red = load("res://assets/building_red.png") 
var building_blue = load("res://assets/building_blue.png") 
var building_gray = load("res://assets/building_gray.png") 

var textures = [building_red, building_blue, building_gray]

func _ready():
	texture = textures[randi() % 3]