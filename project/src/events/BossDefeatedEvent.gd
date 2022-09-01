extends Event

onready var file = preload("res://dialogues/TutorialDialogues.tres")

export var boss_name: String
onready var boss: Node = get_parent().get_parent().get_node("Objects/"+boss_name)
onready var portal: Node = get_parent().get_parent().get_node("Objects/GotoNextLvl")

export var hp_up: int
export var mp_up: int
export var slot_up: bool

func start():
	if not activated:
		portal.hide()
		portal.get_node("CollisionShape2D").disabled = true

func activate():
	is_ever_used = true
	activated = true
	portal.show()
	portal.get_node("CollisionShape2D").disabled = false
	
	var player = get_parent().get_parent().get_node("Objects/Player")
	var assistant = get_parent().get_parent().get_node("Objects/Assistant")
	
	player.set_max_hp(player.max_hp + hp_up)
	assistant.set_max_mana(assistant.max_mana + mp_up)
	assistant.add_slot()
	
	
	
	DialogueManager.game_states = [portal]
	DialogueManager.show_example_dialogue_balloon("Boss", file)

func load_event(status: bool):
	.load_event(status)
	if is_ever_used:
		if is_instance_valid(boss):
			boss.queue_free()
		portal.activate_portal()
