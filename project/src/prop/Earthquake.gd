extends Area2D

export var expand_rate: float = 0.01
export var aoe_damage = 3

func _ready():
	scale = Vector2(0.1,0.1)

func _physics_process(delta):
	scale.x += expand_rate
	scale.y += expand_rate

func _on_Earthquake_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(aoe_damage)
