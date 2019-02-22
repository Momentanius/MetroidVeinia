extends KinematicBody2D

var motion = Vector2()

var speed = 140
var direction = true #Se true, é direita
var falling

const GRAVITY = 600
const JUMP_FORCE = 400
const UP = Vector2(0, -1) #Para que o salto seja para cima

func _physics_process(delta):
	fall(delta)
	move()
	jump()
	move_and_slide(motion, UP)

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		if falling:
			play_animation('fall')
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

func jump():
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			play_animation('jump')
			motion.y = -JUMP_FORCE
			play_animation('jump')