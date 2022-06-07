extends GridContainer

var slots: Array
var enabled_slots: int
var active_slot: int = 0

func _ready():
	slots = get_children()
	var cont = 0
	for s in slots:
		if s.is_enabled:
			cont += 1

func enable(num: int):
	num = num if num <= 6 else 6
	num = num if num >= 1 else 1
	enabled_slots = num
	for i in range(0, num):
		slots[i].enable()
	for i in range(num, slots.size()):
		slots[i].disable()

func add_slot():
	if enabled_slots < 6:
		slots[enabled_slots].enable()
		enabled_slots += 1

func next():
	slots[active_slot].deactivate()
	active_slot = (active_slot + 1) % enabled_slots
	slots[active_slot].activate()
	return slots[active_slot]

func prev():
	slots[active_slot].deactivate()
	var i = (active_slot - 1) % enabled_slots
	active_slot = i if i >= 0 else enabled_slots - 1
	slots[active_slot].activate()
	return slots[active_slot]

func select(s: int):
	if s < enabled_slots:
		slots[active_slot].deactivate()
		active_slot = s
		slots[active_slot].activate()
