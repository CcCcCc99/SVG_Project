extends Node2D

export(PackedScene) var healthScene
export(PackedScene) var manaScene

export var number_of_hearts: int = 1
export var number_of_mana: int = 1

func _ready():
	get_parent().get_parent().connect("completed", self, "give_reward")

func give_reward():
	if number_of_hearts > 0 or number_of_mana > 0:
		self.visible = true
	for i in range(number_of_hearts):
		var healthGain = healthScene.instance()
		add_child(healthGain)
	for i in range(number_of_mana):
		var manaGain = manaScene.instance()
		add_child(manaGain)
