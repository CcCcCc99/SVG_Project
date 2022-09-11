extends Event

export var stand_name: String
var stand: Node
var file

func _ready():
	stand = get_parent().get_parent().get_node("Objects/"+stand_name)
	file = preload("res://dialogues/Lv1Dialogues.tres")

func activate():
	if not is_ever_used:
		DialogueManager.show_example_dialogue_balloon("WetSuit", file)
		is_ever_used = true
		activated = false

func load_event(status: bool):
	.load_event(status)
	if not activated:
		stand.remove_object()
