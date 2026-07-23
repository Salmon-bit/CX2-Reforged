extends BasicMushroom

var is_sniping = false
var timer_started = false
@onready var rc = $RayCast2D
@export var arrow_speed = 3000

func before_tick():
	if dead:
		self.speed = Autoload.SPEEDS.STOPPED
		player.unlock()

func after_tick():
	if is_sniping and not dead:
		self.speed = Autoload.SPEEDS.STOPPED
		# Визуальный луч для отладки
		#$Line2D.clear_points()
		#$Line2D.add_point(Vector2.ZERO)
		#$Line2D.add_point(to_local(player.global_position))
		
		# ... остальной код ...
		rc.target_position = to_local(player.global_position)
		rc.force_raycast_update()
		
		if rc.is_colliding() and not dead:
			var hit_object: Node2D = rc.get_collider()
			
			# Проверяем, что луч попал именно в игрока, а не в стену/тайлмап
			if hit_object.get_node_or_null("I_AM_PLAYER") != null:
				player.lock()
				if not timer_started:
					$SnipeTimer.start()
					timer_started = true
			else:
				# Если луч уперся в стену или что-то другое - разблокируем
				player.unlock()
				$SnipeTimer.stop()
				is_sniping = false
		else:
			# Если луч ни во что не попал - разблокируем
			player.unlock()
			$SnipeTimer.stop()
			is_sniping = false

	if not player.is_locked:
		if hp <= low_hp:
			self.speed = Autoload.SPEEDS.VERY_SLOW
		else:
			self.speed = Autoload.SPEEDS.SLOW

func ranged_attack():
	if target.distance_to(self.global_position) <= 300:
		is_sniping = true
		# Сразу обновляем луч, чтобы проверить видимость
		rc.target_position = to_local(target)
		rc.force_raycast_update()

func shoot():
	if not dead:
		is_sniping = false
		player.unlock()
		print("[" + self.name + "]: Shooting...")
		$ShootSound.play()
		
		var arrow: CharacterBody2D = $Spawner.spawn()
		arrow.scale *= 2
		arrow.name = "SniperArrow"

		var dir: Vector2
		dir = (player.global_position - global_position).normalized()

		arrow.rotation = dir.angle()
		arrow.velocity = dir * arrow_speed
		arrow.add_collision_exception_with(self)
		add_child(arrow)
		attack_timer.start()

func _on_snipe_timer_timeout() -> void:
	timer_started = false
	if player.is_locked and not dead:
		shoot()
