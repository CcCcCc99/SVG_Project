extends Node

var effect = preload("res://scenes/Effect.tscn")

var musics
var effects

func _ready():
	var m = Node.new()
	m.name = "Musics"
	add_child(m)
	musics = m
	
	var e = Node.new()
	e.name = "Effects"
	add_child(e)
	effects = e

func add_effect(audio: String, volume: float, pitch: float):
	var new_effect = effect.instance()
	effects.add_child(new_effect)
	new_effect.set_effect(audio, volume, pitch)
