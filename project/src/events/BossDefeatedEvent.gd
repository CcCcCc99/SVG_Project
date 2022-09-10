extends Event

export var file_path: String
var file

export(Array, String) var boss_names
var boss: Array
onready var portal: Node = get_parent().get_parent().get_node("Objects/GotoNextLvl")

export var hp_up: int
export var mp_up: int
export var slot_up: bool

func _ready():
	file = load(file_path)
	for name in boss_names:
		 boss.append(get_parent().get_parent().get_node("Objects/" + name))

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
		for b in boss:
			if is_instance_valid(b):
				b.queue_free()
		portal.activate_portal()
