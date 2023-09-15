extends RigidBody2D

var gravity = 10
var shot_power = 15
var shot_direction = Vector2()

var LinePoints = []

var r = RandomNumberGenerator.new()

func _ready():
	apply_central_impulse(shot_direction*shot_power)
	for ray in $Rays.get_children():
		r.randomize()
		ray.cast_to.y = r.randi_range(10, 150)
	r.randomize()
	$Rays.rotation_degrees = r.randi_range(0, 360)
	

func _process(delta):
	LinePoints.append(global_position)
	get_parent().get_node("Line2D").points = LinePoints


func _on_Explosion_area_body_entered(body):
	if body.is_in_group("obs"):
		$Particles2D.emitting = true
		$Free_timer.start()
	for ray in $Rays.get_children():
		if is_instance_valid(ray.get_collider()):
			if ray.get_collider().is_in_group("obs"):
				ray.get_collider().apply_central_impulse((ray.get_collider().position - position)*400)
	


func _on_Free_timer_timeout():
	queue_free()
