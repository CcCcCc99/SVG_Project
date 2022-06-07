extends HBoxContainer

var heart_full = preload("res://assets/cuore_pieno.png")
var heart_half = preload("res://assets/cuore_a_metà.png")
var heart_empty = preload("res://assets/cuore_vuoto.png")
var current_heart

var player

func set_player(p: Character):
	player = p
	player.connect("hp_changed", self, "_change_health_bar")
	_add_hearts()

func _add_hearts() -> void:
	var i = 0
	while(i < player.hp / 2):
		var heart_i = TextureRect.new()
		add_child(heart_i)
		heart_i.texture = heart_full
		i += 1
	current_heart = i - 1

func _change_health_bar(old_hp: int, new_hp: int) -> void:
	if new_hp > 0:
		if new_hp > old_hp:
			pass # GAIN HP
		elif new_hp < old_hp:
			_lose_hp(old_hp, new_hp)
	else:
		pass # GAME OVER

func _lose_hp(old_hp: int, new_hp: int) -> void:
	while(old_hp > new_hp):
		var heart = get_child(current_heart)
		if (old_hp % 2) == 0:
			heart.texture = heart_half
		else:
			heart.texture = heart_empty
			current_heart -= 1
		old_hp -= 1
