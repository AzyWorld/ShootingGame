extends KinematicBody2D


var gravity = 10
var shot_power = 100
var shot_direction = Vector2()

var velocity = Vector2()

var LinePoints = []

func _process(_delta):
	velocity += shot_direction
	shot_direction /= 2
	velocity.y += gravity
	move_and_slide(velocity)
	LinePoints.append(position)
	get_parent().get_node("Line2D").points = LinePoints
	

