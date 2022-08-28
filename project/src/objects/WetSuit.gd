extends Node

onready var player: Character = get_parent()
onready var skin_animator = get_parent().get_node("AnimatedSprite")

var default_skin
export var skin: Resource

func _ready():
	default_skin = skin_animator.frames
	skin_animator.frames = skin

func remove():
	skin_animator.frames = default_skin
	queue_free()
