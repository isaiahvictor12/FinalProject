extends Label

var score = 0
var winningScore

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func increase_score():
	Globals.totalScore += 1
	score += 1
	self.text = "Score: " + String(score)
	# if winning score is reached, go to win screen
	if score >= winningScore: # if you get error here, set winningScore for level 
		get_tree().change_scene("res://Scenes/YouWin.tscn")

func decrease_score():
	score -= 1
	self.text = "Score: " + String(score)
