extends Node2D

onready var bullet = preload("res://scenes/Bullet.tscn").instance()
onready var RBullet = preload("res://scenes/RigidBullet.tscn").instance()

func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click"):
		if Global.mode == 1:
			bullet = preload("res://scenes/Bullet.tscn").instance()
			bullet.shot_power = 1000
			bullet.shot_direction = Vector2(0, bullet.shot_power).rotated(rotation-1.57)
			bullet.position = position
			get_parent().add_child(bullet)
		elif Global.mode == 2:
			RBullet = preload("res://scenes/RigidBullet.tscn").instance()
			RBullet.shot_direction = Vector2(0, bullet.shot_power).rotated(rotation-1.57)
			RBullet.global_position = position
			get_parent().add_child(RBullet)
	if Input.is_action_just_pressed("1"):
		get_parent().get_node("Camera2D").current = true
		

