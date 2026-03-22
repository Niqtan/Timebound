extends Node2D

@export var interactable_scene: PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for key in InteractibleData.INTERACTIBLES:
		var data = InteractibleData.INTERACTIBLES[key]
		var instance = interactable_scene.instantiate()
		
		instance.dialogue_id = data.dialogue_id
		instance.position = Vector2(data.position.x * 16, data.position.y * 16)

		instance.get_node("CollisionShape2D").shape.radius  = data.size
		add_child(instance)
