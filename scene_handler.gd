extends Node2D

# List of scenes
@onready var chess_mini_game_scene = Constants.PACKED_MINI_GAME_SCENE_PATHS.chess
@onready var game_map = get_tree().current_scene.get_node("GameMap")
@onready var camera2D = get_tree().current_scene.get_node("Player/Camera2D")
@onready var statistics_bar = get_tree().current_scene.get_node("CanvasLayer/MainUIScene")

var tilemaps = []

var min_x = INF
var min_y = INF
var max_x = -INF
var max_y = -INF

var tile_size

var current_scene = null

signal stats_changed(energy, skill, happiness)

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
	
	camera2D.limit_left = left
	camera2D.limit_top = top
	camera2D.limit_right = right
	camera2D.limit_bottom = bottom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# What do the players lose out when their stats are low?
# e.g. maybe if their energy is low then we force them to rest

# Likewise, if their stats are high, then there should be some sort of benefit

func change_stats(energy_delta: int, skill_delta: int, happiness_delta: int):
		Global.energy += energy_delta
		Global.skill += skill_delta
		Global.happiness += happiness_delta
		
		Global.energy = clamp(Global.energy, 0, 100)
		Global.happiness = clamp(Global.happiness, 0, 100)
		Global.skill = clamp(Global.skill, 0, 100)
		
		emit_signal("stats_changed", Global.energy, Global.skill, Global.happiness)
		
		check_stats()
	
func check_stats():	
	if Global.energy <= 20:
		force_rest()
	if Global.happiness <= 10:
		# Maybe they're depressed or something?
		pass
	if Global.skill >= 50:
		# Maybe we unlock a new skill
		pass
	
func force_rest():
	print("Player is exhausted. forcing rest")
	Global.energy += 30
