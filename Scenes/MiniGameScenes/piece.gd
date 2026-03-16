extends Node2D

@onready var sprite = $PieceSprite

func set_texture(tex: Texture2D):
	sprite.texture = tex
