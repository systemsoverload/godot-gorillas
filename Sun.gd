extends Area2D

func _on_Sun_area_entered(area):
	$Sprite/AnimationPlayer.play("Hit")
