extends Character

onready var anim = $Animator

export(int) var max_mana: int
var mana: int setget set_mana, get_mana

signal mana_changed(old_mana, new_mana)

func _ready():
	set_mana(max_mana)

func _process(delta):
	._process(delta)
	if Input.is_action_just_pressed("summon"):
		print("summon ", get_viewport().get_mouse_position())
	# TODO sistemare questo scempio
	anim.animate(get_direction() * speed * delta)

func get_direction() -> Vector2:
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(horizontal,vertcal).normalized()

func set_mana(new_mana: int):
	var old_mana = get_mana()
	if old_mana != new_mana:
		mana = clamp(new_mana, 0, max_mana)
		emit_signal("mana_changed", old_mana, get_mana())

func get_mana() -> int:
	return mana

func set_max_mana(new_max_mana: int):
	max_mana = new_max_mana
	set_mana(new_max_mana)

func _on_Bat_area_entered(area):
	pass # Replace with function body.

func _on_Bat_body_entered(body):
	pass # Replace with function body.

func _on_Bat_ready():
	pass # Replace with function body.
