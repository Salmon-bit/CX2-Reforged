extends CharacterBody2D

var can_melle_attack = true
var can_ranged_attack = false
var hp = 100
var damage = 10
var speed = 10000
var dead = false
@onready var navigator: NavigationAgent2D = $NavigationAgent2D
var player: CharacterBody2D
var can_damage_player = false

func _ready() -> void:
	$Sprite.animation = "default"
	$Sprite.play()
	player = get_parent().get_parent().get_node("Player")
	navigator.target_position = player.global_position

func _physics_process(delta: float) -> void:
	if !navigator.is_target_reached():
		var nav_point_direction = to_local(navigator.get_next_path_position()).normalized()
		velocity = nav_point_direction * speed * delta
	
		move_and_slide()

func _process(_delta: float) -> void:
	if $Timer.time_left == 0.0 and not dead:
		if navigator.target_position != player.global_position:
			navigator.target_position = player.global_position
		$Timer.start()

	$Label.text = "HP: " + str(hp)

	if hp <= 0:
		$Sprite.animation = "dead"
		if get_node_or_null("CollisionShape2D") != null:
			$CollisionShape2D.queue_free()
		dead = true
		speed = 0
		$Label.text = ""

	elif hp <= 30:
		$Sprite.animation = "bad"
		speed = 5000
	
	if $DamageTimer.time_left == 0.0 and can_damage_player:
		player.hp -= damage
		$DamageTimer.start()
		if len(Input.get_connected_joypads()) != 0:
			Input.start_joy_vibration(0, 0.5, 0.1, 0.2)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name.to_lower() == "player" and not dead:
		print("[RED MUSHROOM]: Player Exited")
		can_damage_player = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name.to_lower() == "player" and not dead:
		print("[RED MUSHROOM]: Player Entered")
		can_damage_player = true

func heal(heal_points: int):
	hp += heal_points

func attack(damage: int):
	hp -= damage
