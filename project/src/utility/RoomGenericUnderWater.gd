extends Room2D

export var suit: PackedScene
var suit_instance

func start_events():
	.start_events()
	suit_instance = suit.instance()
	$Objects.get_node("Player").add_child(suit_instance)

func _on_Portal_body_entered(body):
	suit_instance.remove()
