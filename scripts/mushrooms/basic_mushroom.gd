extends CharacterBody2D
class_name BasicMushroom

#Signals
signal kill_mushroom()

# Configurable vars
@export var can_melle_attack = false
@export var can_ranged_attack = false
@export var hp = 100
@export var damage = 10
@export var speed: Autoload.SPEEDS = Autoload.SPEEDS.FAST
@export var animated_sprite: AnimatedSprite2D
@export var navigator: NavigationAgent2D
@export var attack_timer: Timer
@export var path_update_timer: Timer
@export var HP_label: Label
@export var hitbox: Area2D
@export var collision: CollisionShape2D

# Non configurable vars
var player: CharacterBody2D
var can_damage_player = false
var can_damage_box = false
var dead = false
var damaging_box: StaticBody2D
var changed_speed = false

func _ready() -> void:
	animated_sprite.animation = "default"
	animated_sprite.play()
	player = get_parent().get_parent().get_node("Player")
	navigator.target_position = player.global_position
	hitbox.area_entered.connect(_on_area_2d_area_entered)
	hitbox.area_exited.connect(_on_area_2d_area_exited)
	navigator.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
	navigator.path_desired_distance = 3.0
	navigator.target_desired_distance = 3.0
	navigator.path_max_distance = 100.0

func _physics_process(delta: float) -> void:
	if !navigator.is_target_reached():
		var nav_point_direction = to_local(navigator.get_next_path_position()).normalized()
		velocity = nav_point_direction * speed * delta
	
		move_and_slide()

func _process(_delta: float) -> void:
	if hp == null:
		hp = 100
	if path_update_timer.time_left == 0.0 and not dead:
		if navigator.target_position != player.global_position:
			navigator.target_position = player.global_position
		path_update_timer.start()

	HP_label.text = "HP: " + str(hp)

	if hp <= 0:
		animated_sprite.animation = "dead"
		if collision != null:
			Autoload.data.kills = Autoload.data.kills + 1
			print(Autoload.data.kills)
			Autoload.save_data()
			Autoload.add_trophey(0)
			if int(Autoload.data.kills) == 15:
				Autoload.add_trophey(1)
			elif int(Autoload.data.kills) == 100:
				Autoload.add_trophey(7)
			collision.queue_free()
			can_damage_player = false
			can_damage_box = false
		dead = true
		speed = Autoload.SPEEDS.STOPPED
		HP_label.text = ""

	elif hp <= 30:
		animated_sprite.animation = "bad"
		if speed == Autoload.SPEEDS.SLOW and not changed_speed:
			changed_speed = true
			speed = Autoload.SPEEDS.VERY_SLOW
		elif speed == Autoload.SPEEDS.FAST and not changed_speed:
			changed_speed = true
			speed = Autoload.SPEEDS.SLOW
		elif speed == Autoload.SPEEDS.QUICK and not changed_speed:
			changed_speed = true
			speed = Autoload.SPEEDS.FAST
	
	if attack_timer.time_left == 0.0 and can_damage_player and can_melle_attack:
		player.attack(damage)
		attack_timer.start()
		if len(Input.get_connected_joypads()) != 0:
			Input.start_joy_vibration(0, 0.5, 0.1, 0.2)
	elif attack_timer.time_left == 0.0 and can_damage_box and can_melle_attack:
		damaging_box.attack(damage)
		attack_timer.start()
		
	if can_ranged_attack and attack_timer.time_left == 0.0 and not dead:
		ranged_attack()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name.to_lower() == "player" and not dead:
		print("[" + self.name + "]: Player Exited")
		can_damage_player = false
	if area.get_parent().get_node_or_null("I_AM_BOX") != null:
		can_damage_box = false
		damaging_box = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name.to_lower() == "player" and not dead:
		print("[" + self.name + "]: Player Entered")
		can_damage_player = true
	if area.get_parent().get_node_or_null("I_AM_BOX") != null:
		can_damage_box = true
		damaging_box = area.get_parent()

func heal(heal_points: int):
	hp += heal_points

func attack(damage: int):
	hp -= damage

func ranged_attack():
	pass
