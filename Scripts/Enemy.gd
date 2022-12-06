extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity
var time = 0
var shoot_cooldown = 100
var bullet = preload("res://Scenes/bullet.tscn") 
var player 
var shoot_bullet_type = 0
var walls = ["BorderLeft", "BorderRight", "BorderTop", "BorderBottom" , "Wall", "Wall2", "Wall3", "Wall4", "Wall5", "Wall6"]

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().find_node("Player") 
	new_vel()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta * Globals.difficulty) # moves the enemy based on velocity and difficulty
	
	# bounce if it hits a wall
	if collision and collision.collider.name in walls:
		velocity = velocity.bounce(collision.normal)
		
	# die if it hits grenade
	if collision and collision.collider.name == "Grenade": 
		if get_parent().get_node(collision.collider.name).get_node("ExplosionCollision").disabled == false:
			get_parent().get_node("UserInterface/ScoreLabel").increase_score() # increase score
			self.queue_free() # delete enemy
				
	# if player exists then face it
	if get_parent().find_node("Player") != null: # if the player exists, it looks at it
		look_at(player.position)
		
	# finds out when to get a new velocity based on time passed
	time += delta # increase time
	if time >= 1: # if time reaches 1 then reset and get new velocity
		time = 0
		new_vel()
		
	randomize()
	if (rand_range(0,1) >= .5): shoot_cooldown -= 1 ## 50% of the time, decrease the shoot cooldown

	if shoot_cooldown <= 0: # check if cooldown is ready
		shoot_cooldown = 100 # reset cooldown
		var bulletInstance = bullet.instance() # create bullet and set position
		bulletInstance.position = Vector2(position.x, position.y) + Vector2($CollisionShape2D.shape.extents.x + 50, 0).rotated(rotation)
		get_parent().add_child(bulletInstance)
		bulletInstance.rotation = rotation + rand_range(-.25 / Globals.difficulty, .25 / Globals.difficulty) # set rotation of bullet plus make it slightly inaccurate
		bulletInstance.bullet_owner =  "Enemy" # set enemy as owner of bullet to prevent self killing
		bulletInstance.bullet_type = shoot_bullet_type
		bulletInstance.speed *= Globals.difficulty # adjust bullet speed based on difficulty
		bulletInstance.get_node("HitSound").play()
		
# returns new random velocity
func new_vel():
	randomize()
	var velX = rand_range(-100, 100)
	var velY = rand_range(-100, 100)
	velocity = Vector2(velX, velY) 
	
	 
