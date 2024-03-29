extends Event

var file

var player: Character
var portal_gun: Node

func start():
	file = preload("res://dialogues/TutorialDialogues.tres")
	if not is_ever_used:
		player = get_parent().get_parent().get_node("Objects/Player")
		portal_gun = player.get_node("Portalgun")
		player.remove_child(portal_gun)

func give_portal_gun():
	player.add_child(portal_gun)

func activate(body):
	if not is_ever_used and body == player:
		is_ever_used = true
		activated = true
		var room = get_parent().get_parent()
		DialogueManager.game_states = [self, room, player]
		DialogueManager.show_example_dialogue_balloon("Portals", file)

func finished_dialogue():
	get_parent().get_parent().open_doors()
	get_node("/root/AudioManager").add_effect("res://assets/audio/42972454_door-opening-05.mp3", 0.0, 1.0, false)
