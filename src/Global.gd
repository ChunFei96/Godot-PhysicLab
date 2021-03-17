extends Node


func _ready():
	SilentWolf.configure({
		"api_key": "NirVYLTK7Z6Q3BCcYaywZ3HQLV9P3TD159UJOYmc",
		"game_id": "Reflection",
		"game_version": "0.0.0",
		"log_level": 1
		})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://src/Mainscene.tscn"
		})
	
