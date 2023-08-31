extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	text = str(global.hi_score)
	if global.game_over:
		show()
	else:
		hide()
	
