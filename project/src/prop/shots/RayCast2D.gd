extends RayCast2D

var is_casting := false setget set_is_casting
var cast_point = Vector2.ZERO

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	add_exception(get_parent().get_parent())
	add_exception(get_parent().get_parent().get_parent().get_parent().get_node("CollisionVertivals"))
	add_exception(get_parent().get_parent().get_parent().get_parent().get_node("CollisionHorizontals"))

func play_laser():
	self.is_casting = true

func _physics_process(delta: float):
	cast_point = cast_to
	force_raycast_update()

	if is_colliding():
		if get_collider().is_in_group("IgnoreRaycast"):
			add_exception(get_collider())
		cast_point = to_local(get_collision_point())
		
	$Line2D.points[1] = cast_point

func set_is_casting(cast: bool):
		is_casting = cast
		
		if is_casting:
			appear()
		else:
			disappear()
		
		set_physics_process(is_casting)

func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.2)
	$Tween.start()

func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.1)
	$Tween.start()
