extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$UserInterface/ScoreLabel.winningScore = 5
	$Player.hasGrenade = true # user can throw grenade in this level

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
