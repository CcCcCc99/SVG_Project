extends Event

export var lever_name: String
var lever: Lever

# Called when the node enters the scene tree for the first time.
func _ready():
	var lever_path = "Objects/" + lever_name
	lever = get_parent().get_parent().get_node(lever_path)

func load_event(status: bool):
	.load_event(status)
	lever.is_on = status
