extends AnimatedSprite

var prism: AnimatedSprite
var lever: AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	prism = get_parent().get_node("AnimatedSprite")
	lever = get_parent().get_parent().get_node("Lever/AnimatedSprite2")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var displacement: Vector2 = prism.position
	visible = prism.is_visible_in_tree()
	position = displacement - Vector2(65,-10)
	frame = lever.frame

