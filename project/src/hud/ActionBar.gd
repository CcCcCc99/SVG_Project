extends CenterContainer

export var slot_number: int

func _ready():
	$Slots.enable(slot_number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_released("action_bar_left"):
		$Slots.prev()
	if Input.is_action_just_released("action_bar_right"):
		$Slots.next()
