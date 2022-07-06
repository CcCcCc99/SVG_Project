extends Panel

#export var current: int
#export var new: int

# Called when the node enters the scene tree for the first time.
#func _ready():
#	update_info(current, new)

func update_info(current: int, new: int):
	if current == 0:
		$CurrentCost.text = ""
	else:
		$CurrentCost.text = str(current)
	$NewCost.text = str(new)
	if current == 0:
		$Frame.modulate = Color.blue
	elif current == new:
		$Frame.modulate = Color.white
	elif current > new:
		$Frame.modulate = Color.green
	else:
		$Frame.modulate = Color.red
