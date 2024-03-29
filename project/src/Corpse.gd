extends Area2D

export var summon: String
export var cost: int
export var info: PackedScene

var is_soul_taken: bool = false
var info_panel: Panel
var assistant: Node

func _ready():
	info_panel = info.instance()
	info_panel.hide()
	assistant = get_parent().get_node("Assistant")
	add_child(info_panel)
	move_child($CollisionShape2D, 3)

func _on_Corpse_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		if not is_soul_taken:
			info_panel.set_global_position(get_global_mouse_position() + Vector2(5,-65))
	#if event is InputEventMouseButton:
	if event.is_action_pressed("summon") and not is_soul_taken:
		$Shadow.hide()
		is_soul_taken = true
		assistant.is_inspecting = false
		get_tree().root.get_node("Main").load_summon(summon, cost)

func _on_Corpse_mouse_entered():
	if not is_soul_taken:
		assistant.is_inspecting = true
		info_panel.update_info(get_tree().root.get_node("Main").get_cost(), cost)
		info_panel.show()

func _on_Corpse_mouse_exited():
	assistant.is_inspecting = false
	info_panel.hide()
