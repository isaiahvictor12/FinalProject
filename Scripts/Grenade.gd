extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity
var boom_countdown
var enemies = ["Enemy", "Enemy2", "Enemy3", "Enemy4", "Enemy5"]
var walls = ["BorderLeft", "BorderRight", "BorderTop", "BorderBottom" , "Wall", "Wall2", "Wall3", "Wall4", "Wall5", "Wall6"]

# Called when the node enters the scene tree for the first time.
func _ready():
	boom_countdown = 150
		 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	p
func _physics_process(delta):
	velocity = velocity * .98 # decrease grenade speed every frame
	var collision = move_and_collide(velocity)
	
	# grenades get destroyed if they hit another grenade
	if collision and collision.collider.name == "Grenade":
		self.queue_free()
		
	boom_countdown -= 1
	if boom_countdown <= 0: # when boom countdown is up, display the explosijon sprite and turn on its collision
		$Explosion.visible = true
		$ExplosionCollision.disabled = false
		if boom_countdown <= -50: # remove grenade 50 frames after explosion shows
			self.queue_free()
		
	# makes grenade bounce off walls
	elif collision and collision.collider.name in walls:
		velocity = velocity.bounce(collision.normal)
	
