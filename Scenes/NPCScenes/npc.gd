extends CharacterBody2D

@onready var body_animated_sprite = $Body
@onready var outfit_animated_sprite = $Outfit
@onready var hair_animated_sprite = $Hair

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player 

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
	randomize()
	start_pos = position

func _process(delta: float) -> void:
	if current_state == 0 or current_state == 1:
		play_anim("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			play_anim("walk_l")
		if dir.x == 1:
			play_anim("walk_r")
		if dir.y == 1:
			play_anim("walk_d")
		if dir.y == -1:
			play_anim("walk_u")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT,Vector2.DOWN])
			MOVE:
				move(delta)
	
				
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chatting:
		position += dir * speed * delta

func play_anim(anim_name):
	body_animated_sprite.play(anim_name)
	outfit_animated_sprite.play(anim_name)
	hair_animated_sprite.play(anim_name)
	

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true 
