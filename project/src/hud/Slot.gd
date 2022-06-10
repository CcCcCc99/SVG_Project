extends Panel

export var is_active: bool
export var is_enabled: bool

func _ready():
	_set_color()
	if is_enabled:
		show()

func enable():
	is_enabled = true
	show()

func disable():
	is_enabled = false
	#_free_summon()
	hide()

func activate():
	is_active = true
	_set_color()

func deactivate():
	is_active = false
	_set_color()

func set_content(summon: Panel):
	#_free_summon()
	print(summon)
	add_child(summon)

func _free_summon():
	for i in get_children():
		i.queue_free()

func _set_color():
	var col
	if is_active:
		col = Color.white
	else:
		col = Color.darkgray
	$Frame.modulate = col
