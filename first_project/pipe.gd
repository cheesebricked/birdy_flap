extends Area2D

var velocity = Vector2()
@export var pipe_speed = 4.2
var score_timer = 0
var allow_score= false
var score_timer_count = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.game_active:
		position.x -= pipe_speed

	if int(position.x) <= -500:
		queue_free()



