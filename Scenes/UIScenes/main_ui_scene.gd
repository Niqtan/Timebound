extends CanvasLayer


const MAX_BAR_WIDTH = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	update_happiness_bar()
	update_energy_bar()
	update_skill_bar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_happiness_bar():
	var happiness_bar = $Control/Statistics/HBoxContainer/Happiness/HappinessBar
	if happiness_bar.sprite_frames == null:
		print("no sprite frames!")
	
	var max_frames = happiness_bar.sprite_frames.get_frame_count("full_default") - 1
	var frame = int((Global.happiness / 100) * max_frames)
	happiness_bar.frame = frame
	
func update_skill_bar():
	var skill_bar = $Control/Statistics/HBoxContainer/Skill/SkillBar
	var max_frames = skill_bar.sprite_frames.get_frame_count("full_default") - 1
	var frame = int((Global.skill / 100) * max_frames)
	skill_bar.frame = frame

func update_energy_bar():
	var energy_bar = $Control/Statistics/HBoxContainer/Energy/EnergyBar
	var max_frames = energy_bar.sprite_frames.get_frame_count("full_default") - 1
	var frame = int((Global.energy / 100) * max_frames)
	energy_bar.frame = frame
