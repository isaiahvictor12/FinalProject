extends Position2D


var cooldown = 25;
var node = preload("res://bullet.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input():
	cooldown -= 1
	if Input.is_action_pressed("ui_space"):
		cooldown = 25
		var nodeInstance = node.instance()
		var pos = get_node("Position2D")
		print(self.transform)
		nodeInstance.transform = self.tranform
		get_parent().get_parent().add_child(nodeInstance)
