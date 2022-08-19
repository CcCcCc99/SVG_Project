extends Line2D

const hit_offset = Vector2(-14, 76)
var pos_offset = Vector2.ZERO

var segment: SegmentShape2D
var player: Character

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	$StaticBody/CollisionShape2D.shape = $StaticBody/CollisionShape2D.shape.duplicate()
	segment = $StaticBody/CollisionShape2D.shape
	_set_points()

func _set_points():
	points[0] -= pos_offset
	points[1] -= pos_offset
	segment.set_a(self.points[0] + hit_offset)
	segment.set_b(self.points[1] + hit_offset)
	print(points)

func turn_on():
	modulate = Color.white
	segment.set_b(self.points[1] + hit_offset)

func turn_off():
	modulate = Color.transparent
	segment.set_b(self.points[0] + hit_offset)