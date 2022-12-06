extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$UserInterface/ScoreLabel.winningScore = 1
	$Enemy.shoot_bullet_type = 1 # enemy projectile is homing projectile 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
