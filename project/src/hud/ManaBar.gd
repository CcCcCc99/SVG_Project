extends HBoxContainer

var mana_full = preload("res://icon.png")
var mana_empty = preload("res://assets/portaaperta_orizzontale.png")
var current_point_of_mana: int = 0

var player

func set_player(p: Character) -> void:
	player = p
	player.connect("mana_changed", self, "_change_mana_bar")

func _add_mana() -> void:
	var i = 0
	var n = get_child_count() # number of actual children
	while(i < player.get_mana() - n):
		var mana_i = TextureRect.new()
		add_child(mana_i)
		mana_i.texture = mana_full
		i += 1
	
	current_point_of_mana += i - 1

func _change_mana_bar(old_mana: int, new_mana: int) -> void:
	if get_child_count() != 0:
		if new_mana > old_mana:
			#_gain_mana()
			pass
		else:
			#_lose_mana(old_mana, new_mana)
			pass
	else:
		_add_mana()

func _lose_mana(old_mana: int, new_mana: int) -> void:
	while(old_mana > new_mana):
		var magic = get_child(current_point_of_mana)
		magic.texture = mana_empty
		current_point_of_mana -= 1
		old_mana -= 1
