extends Node2D

var selected = 0

func change_menu_color():
	# all buttons start white
	$Level1.color = Color.white
	$Level2.color = Color.white
	$Level3.color = Color.white	
	$Settings.color = Color.white
	$Quit.color = Color.white
	
	# selected button turns gray
	match selected:
		0:
			$Level1.color = Color.gray
		1:
			$Level2.color = Color.gray
		2:
			$Level3.color = Color.gray
		3:
			$Settings.color = Color.gray
		4:
			$Quit.color = Color.gray

func _ready():
	change_menu_color()

func _input(_event):
	# if down is pressed selected becomes the one below, unless its the last, then it would become the first
	if Input.is_action_just_pressed("ui_down"):
		selected = (selected+1) % 5;
		change_menu_color() # changes color of buttons
	# if up is pressed selected becomes the one above, unless its the first, then it would become the last
	elif Input.is_action_just_pressed("ui_up"):
		if selected > 0:
			selected = selected - 1
		else:
			selected = 4
		change_menu_color()
	# if enter is pressed, it goes to the scene corresponding with the selected choice
	elif Input.is_action_just_pressed("ui_accept"):
		match selected:
			0: 
				# Level 1
				get_tree().change_scene("res://Scenes/Level1.tscn")
			1:
				# Level 2
				get_tree().change_scene("res://Scenes/Level2.tscn")
			2:
				# Level 3
				get_tree().change_scene("res://Scenes/Level3.tscn")
			3:
				# Settings
				get_tree().change_scene("res://Scenes/Settings.tscn")
			4:
				# Quit game
				get_tree().quit()
