extends CanvasLayer


const MAX_BAR_WIDTH = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneHandler.stats_changed.connect(_on_stats_changed)
	_on_stats_changed(Global.energy,Global.skill,Global.happiness)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_stats_changed(energy, skill, happiness):
	update_happiness_bar(happiness)
	update_energy_bar(energy)
	update_skill_bar(skill)

func update_happiness_bar(value):
	var happiness_bar = $Control/Statistics/HBoxContainer/Happiness/HappinessBar
	if happiness_bar.sprite_frames == null:
		print("no sprite frames!")
	
	var max_frames = happiness_bar.sprite_frames.get_frame_count("full_default") - 1
	var frame = clamp(round((value/ 100.0) * max_frames), 0, max_frames)
	happiness_bar.frame = frame
	
func update_skill_bar(value):
	var skill_bar = $Control/Statistics/HBoxContainer/Skill/SkillBar
	var max_frames = skill_bar.sprite_frames.get_frame_count("full_default") - 1
	var frame = clamp(round((value/ 100.0) * max_frames), 0, max_frames)
	skill_bar.frame = frame

func update_energy_bar(value):
	var energy_bar = $Control/Statistics/HBoxContainer/Energy/EnergyBar
	var max_frames = energy_bar.sprite_frames.get_frame_count("full_default") - 1
	var frame = clamp(round((value/ 100.0) * max_frames), 0, max_frames)
	energy_bar.frame = frame
