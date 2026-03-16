extends Node2D

# List of scenes
@onready var chess_mini_game_scene = Constants.PACKED_MINI_GAME_SCENE_PATHS.mini_chess_game

const maximum_energy: int = 100

# Standard happiness and energy
var energy: int = 50
var happiness: int = 0
var skill: int = 0

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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

func change_mini_game(mini_game: String):
	
	if mini_game == "chess":
		current_scene = chess_mini_game_scene.instantiate()
		add_child(current_scene)
