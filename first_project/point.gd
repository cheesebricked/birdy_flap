extends Area2D

var score_add = true
var following_points = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area): 
	if global.game_active:
		if area.is_in_group('point'):
			if score_add:
				global.score += 1
				print('in')
				print(area.name)
				score_add = false

