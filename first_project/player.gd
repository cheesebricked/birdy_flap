extends RigidBody2D

@export var flap_force = float(-200.0)
@export var flap_force_multiplyer = float(3.3)
@onready var jump_sound = $jump_sound
@onready var bgm = $bgm
@onready var lose_bgm = $game_over_bgm

var started = false
var rotate_by = float(1)
var flap_animation_timer = false
var flap_timer = 0
var anim_timer = 0
var anim_idle_switch = 12

var gameover_bgm_playing = false


const max_rotation_degrees = -30

func _physics_process(delta):
	if Input.is_action_just_pressed('flap'):
		if !global.game_active:
			start()
		else:
			if global.game_active:
				flap()
	
	if Input.is_action_just_released('flap'):
		flap_animation_timer = true
		
	if flap_animation_timer:
		flap_timer += 1
		if flap_timer == 21:
			get_node("bird/wing_down").show()
			get_node("bird/wing_up").hide()
			flap_timer = 0
			flap_animation_timer = false

	if rotation_degrees <= max_rotation_degrees:
		angular_velocity = 0
		rotation_degrees = max_rotation_degrees
		
	if linear_velocity.y > 0:
		if rotation_degrees <= 54:
			angular_velocity = 3
		else:
			angular_velocity = 0
			
	if !global.game_active and !global.game_over:
		idle()

func start():
	if started: return
	started = true
	gravity_scale = 2.0
	global.game_menu = false
	global.game_active = true
	flap()
	bgm.play()

func flap():
	linear_velocity.y = (flap_force * flap_force_multiplyer)
	angular_velocity = -12
	get_node("bird/wing_down").hide()
	get_node("bird/wing_up").show()
	jump_sound.play()

func idle():
	anim_timer += 1
	if anim_timer == anim_idle_switch:
		get_node("bird/wing_down").hide()
		get_node("bird/wing_up").show()
	if anim_timer == (2 * anim_idle_switch):
		get_node("bird/wing_down").show()
		get_node("bird/wing_up").hide()
		anim_timer = 0
		
	
func _on_area_2d_area_entered(area): #collision 
	if area.is_in_group('pipe'):
		global.game_active = false
		global.game_over = true
		bgm.stop()
		if global.score > global.hi_score:
			global.hi_score = global.score
		if !gameover_bgm_playing:
			lose_bgm.play()
			gameover_bgm_playing  = true
		
