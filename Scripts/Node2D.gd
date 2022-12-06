extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sound.play() # play sound that is in this sound object


# Called every frame. 'delta' is the elapsed time since the previous frame.
# go to start screen when user hit enter
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/StartScreen.tscn")
