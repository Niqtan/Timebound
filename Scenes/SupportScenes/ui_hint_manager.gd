extends CanvasLayer

@onready var hint_label: Label = $Control/MarginContainer/HintLabel
var hints_shown: Dictionary = {}

func _ready() -> void:	
	hint_label.visible = false
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	HintManager.show_hint.connect(show_label)

func register_label(label: Label):
	hint_label = label

func show_label(text_to_show: String, duration: float = 2.5) -> void:
	# Combine showing hint here once and multiple times
	if hint_label.visible:
		return
	
	hint_label.text = text_to_show
	hint_label.modulate.a = 0
	hint_label.visible = true
	
	# Use tween to using for fading in
	var tween = create_tween()
	tween.tween_property(hint_label, "modulate:a", 1.0, 0.3)
	
	#fading out
	tween.tween_interval(duration)
	tween.tween_property(hint_label, "modulate:a", 0.0, 0.3)
	tween.tween_callback(func(): hint_label.visible = false)
	
func show_label_once(key: String, text_to_show: String, duration: float = 2.5) -> void:
	if hints_shown.has(key):
		return
	
	hints_shown[key] = true
	show_label(text_to_show, duration)
