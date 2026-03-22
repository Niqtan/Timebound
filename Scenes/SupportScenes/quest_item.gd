extends Node2D

@export var dialogue_id: String = ""
@export var context: String = ""
@export var item_sprite: Texture2D

var current_scene: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$QuestSprite.texture = item_sprite
	$QuestSprite.scale = Vector2(0.2, 0.2)
	
	var interactible_scene = Constants.PACKED_GENERAL_SCENES.interactible_scene.instantiate()
	interactible_scene.dialogue_id = dialogue_id
	add_child(interactible_scene)
	
	interactible_scene.dialogue_finished.connect(_on_dialogue_finished)

func _on_dialogue_finished():
	change_mini_game_scene(context)
	
func change_mini_game_scene(context: String) -> void:
	
	if current_scene:
		current_scene.queue_free()
		await current_scene.tree_exited
	
	match context:
		"chess":
			get_tree().change_scene_to_file(Constants.PACKED_MINI_GAME_SCENE_PATHS[context])
		_:
			pass


func _on_chess_finished():
	get_tree().change_scene_to_file("res://scene_handler.tscn")
	
