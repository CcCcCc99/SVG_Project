extends Event

func start():
	var file = preload("res://dialogues/TutorialDialogues.tres")
	
	if not is_ever_used:
		var player: Character = get_parent().get_parent().get_node("Objects/Player")
		var black_screen: CanvasItem = get_parent().get_parent().get_parent().get_node("HUD/ColorRect")
		black_screen.show()
		black_screen.modulate = Color.black
		
		var room = get_parent().get_parent()
		DialogueManager.game_states = [self, room, player]
		DialogueManager.show_example_dialogue_balloon("Presentation", file)

func finished_dialogue():
	is_ever_used = true
	activated = true
