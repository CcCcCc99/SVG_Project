extends Event

var angel1
var angel2

func _ready():
	angel1 = get_parent().get_parent().get_node("Objects/AngelBit")
	angel2 = get_parent().get_parent().get_node("Objects/AngelBit2")
	angel1.connect("killed", self, "rage2")
	angel2.connect("killed", self, "rage1")

func rage1():
	if is_instance_valid(angel1):
		angel1.rage()

func rage2():
	if is_instance_valid(angel2):
		angel2.rage()

