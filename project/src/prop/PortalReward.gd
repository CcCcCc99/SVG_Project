extends Area2D

export(PackedScene) var healthScene
export(PackedScene) var manaScene

var assistant

func give_reward():
	self.visible = true
	var healthGain = healthScene.instance()
	var manaGain = manaScene.instance()
	manaGain.set_assistant(assistant)
	#add_child(healthGain)
	add_child(manaGain)

func set_assistant(assistant):
	self.assistant = assistant
