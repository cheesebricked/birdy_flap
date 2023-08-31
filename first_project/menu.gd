extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.game_menu:
		$start.show()
		$gameover.hide()
	else:
		$start.hide()
	if global.game_over:
		$start.hide()
		$gameover.show()
