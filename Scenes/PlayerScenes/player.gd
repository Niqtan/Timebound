extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
		
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = input_direction * SPEED

	move_and_slide()
	
	if input_direction != Vector2.ZERO:
		if abs(input_direction.x) > abs(input_direction.y):
			if input_direction.x > 0:
				anim_sprite.animation = "walk-right"
			else:
				anim_sprite.animation = "walk-left"
		else:
			# vertical movement
			if input_direction.y > 0:
				anim_sprite.animation = "walk-down"
			else:
				anim_sprite.animation = "walk-up"
		anim_sprite.play()
	else:
		anim_sprite.stop()
		
