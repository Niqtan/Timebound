extends Area2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("chat") and Global.player_in_zone:
		interact()
					
func interact():
	$Dialogue.start()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.player_in_zone = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.player_in_zone = false
		$Dialogue.reset()
