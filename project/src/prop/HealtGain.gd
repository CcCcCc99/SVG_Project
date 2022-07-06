extends Pickupable

func _effect(player: Character):
	var hp = player.get_hp()
	player.set_hp(player.get_hp() + 2)
	if (hp != player.get_hp()):
		self.queue_free()
