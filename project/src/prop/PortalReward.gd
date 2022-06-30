extends Area2D

export(PackedScene) var healthScene

func give_reward():
	self.visible = true
	var healthGain = healthScene.instance()
	add_child(healthGain)
