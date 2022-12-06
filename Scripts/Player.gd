extends KinematicBody2D

export var speed = 150

export var rotation_speed = 4
var cooldown = 49;
var bullet = preload("res://Scenes/bullet.tscn") 
var grenade = preload("res://Scenes/grenade.tscn") 
var hasGrenade = false


var velocity = Vector2()
var rotation_dir = 0
var anim = ""
var newAnim = null
var castAnim = null 
var cast_cooldown = 49
var grenade_cooldown = 0

func get_input():

	newAnim = null	
	velocity = Vector2()
	var vx = 0
	var vy = 0
	# adjust animations and velocity based on which direction the user inputs
	if Input.is_action_pressed('ui_left'):
		vx -= 1
		newAnim = "walkleft"
		castAnim = "castleft"
	if Input.is_action_pressed('ui_right'):
		vx += 1
		newAnim = "walkright"
		castAnim = "castright"
	if Input.is_action_pressed('ui_down'):
		vy += 1
		newAnim = "walkdown"
		castAnim = "castdown"
	if Input.is_action_pressed('ui_up'):
		vy -= 1
		newAnim = "walkup"
		castAnim = "castup"
	velocity = Vector2(vx, vy).normalized() / Globals.difficulty # update velocity and alter based on difficulty
	
	# starts animation to cast the "bullet" if cooldown is up and space is pressed
	cooldown -= 1
	if (Input.is_action_pressed("ui_space") && cooldown <= 0):	
		newAnim = castAnim # we will set animation to the casting animation
	
	# throw grenade
	if hasGrenade:
		grenade_cooldown -= 1
		if (Input.is_action_pressed("grenade") && grenade_cooldown <= 0):
			grenade_cooldown = 40
			var grenadeInstance = grenade.instance()
			get_parent().add_child(grenadeInstance)
			grenadeInstance.position = Vector2(position.x, position.y) + Vector2($CollisionShape2D.shape.extents.x + 10, $CollisionShape2D.shape.extents.y + 10).rotated(rotation)
			grenadeInstance.velocity = velocity.normalized() * 7


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity * delta * speed * 100)
	

	if (anim in ["castup", "castleft", "castright", "castdown"]):
		$CastSound.play() # play cast audio 		
		cast_cooldown -= 1
		if cast_cooldown == 10:
			# send bullet now	
			cooldown = 49
			var bulletInstance = bullet.instance()
			get_parent().add_child(bulletInstance)
			bulletInstance.position = Vector2(position.x, position.y) 
			bulletInstance.bullet_owner = self
			bulletInstance.get_node("ColorRect").color = Color.blue
			if anim == "castup":
				bulletInstance.rotation = 1.5 * PI
				bulletInstance.position += Vector2(-5, $CollisionShape2D.shape.extents.y - 45)
			if anim == "castleft":
				bulletInstance.rotation = PI
				bulletInstance.position += Vector2($CollisionShape2D.shape.extents.x - 40, 15)
			if anim == "castright":
				bulletInstance.rotation = 0
				bulletInstance.position += Vector2($CollisionShape2D.shape.extents.x, 0)
			if anim == "castdown":
				bulletInstance.rotation = .5 * PI
				bulletInstance.position += Vector2(5, $CollisionShape2D.shape.extents.y + 10)
			bulletInstance.speed /= Globals.difficulty
			bulletInstance.bullet_owner = "Player"
			
		elif cast_cooldown == 0: # cast animation is done
			anim = newAnim
			cast_cooldown = 49
		
	elif (newAnim == null):
		get_node("Sprite").stop()
	elif (newAnim != anim):
		anim = newAnim
		get_node("Sprite").play(anim)

		



