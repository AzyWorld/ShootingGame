extends Node2D

onready var bullet = preload("res://scenes/Bullet.tscn").instance()
onready var RBullet = preload("res://scenes/RigidBullet.tscn").instance()
onready var Obstacle = preload("res://scenes/Obstacle.tscn").instance()
onready var Grenade = preload("res://scenes/ExplosionBullet.tscn").instance()

var obsPos1 = Vector2()
var obsPos2 = Vector2()

var releaseShotPower = 1

func _process(delta):
	$Gun.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click"):
		obsPos1 = get_global_mouse_position()
	if Input.is_action_pressed("click"):
		if Global.mode == 1 or Global.mode == 2 or Global.mode == 7:
			releaseShotPower += 0.015
			if $Gun/Polygon2D.scale.y > 0.32:
				$Gun/Polygon2D.scale.y -= 0.011
	if Input.is_action_just_released("click"):
		if Global.mode == 1:
			bullet = preload("res://scenes/Bullet.tscn").instance()
			bullet.shot_power = 300 * releaseShotPower
			bullet.shot_direction = Vector2(0, bullet.shot_power).rotated($Gun.rotation-1.57)
			bullet.position = $Gun.position
			add_child(bullet)
		elif Global.mode == 2:
			RBullet = preload("res://scenes/RigidBullet.tscn").instance()
			RBullet.shot_direction = Vector2(0, bullet.shot_power).rotated($Gun.rotation-1.57)
			RBullet.global_position = $Gun.position
			RBullet.shot_power = 10 * releaseShotPower
			add_child(RBullet)
		elif Global.mode == 3:
			obsPos2 = get_global_mouse_position()
			Obstacle = preload("res://scenes/Obstacle.tscn").instance()
			Obstacle.position = obsPos1 - ((obsPos1 - obsPos2)/2)
			Obstacle.get_node("Polygon2D").polygon[0] = (obsPos1 - obsPos2) / 2
			Obstacle.get_node("Polygon2D").polygon[2] = (obsPos2 - obsPos1) / 2
			Obstacle.get_node("Polygon2D").polygon[1] = Vector2(obsPos1.x - obsPos2.x, obsPos2.y - obsPos1.y)/2
			Obstacle.get_node("Polygon2D").polygon[3] = Vector2(obsPos2.x - obsPos1.x, obsPos1.y - obsPos2.y)/2
			Obstacle.get_node("CollisionShape2D").scale = (obsPos1 - obsPos2)/2
			add_child(Obstacle)
		elif Global.mode == 4:
			Obstacle = preload("res://scenes/Obstacle.tscn").instance()
			Obstacle.position = get_global_mouse_position()
			Obstacle.get_node("Polygon2D").polygon[0] = Vector2(-80, 80)
			Obstacle.get_node("Polygon2D").polygon[2] = Vector2(80, -80)
			Obstacle.get_node("Polygon2D").polygon[1] = Vector2(-80, -80)
			Obstacle.get_node("Polygon2D").polygon[3] = Vector2(80, 80)
			Obstacle.get_node("CollisionShape2D").scale = Vector2(80, 80)
			add_child(Obstacle)
		elif Global.mode == 5:
			Obstacle = preload("res://scenes/Obstacle.tscn").instance()
			Obstacle.position = get_global_mouse_position()
			Obstacle.get_node("Polygon2D").polygon[0] = Vector2(-400, 40)
			Obstacle.get_node("Polygon2D").polygon[2] = Vector2(400, -40)
			Obstacle.get_node("Polygon2D").polygon[1] = Vector2(-400, -40)
			Obstacle.get_node("Polygon2D").polygon[3] = Vector2(400, 40)
			Obstacle.get_node("CollisionShape2D").scale = Vector2(400, 40)
			add_child(Obstacle)
		elif Global.mode == 6:
			Obstacle = preload("res://scenes/Obstacle.tscn").instance()
			Obstacle.position = get_global_mouse_position()
			Obstacle.get_node("Polygon2D").polygon[0] = Vector2(-40, 400)
			Obstacle.get_node("Polygon2D").polygon[2] = Vector2(40, -400)
			Obstacle.get_node("Polygon2D").polygon[1] = Vector2(-40, -400)
			Obstacle.get_node("Polygon2D").polygon[3] = Vector2(40, 400)
			Obstacle.get_node("CollisionShape2D").scale = Vector2(40, 400)
			add_child(Obstacle)
		elif Global.mode == 7:
			Grenade = preload("res://scenes/ExplosionBullet.tscn").instance()
			Grenade.shot_direction = Vector2(0, bullet.shot_power).rotated($Gun.rotation-1.57)
			Grenade.global_position = $Gun.position
			Grenade.shot_power = 10 * releaseShotPower
			add_child(Grenade)
		releaseShotPower = 1
		$Tween.interpolate_property($Gun/Polygon2D, "scale", $Gun/Polygon2D.scale, Vector2(1, 1), 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
		$Tween.start()
	if Input.is_action_just_pressed("1"):
		get_node("Camera2D").current = true
	update()
		

func _draw():
	if (Global.mode == 3) and Input.is_action_pressed("click"):
		draw_rect(Rect2(get_global_mouse_position(), (obsPos1 - get_global_mouse_position())), Color(1, 1, 1, 0.75), true)
	elif (Global.mode == 4) and Input.is_action_pressed("click"):
		draw_rect(Rect2(get_global_mouse_position()-Vector2(80, 80), Vector2(160, 160)), Color(1, 1, 1, 0.75), true)
	elif (Global.mode == 5) and Input.is_action_pressed("click"):
		draw_rect(Rect2(get_global_mouse_position()-Vector2(400, 40), Vector2(800, 80)), Color(1, 1, 1, 0.75), true)
	elif (Global.mode == 6) and Input.is_action_pressed("click"):
		draw_rect(Rect2(get_global_mouse_position()-Vector2(40, 400), Vector2(80, 800)), Color(1, 1, 1, 0.75), true)
	else:
		draw_rect(Rect2(get_global_mouse_position(), (obsPos1 - obsPos2)), Color(1, 1, 1, 0), false)
		
		
		
