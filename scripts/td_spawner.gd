extends Node2D

@export var mushrooms: Array[PackedScene]
@export var spawn_delay: float
@export var hardmode_mushrooms: Array[PackedScene]
@onready var sprite = $Sprite2D
@onready var spawn_sound = $AudioStreamPlayer
@onready var timer = $Timer
var hp = 1

func _ready():
	sprite.hide()
	if Autoload.data.difficulty == 'hard':
		mushrooms += hardmode_mushrooms
	
var time = 0.0
var spawning = false
func _process(delta: float):
	time += delta
	if time >= spawn_delay and not spawning:
		sprite.show()
		spawn_sound.play()
		timer.start()
		spawning = true

var index = 0
func spawn():
	if index < len(mushrooms):
		var spawnling: CharacterBody2D = mushrooms[index].instantiate()
			
		spawnling.position.x = self.position.x
		spawnling.position.y = self.position.y
		
		get_parent().add_child(spawnling)
	else:
		queue_free()

func _on_timer_timeout() -> void:
	if spawning:
		spawn()
		index += 1
