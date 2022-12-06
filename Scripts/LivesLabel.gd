extends Label


# Declare member variables here. Examples:
# var a = 2
var lives = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func increase_lives():
	lives += 1
	self.text = "Lives: " + String(lives)

func decrease_lives():
	Globals.deaths += 1 # update global deaths counter
	lives -= 1
	self.text = "Lives: " + String(lives)
	if lives <= 0: # if no more lives, go to lose screen
		get_tree().change_scene("res://Scenes/YouLose.tscn")
