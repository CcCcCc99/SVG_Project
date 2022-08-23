extends CenterContainer

export var slot_number: int
var current_cost: int = 0
var debug_icon = "res://assets/sprites/blower/SummonIcon.tres"

func _ready():
	$Slots.enable(slot_number)
	var icon = load(debug_icon)
	var p = Panel.new()
	p.set("custom_styles/panel", icon)
	$Slots/Slot0.set_content(p)


func _input(event: InputEvent):
	if event.is_action_pressed("action_bar_left"):
		$Slots.prev()
	if event.is_action_pressed("action_bar_right"):
		$Slots.next()
	
	if event is InputEventKey:
		var key = event.scancode
		if key >= KEY_1 and key <= KEY_6:
			$Slots.select(key-KEY_1)


func set_num(num):
	slot_number = num
	$Slots.enable(slot_number)

func get_num():
	return slot_number

func set_slot(t: Texture):
	$Slots.set_current(t)

func current() -> int:
	return $Slots.active_slot

func get_grafic_array():
	return $Slots.get_all()
