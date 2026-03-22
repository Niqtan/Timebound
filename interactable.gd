extends Area2D

@export var dialogue_id: String = ""

var player_in_zone = false

signal dialogue_finished

func _ready() -> void:
	$Dialogue.dialogue_finished.connect(_on_dialogue_finished)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("chat") and player_in_zone:
		interact()
	
func _on_dialogue_finished():
	emit_signal("dialogue_finished")
	
func interact():
	if dialogue_id != "":
		$Dialogue.start(dialogue_id)
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = false
		$Dialogue.reset()
