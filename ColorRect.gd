extends ColorRect


func _ready():
#	# TODO - apply real building textures, just randomly generate a color for 
#	# debugging before then
	var colors = [Color('#a8a8a8'), Color('#cab50b'), Color('#a80000'), Color('#00a800')]
	color = colors[randi() % colors.size()]