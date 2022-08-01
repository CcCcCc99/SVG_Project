extends Reference
class_name summon

var scene: String
var mob: Mob = null
var mana_cost: int
var summoned: bool

signal reset

func _init(s, c):
	scene = s
	reset()
	mana_cost = c
	summoned = false
	
func reset():
	if is_instance_valid(mob):
		mob.queue_free()
	summoned = false
	var loaded_scene = load(scene)
	if is_instance_valid(loaded_scene):
		mob = loaded_scene.instance()
		mob.modulate = Color.darkblue
		mob.get_node("Shadow").hide()
		mob.connect("killed", self, "reset")
		emit_signal("reset")

func spawn(parent: Node, pos: Vector2) -> bool:
	if summoned:
		return false
	summoned = true
	mob.is_summoned = true
	mob.position = pos
	parent.add_child(mob)
	return true

func get_icon():
	return mob.icon
