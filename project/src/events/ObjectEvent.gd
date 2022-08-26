extends Event

export var stand_name: String
var stand: Node

func start():
	stand = get_parent().get_parent().get_node("Objects/"+stand_name)

func activate():
	is_ever_used = true
	activated = true

func load_event(status: bool):
	.load_event(status)
	if not activated:
		stand.remove_object()
