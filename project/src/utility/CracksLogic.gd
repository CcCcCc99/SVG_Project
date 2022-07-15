extends YSort

export(PackedScene) var crack
export var max_cracks: int = 5
var crack_queue: Array

func crack_floor(pos: Vector2):
	var c = crack.instance()
	c.position = pos
	if crack_queue.size() >= max_cracks:
		var old: Node = crack_queue.pop_front()
		if is_instance_valid(old):
			old.queue_free()
	crack_queue.push_back(c)
	add_child(c)
	
