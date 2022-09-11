extends Event

func start():
	var file = preload("res://dialogues/Lv1Dialogues.tres")
	
	if not is_ever_used:
		DialogueManager.game_states = [self]
		DialogueManager.show_example_dialogue_balloon("Pond", file)

func finished_dialogue():
	is_ever_used = true
	activated = true
