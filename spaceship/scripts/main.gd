extends Node2D

@onready var player: Node2D = $Player
@onready var asteroid: Node2D = $Asteroid
@onready var enemy: Node2D = $Enemy
@onready var enemies: Node2D = $Enemies
@onready var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
var count: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	asteroid.colided.connect(_on_player_hit)
	enemy.colided.connect(_on_player_hit)
	for i in count:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.scale = Vector2(0.5, 0.5)
		enemies.add_child(enemy_instance)
		enemy_instance.colided.connect(_on_player_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy.pursue(player.position, player.velocity)
	for child in enemies.get_children():
		child.alignment(enemies)
		#child.separate(enemies)
		
func _on_player_hit() -> void:
	player.damaged()
