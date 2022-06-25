extends HBoxContainer

export var mana_full = preload("res://assets/mana_pieno.png")
export var mana_empty = preload("res://assets/mana_vuoto.png")
export var current_point_of_mana: int = 0

var assistant

func set_player(p: Node2D) -> void:
	assistant = p
	assistant.connect("mana_changed", self, "_change_mana_bar")

func _add_mana() -> void:
	var i = 0
	var n = get_child_count() # number of actual children
	while(i < assistant.get_mana() - n):
		var mana_i = TextureRect.new()
		add_child(mana_i)
		mana_i.texture = mana_full
		i += 1
	
	current_point_of_mana += i - 1

func _change_mana_bar(old_mana: int, new_mana: int) -> void:
	if get_child_count() != 0:
		if new_mana > old_mana:
			_gain_mana(old_mana, new_mana)
		else:
			_lose_mana(old_mana, new_mana)
	else:
		_add_mana()

func _gain_mana(old_mana: int, new_mana: int) -> void:
	while(new_mana > old_mana):
		current_point_of_mana += 1
		if current_point_of_mana == get_child_count():
			_add_mana()
			old_mana = new_mana
		else:
			var magic = get_child(current_point_of_mana)
			magic.texture = mana_full
		old_mana += 1

func _lose_mana(old_mana: int, new_mana: int) -> void:
	while(old_mana > new_mana):
		var magic = get_child(current_point_of_mana)
		magic.texture = mana_empty
		current_point_of_mana -= 1
		old_mana -= 1
