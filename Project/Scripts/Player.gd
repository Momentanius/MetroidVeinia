extends KinematicBody2D

var motion = Vector2()

var speed = 140
var direction = true #Se true, é direita
var is_falling = false
var is_attacking = false

var jump_max = 0

const GRAVITY = 600
const JUMP_FORCE = 250
const UP = Vector2(0, -1) #Para que o salto seja para cima

func _physics_process(delta):
	fall(delta)
	move()
	jump()
	down()
	attack()
	move_and_slide(motion, UP)

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		if is_falling:
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
	if !is_attacking:
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

func attack():
	if Input.is_action_just_pressed('ui_attack') and !is_attacking:
		motion.x = 0
		$AttackSFX.play()
		$AttackTimer.start()
		is_attacking = true
		play_animation('attack')

func down():
	if Input.is_action_just_pressed('ui_down') and not Input.is_action_pressed('ui_left') and not Input.is_action_pressed('ui_right') and not Input.is_action_pressed('ui_up'):
		motion.x = 0
		play_animation('get_down')
	elif Input.is_action_pressed('ui_down') and not Input.is_action_pressed('ui_left') and not Input.is_action_pressed('ui_right') and not Input.is_action_pressed('ui_up'):
		play_animation('duck')


func jump():
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	if motion.y < 0:
		play_animation('jump')


func _on_AttackTimer_timeout():
	is_attacking = false
