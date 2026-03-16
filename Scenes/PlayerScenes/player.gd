extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_sprite = $AnimatedSprite2D
@onready var tilemap = $"../GameMap"

var stair_tilemap: TileMapLayer

func _ready() -> void:
	stair_tilemap = tilemap.get_node("Design")

func get_tile_name():
	var searchPosition = global_position
	var playerOffSet = Vector2(0, 10)
	searchPosition += playerOffSet

	var tile_pos = stair_tilemap.local_to_map(searchPosition)
	var tile_data = stair_tilemap.get_cell_tile_data(tile_pos)
	
	if tile_data:
		var tile_name = tile_data.get_custom_data("stairs")
		return tile_name
	else:
		return ""

func _physics_process(delta: float) -> void:
		
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = input_direction * SPEED

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
		
	if "stair" in get_tile_name():
		velocity 	*= 0.5

	move_and_slide()
