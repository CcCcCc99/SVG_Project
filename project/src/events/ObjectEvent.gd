extends Event

export var stand_name: String
var stand: Node

func _ready():
	stand = get_parent().get_parent().get_node("Objects/"+stand_name)
	print(stand)

func activate():
	is_ever_used = true
	activated = false

func load_event(status: bool):
	.load_event(status)
	if not activated:
		stand.remove_object()
