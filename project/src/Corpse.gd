extends Area2D

var summon: String setget set_summon

func set_summon(sum):
	summon = sum

func _on_Corpse_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("teke_soul"):
			$Shadow.hide()
			get_tree().root.get_child(0).load_summon(summon)
