extends RigidBody2D

var gravity = 10
var shot_power = 15
var shot_direction = Vector2()

var LinePoints = []

func _ready():
	apply_central_impulse(shot_direction*shot_power)
	

func _process(delta):
	LinePoints.append(global_position)
	get_parent().get_node("Line2D").points = LinePoints
