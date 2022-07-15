extends Resource
class_name Level

export(int) var start_room
export(int) var boss_room

export(Array, PackedScene) var rooms

func get_rooms():
	return rooms

func get_first_room() -> int:
	return start_room

func get_boss_room() -> int:
	return boss_room

func check_level():
	pass
