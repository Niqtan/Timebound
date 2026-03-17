extends Node2D

# List of scenes
@onready var chess_mini_game_scene = Constants.PACKED_MINI_GAME_SCENE_PATHS.chess
@onready var game_map = $GameMap

var tilemaps = []

var min_x = INF
var min_y = INF
var max_x = -INF
var max_y = -INF

var tile_size

const maximum_energy: int = 100

# Standard happiness and energy
var energy: int = 50
var happiness: int = 0
var skill: int = 0

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tilemaps = [
		game_map.get_node("Design"),
		game_map.get_node("Furniture"),
		game_map.get_node("Floor")
	]
	
	tile_size = tilemaps[2].tile_set.tile_size
	
	for tm in tilemaps:
		var rect = tm.get_used_rect()
		
		min_x = min(min_x, rect.position.x)
		min_y = min(min_y, rect.position.y)
		max_x = max(max_x, rect.position.x + rect.size.x)
		max_y = max(max_y, rect.position.y + rect.size.y)
	
	var left = min_x * tile_size.x
	var top = min_y * tile_size.y
	var right = max_x * tile_size.x
	var bottom = max_y * tile_size.y
	
	$Player/Camera2D.limit_left = left
	$Player/Camera2D.limit_top = top
	$Player/Camera2D.limit_right = right
	$Player/Camera2D.limit_bottom = bottom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# What do the players lose out when their stats are low?
# e.g. maybe if their energy is low then we force them to rest

# Likewise, if their stats are high, then there should be some sort of benefit

func change_stats(energy_gain: int, skill_gain: int, happiness_gain: int):
	energy += energy_gain
	skill += skill_gain
	happiness += happiness_gain
	
	energy = clamp(energy, 0, 100)
	happiness = clamp(happiness, 0, 100)
	skill = clamp(skill, 0, 100)
	
	check_stats()
	
func check_stats():
	if energy <= 0:
		force_rest()
	if happiness <= 10:
		# Maybe they're depressed or something?
		pass
	if skill >= 50:
		# Maybe we unlock a new skill
		pass
func force_rest():
	print("Player is exhausted. forcing rest")
	energy += 30
