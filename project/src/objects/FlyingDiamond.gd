extends Node

onready var player: Character = get_parent()
onready var skin_animator = get_parent().get_node("AnimatedSprite")
onready var sprite_offsest = skin_animator.position.y

var default_skin
export var skin: Resource

func _ready():
	default_skin = skin_animator.frames
	skin_animator.frames = skin
	player.can_fly = true
	skin_animator.position.y = -150
	player.get_node("Hitbox").position.y = -30
	player.connect("is_dead", self, "remove")

var i = 0
func _physics_process(delta):
	i += 0.1
	skin_animator.position.y += sin(i)
	player.get_node("Hitbox").position.y += sin(i)

func remove(var_to_ignore):
	skin_animator.position.y = sprite_offsest
	player.get_node("Hitbox").position.y = 0
	skin_animator.frames = default_skin
	player.can_fly = false
	queue_free()
