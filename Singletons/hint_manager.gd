extends Node

signal show_hint(text, duration)

func show_label(text: String, duration: float = 2.5):
	emit_signal("show_hint", text, duration)
