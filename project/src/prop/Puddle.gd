extends Area2D

export var suit: PackedScene
var suit_instance

func _ready():
	$Portal.deactivate_portal()

func has_wet_suit() -> bool:
	var saves: Dictionary = get_parent().get_parent().get_parent().saved_state.events
	return saves.has("1-7-WetSuitEvent")

func _on_Puddle_body_entered(body):
	if body.is_in_group("Player") and has_wet_suit():
		suit_instance = suit.instance()
		body.add_child(suit_instance)
		$Portal.activate_portal()
		if body.has_node("FlyingDiamond"):
			body.get_node("FlyingDiamond").deactivate(suit_instance.skin)

func _on_Puddle_body_exited(body):
	if body.is_in_group("Player") and has_wet_suit():
		suit_instance.remove()
		if body.has_node("FlyingDiamond"):
			body.get_node("FlyingDiamond").reactivate()
