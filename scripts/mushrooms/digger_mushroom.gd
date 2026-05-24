extends CharacterBody2D


var hp = 750
var speed = Autoload.SPEEDS.SLOW
var second_phase = false
var damage = 15
var low_hp = 150
var dead = false
var player: CharacterBody2D = null
var showing_secret = false
var can_show_secret = true
var dead_flag = false
var flag = false

@onready var damage_timer = $DamageTimer
@onready var grave_timer = $GraveTimer
@onready var navigator = $NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var secret_timer = $SecretTimer
@onready var path_update_timer = $PathUpdateTimer
@onready var hp_label = $Label
@onready var grave_spawner = $GraveSpawner
@onready var bullet_spawner = $BulletSpawner

@export var projectile_speed = 550
@export var mushrooms: Array[PackedScene]

func _ready() -> void:
	animated_sprite.animation = "default"
	animated_sprite.play()
	player = get_parent().get_parent().get_node("Player")
	navigator.target_position = player.global_position
	navigator.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
	navigator.path_desired_distance = 3.0
	navigator.target_desired_distance = 3.0
	navigator.path_max_distance = 100.0

func _physics_process(delta: float) -> void:
	if !navigator.is_target_reached() and not dead:
		var nav_point_direction = to_local(navigator.get_next_path_position()).normalized()
		velocity = nav_point_direction * speed * delta
	
		move_and_slide()

func _process(_delta: float) -> void:
	if dead and not ((showing_secret and secret_timer.time_left == 0.0 and can_show_secret) or (showing_secret and secret_timer.time_left == 0.0 and secret_timer.wait_time == 2 and can_show_secret)):
		Autoload.add_trophey(2)
		animated_sprite.play("dead")
		hp_label.text = ""
		if not dead_flag:
			$CollisionShape2D.queue_free()
			Autoload.data.kills = Autoload.data.kills + 1
			print(Autoload.data.kills)
			Autoload.save_data()
			Autoload.add_trophey(0)
			if int(Autoload.data.kills) == 15:
				Autoload.add_trophey(1)
			elif int(Autoload.data.kills) == 100:
				Autoload.add_trophey(7)
			elif int(Autoload.data.kills) == 1000:
				Autoload.add_trophey(11)
			dead_flag = true
	elif showing_secret and secret_timer.time_left == 0.0 and can_show_secret and dead:
		animated_sprite.play("secret")
		$Timer.start()
		hp_label.text = ""
		if not dead_flag:
			$CollisionShape2D.queue_free()
			Autoload.data.kills = Autoload.data.kills + 1
			print(Autoload.data.kills)
			Autoload.save_data()
			Autoload.add_trophey(0)
			if int(Autoload.data.kills) == 15:
				Autoload.add_trophey(1)
			elif int(Autoload.data.kills) == 100:
				Autoload.add_trophey(7)
			elif int(Autoload.data.kills) == 1000:
				Autoload.add_trophey(11)
			dead_flag = true
	elif showing_secret and flag and can_show_secret and dead:
		animated_sprite.play("dead")
		can_show_secret = false
		hp_label.text = ""
		if not dead_flag:
			$CollisionShape2D.queue_free()
			Autoload.data.kills = Autoload.data.kills + 1
			print(Autoload.data.kills)
			Autoload.save_data()
			Autoload.add_trophey(0)
			if int(Autoload.data.kills) == 15:
				Autoload.add_trophey(1)
			elif int(Autoload.data.kills) == 100:
				Autoload.add_trophey(7)
			elif int(Autoload.data.kills) == 1000:
				Autoload.add_trophey(11)
			dead_flag = true
		showing_secret = false
		flag = false
		return
	else:
		if hp <= 0:
			dead = true
		if hp <= low_hp and not second_phase:
			animated_sprite.play("bad")
			damage = 25
			speed = Autoload.SPEEDS.FAST
			second_phase = true
			damage_timer.wait_time = 1.5
			grave_timer.wait_time = 3.5
		
		hp_label.text =  "HP: " + str(hp)
	
	if path_update_timer.time_left == 0.0 and not dead:
			if navigator.target_position != player.global_position:
				navigator.target_position = player.global_position
			path_update_timer.start()
	
	if damage_timer.time_left == 0.0 and not dead:
		ranged_attack()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if dead and area.get_parent().name == "Player":
		showing_secret = true
		secret_timer.start()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if dead and area.get_parent().name == "Player":
		showing_secret = false
		secret_timer.stop()

func heal(heal_points):
	hp += heal_points

func attack(damage_points):
	hp -= damage_points

func _on_timer_timeout() -> void:
	flag = true

func ranged_attack():
	var arrow: CharacterBody2D = bullet_spawner.spawn()

	var dir: Vector2
	dir = (player.global_position - global_position).normalized()

	arrow.rotation = dir.angle()
	arrow.velocity = dir * projectile_speed
	arrow.add_collision_exception_with(self)
	add_child(arrow)
	damage_timer.start()


func _on_grave_timer_timeout() -> void:
	if not dead:
		var grave: StaticBody2D = grave_spawner.spawn()
		grave.mushrooms = self.mushrooms
		grave.global_position = self.global_position
		
		get_parent().add_child(grave)
