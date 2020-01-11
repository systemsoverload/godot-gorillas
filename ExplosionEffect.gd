extends Node2D


func init(size):
	var small_explosion = $SmallExplosion
	var large_explosion = $LargeExplosion

	if size == "small":
		small_explosion.visible = true
	else:
		large_explosion.visible = true
