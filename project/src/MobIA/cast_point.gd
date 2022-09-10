extends CollisionShape2D

var ray
var hit_shape: RayShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ray = get_parent().get_node("RayCast2D")
	hit_shape = shape

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var cast: Vector2 = ray.cast_point
	hit_shape.length = cast.length() + 70
