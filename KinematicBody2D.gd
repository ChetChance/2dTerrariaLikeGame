extends KinematicBody2D

const SPEED = 350
const JUMPFORCE = 900
const GRAVITY = 40
 
var velocity = Vector2(0,0)

var jumping = false
var attack = false
var state_machine
var lorR = 1

onready var animation = $AnimatedSprite
 
func _physics_process(delta):
	state_machine = $AnimationTree.get("parameters/playback")
	
	if jumping == true:
		if(lorR == 1):
			$AnimationPlayer.play("Jump")
		if(lorR == 2):
			$AnimationPlayer.play("JumpL")
	
	if $AnimationPlayer.current_animation == "Attack1" or $AnimationPlayer.current_animation == "AttackL":
		attack = true
	else:
		attack = false
	
	if Input.is_action_pressed("Attack"):
		state_machine.travel("Attack1")
		if lorR == 1:
			$AnimationPlayer.play("Attack1")
		else:
			$AnimationPlayer.play("AttackL")
	else:
		attack = false
		#return
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		if jumping == false and attack == false:
			$AnimationPlayer.play("Run")
		lorR = 1
		$GraveRobber.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		if jumping == false and attack == false:
			$AnimationPlayer.play("RunLeft")
		lorR = 2
		$GraveRobber.flip_h = true
	elif Input.is_action_just_pressed("Attack"):
		state_machine.travel("Attack1")
		attack = true
	elif jumping == false and attack == false:
			if(lorR == 1):
				$AnimationPlayer.play("Idle")
			elif(lorR == 2):
				$AnimationPlayer.play("IdleL")
		
	if Input.is_action_pressed("restart"):
		position = Vector2(544,288)
		velocity.y = 0
	
	if is_on_floor():
		velocity.y = 0
		jumping = false
		 
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y -= JUMPFORCE
		jumping = true
	velocity.y += GRAVITY
	 
	move_and_slide(velocity, Vector2.UP)    
	velocity.x = lerp(velocity.x, 0, 0.2)
