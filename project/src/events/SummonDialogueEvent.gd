extends Event

var file

# Called when the node enters the scene tree for the first time.
func _ready():
	file = preload("res://dialogues/TutorialDialogues.tres")

func activate():
	if not is_ever_used:
		is_ever_used = true
		activated = true
		DialogueManager.show_example_dialogue_balloon("Summon", file)
