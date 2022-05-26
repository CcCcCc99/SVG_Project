extends Character
class_name Mob

# Array of points to the player
var path: PoolVector2Array

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Tutorial")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var path_timer: Timer = get_node("PathTimer")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var vector_to_next_point: Vector2 = Vector2.ZERO

#func _ready() -> void:
	#var __ = connect("tree_exited", get_parent(), "_on_enemy_killed")


func chase() -> void:
	# if the path is not empty
	if path:
		vector_to_next_point = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		# change the number for changing the velocity of the enemy
		if distance_to_next_point < 1:
			path.remove(0)
			if not path:
				return
		
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			 animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

func get_direction() -> Vector2:
	return vector_to_next_point

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		path_timer.stop()
		path = []
		vector_to_next_point = Vector2.ZERO
		
		
func _get_path_to_player() -> void:
	# calculation of the minimum path between the enemy and the player
	path = navigation.get_simple_path(global_position, player.position)
