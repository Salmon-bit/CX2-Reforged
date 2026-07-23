extends CharacterBody2D

const SPEED = 20000.0

var bow: Node2D
var shoot_delay = 0.0
var ability_delay = 0.0
var arrow_speed = 600
var hp = 100
var dead = false
var ability_spawner: Node2D
var is_locked = false
@export var ability_reload_time: float = 5

func _ready() -> void:
	
	var mushrooms: Array = get_parent().get_node("Enemies").get_children()
	
	for m in mushrooms:
		m.player = self
	
	if Autoload.data.difficulty == "easy":
		hp = 300
	elif Autoload.data.difficulty == "hard":
		hp = 80
	
	match Autoload.data.ability - 1:
		0.0:
			ability_spawner = $AbilitySpawners/Golden
		1.0:
			ability_spawner = $AbilitySpawners/Through
		-1.0:
			ability_spawner = null
	
	ability_delay = ability_reload_time
	
	
	
	bow = $Bow

func _process(delta: float) -> void:
	ability_delay += delta
	if ability_delay >= ability_reload_time:
		bow.can_use_ability = true
	$Label.text = "HP: " + str(hp)
	
	if hp > 100 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(0, 255, 255))
	elif hp <= 0:
		Autoload.add_trophey(4)
		Autoload.data.deaths = Autoload.data.deaths + 1
		Autoload.save_data()
		if get_node_or_null("AnimatedSprite2D") != null:
			$AnimatedSprite2D.queue_free()
		if get_node_or_null("Bow/AnimatedSprite2D") != null:
			$Bow/AnimatedSprite2D.queue_free()
		if not get_tree().current_scene.get_node("CanvasLayer").get_node("TropheyManager").showing_trophey:
			get_tree().reload_current_scene()
		$Label.text = ""
		dead = true
	elif hp <= 20 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(255, 0, 0))
	elif hp <= 50 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(255, 255, 0))
	elif hp <= 100 and len(Input.get_connected_joypads()):
		Input.set_joy_light(0, Color(0, 255, 0))
	
	if Input.is_action_just_pressed("go_back_to_level_select"):
		get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")

func _physics_process(delta: float) -> void:
	var direction_x := Input.get_axis("go_left", "go_right")
	var direction_y := Input.get_axis("go_up", "go_down")

	if direction_x and not dead:
		velocity.x = direction_x * SPEED * delta
	elif not direction_x and not dead:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y and not dead:
		velocity.y = direction_y * SPEED * delta
	elif not direction_y and not dead:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

	# Правый стик контроллера
	var stick := Vector2(
		Input.get_axis("bow_left", "bow_right"),
		Input.get_axis("bow_up", "bow_down")
	)

	var using_controller := stick.length() > 0.2  # deadzone
	
	if using_controller:
		bow.look_at(bow.global_position + stick)
	else:
		bow.look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot"):
		shoot_delay -= delta
		if shoot_delay <= 0:
			var arrow: CharacterBody2D = $Spawner.spawn()

			var dir: Vector2
			if using_controller:
				dir = stick.normalized()
			else:
				dir = (get_global_mouse_position() - global_position).normalized()
			
			arrow.global_position = global_position + dir * 50.0
			arrow.rotation = dir.angle()
			arrow.velocity = dir * arrow_speed
			arrow.add_collision_exception_with(self)
			get_tree().current_scene.add_child(arrow)
			$Sounds/ShootSound.play()
			
			shoot_delay = 0.15
	if Input.is_action_just_pressed("use_ability"):
		if ability_delay >= ability_reload_time:
			if ability_spawner != null:
				var ability_arrow = ability_spawner.spawn()
				
				var dir: Vector2
				if using_controller:
					dir = stick.normalized()
				else:
					dir = (get_global_mouse_position() - global_position).normalized()
				
				ability_arrow.global_position = global_position + dir * 50.0
				ability_arrow.rotation = dir.angle()
				ability_arrow.velocity = dir * arrow_speed * ability_arrow.vel_multiplayer
				ability_arrow.add_collision_exception_with(self)
				get_tree().current_scene.add_child(ability_arrow)
				$Sounds/ShootSound.play()
				ability_delay = 0
				bow.can_use_ability = false

	if Input.is_action_just_released("shoot"):
		shoot_delay = 0

func heal(heal_points: int):
	$Sounds/Heal.play()
	hp += heal_points

func attack(damage_points: int):
	if not dead:
		$Sounds/Damage.play()
	hp -= damage_points
	if len(Input.get_connected_joypads()) != 0:
			Input.start_joy_vibration(0, 0.5, 0.1, 0.2)

func lock():
	if not is_locked:
		$Sounds/SniperLock.play()
	is_locked = true
	$Sprite2D.show()

func unlock():
	if is_locked:
		$Sounds/SniperUnlock.play()
	is_locked = false
	$Sprite2D.hide()
