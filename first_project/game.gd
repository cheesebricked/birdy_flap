extends Node2D

var ypos = 0
var pipe_load = preload("res://pipe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ypos = randi_range(0,400)
	if !global.game_active and global.game_over:
		if Input.is_action_just_pressed("flap"):
			reset()
	
func spawn_pipe(height):
	var pipe = pipe_load.instantiate()
	pipe.position = Vector2(500, height)
	add_child(pipe)
	print('pipe spawned!')

func _on_timer_timeout():
	if global.game_active:
		spawn_pipe(ypos)
		
func reset():
	global.game_over = false
	global.game_menu = true
	global.score = 0
	get_tree().reload_current_scene()
