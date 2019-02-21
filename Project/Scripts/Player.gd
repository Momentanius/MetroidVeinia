extends KinematicBody2D

var motion = Vector2()

var speed = 140
var direction = true #Se true, é direita

const GRAVITY = 200

func _physics_process(delta):
	move()
	fall(delta)

func fall(delta):
	motion.y += delta * GRAVITY

func play_animation(animation):
	$AnimatedSprite.play(animation)

func flipar():
	if direction:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

func move():
	if Input.is_action_pressed('ui_right') and not Input.is_action_pressed('ui_left'):
		direction = true
		flipar()
		play_animation('walk')
		motion.x = speed
	elif Input.is_action_pressed('ui_left') and not Input.is_action_pressed('ui_right'):
		direction = false
		flipar()
		play_animation('walk')
		motion.x = -speed
	else:
		play_animation('idle')
		motion.x = 0
	move_and_slide(motion)