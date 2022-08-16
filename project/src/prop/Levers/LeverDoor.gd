extends Lever

var event

func _ready():
	event = get_parent().get_parent().get_node("Events/LeverEvent")

func _activate():
	# activate coils
	event.activated = true

func _deactivate():
	# deactivate coils
	event.is_ever_used = true
	event.activated = false
