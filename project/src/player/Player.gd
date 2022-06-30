extends Character

onready var anim = $Animator

var checkpoint_position: Vector2 = Vector2(0, 0)
var checkpoint_room: int = 0

signal hp_changed(old_hp, new_hp)
signal is_dead

func _process(delta):
	._process(delta)
	# TODO sistemare questo scempio
	anim.animate(get_direction() * speed * delta)

func set_hp(new_hp: int):
	var old_hp = get_hp()
	if old_hp != new_hp:
		.set_hp(new_hp)
		emit_signal("hp_changed", old_hp, get_hp())
		if hp == 0:
			emit_signal("is_dead")

func set_max_hp(new_max_hp: int):
	max_hp = new_max_hp
	set_hp(new_max_hp)

func set_checkpoint(checkpoint: Vector2, room: int) -> void:
	if checkpoint_position != checkpoint or checkpoint_room != room:
		checkpoint_position = checkpoint
		checkpoint_room = room

func get_direction() -> Vector2:
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(horizontal,vertcal).normalized()

func destroy_portals():
	$Portalgun.destroy_all()
