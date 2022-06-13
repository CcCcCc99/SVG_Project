extends HBoxContainer

var heart_full = preload("res://assets/cuore_pieno.png")
var heart_half = preload("res://assets/cuore_a_metà.png")
var heart_empty = preload("res://assets/cuore_vuoto.png")
var current_heart: int = 0

var player

#func _process(delta):
	#if Input.is_action_just_pressed("ui_left"):
		#player.set_hp(player.get_hp() + 1)
	#if Input.is_action_just_pressed("ui_right"):
		#player.set_hp(player.get_hp() - 1)
	#if Input.is_action_just_pressed("ui_up"):
		#player.set_max_hp(player.max_hp + 2)

func set_player(p: Character) -> void:
	player = p
	player.connect("hp_changed", self, "_change_health_bar")

func _add_hearts() -> void:
	var i = 0
	var n = get_child_count() # number of actual children
	while(i < (player.get_hp() / 2) - n):
		var heart_i = TextureRect.new()
		add_child(heart_i)
		heart_i.texture = heart_full
		i += 1
	
	current_heart += i - 1

func _change_health_bar(old_hp: int, new_hp: int) -> void:
	if get_child_count() != 0:
		if new_hp > old_hp:
			_gain_hp(old_hp, new_hp)
		else:
			_lose_hp(old_hp, new_hp)
	else:
		_add_hearts()

func _gain_hp(old_hp: int, new_hp: int) -> void:
	while(new_hp > old_hp):
		if (old_hp % 2) == 0:
			current_heart += 1
			if current_heart == get_child_count():
				_add_hearts()
				old_hp = new_hp
			else:
				var heart = get_child(current_heart)
				heart.texture = heart_half
		else:
			var heart = get_child(current_heart)
			heart.texture = heart_full
		old_hp += 1

func _lose_hp(old_hp: int, new_hp: int) -> void:
	while(old_hp > new_hp):
		var heart = get_child(current_heart)
		if (old_hp % 2) == 0:
			heart.texture = heart_half
		else:
			heart.texture = heart_empty
			current_heart -= 1
		old_hp -= 1
