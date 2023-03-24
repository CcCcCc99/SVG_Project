extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const rooms_path = "res://scenes/Rooms/newRooms/"
const out_path = "res://ICON_src/rooms.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	var all_files = list_files_in_directory(rooms_path)
	var file = File.new()
	file.open(out_path, File.WRITE)
	for f in all_files:
		file.store_line(to_json(f))
	file.close()

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
