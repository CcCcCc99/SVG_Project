extends Area2D

export var summon: String
export var cost: int
var is_soul_taken: bool = false

func _on_Corpse_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("teke_soul") and not is_soul_taken:
			$Shadow.hide()
			is_soul_taken = true
			get_tree().root.get_child(0).load_summon(summon, cost)
