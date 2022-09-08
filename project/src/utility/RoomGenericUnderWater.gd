extends Room2D

export var suit: PackedScene
var suit_instance
var has_suit: bool = false

func start_events():
	.start_events()
	if not has_suit:
		suit_instance = suit.instance()
		$Objects.get_node("Player").add_child(suit_instance)
		has_suit = true

func _on_Portal_body_entered(body):
	suit_instance.remove()
	has_suit = false
