extends Line2D

const offset = Vector2(-14, 76)
var segment: SegmentShape2D 

# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody/CollisionShape2D.shape = $StaticBody/CollisionShape2D.shape.duplicate()
	segment = $StaticBody/CollisionShape2D.shape
	segment.set_a(self.points[0] + offset)
	segment.set_b(self.points[1] + offset)


func turn_on():
	modulate = Color.white
	segment.set_b(self.points[1] + offset)

func turn_off():
	modulate = Color.transparent
	segment.set_b(self.points[0] + offset)
