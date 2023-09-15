extends CanvasLayer

var LocalMode = 6

func _process(delta):
	if $Buttons/Bad.pressed:
		Global.mode = 1
		LocalMode = 1
	if $Buttons/Good.pressed:
		Global.mode = 2
		LocalMode = 2
	if $Buttons/Obstacle.pressed:
		Global.mode = 3
		LocalMode = 3
	if $Buttons/Cube.pressed:
		Global.mode = 4
		LocalMode = 4
	if $Buttons/Rect_hor.pressed:
		Global.mode = 5
		LocalMode = 5
	if $Buttons/Rect_vert.pressed:
		Global.mode = 6
		LocalMode = 6
	if $Buttons/Explosion_bullet.pressed:
		Global.mode = 7
		LocalMode = 7
		
	if $Clear.pressed:
		for i in get_tree().get_nodes_in_group("obs"):
			i.queue_free()
		
	if $Buttons/Bad.is_hovered() or $Buttons/Good.is_hovered() or $Buttons/Obstacle.is_hovered() or $Buttons/Rect_vert.is_hovered() or $Buttons/Rect_hor.is_hovered() or $Buttons/Cube.is_hovered() or $Clear.is_hovered() or $Buttons/Explosion_bullet.pressed:
		Global.mode = 15
	else:
		Global.mode = LocalMode
