extends Control

# Variables
var timer = 2
var particle: CPUParticles2D = null
var logo: Sprite2D = null
var mp = 1
var rotate_deg = 0.5


func _ready() -> void:
	particle = $CPUParticles2D
	particle.emitting = true
	logo = $Logo
	logo.rotation = 0.01
	
	Autoload.load_data()


func _process(delta: float) -> void:
	# Emit random sprites
	timer -= delta
	if timer <= 0:
		timer = 1.5
		var sprites = $Sprites.get_children()
		var new_texture = sprites[randi_range(0, len(sprites) - 1)].texture
		particle.texture = new_texture
		particle.emitting = true
	
	# Rotate Logo
	logo.rotation += rotate_deg * delta
	if logo.rotation >= 0.3 or logo.rotation <= -0.3:
		rotate_deg *= -1

# Buttons Callback
func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	Autoload.click()
	get_tree().change_scene_to_file("res://scenes/ui/settings_scene.tscn")
