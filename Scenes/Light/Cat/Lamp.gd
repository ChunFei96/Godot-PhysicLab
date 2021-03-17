extends Node2D

export(bool) var add_to_mouse = true

# Called when the node enters the scene tree for the first time.


func _process(delta):
	if add_to_mouse:
		global_position = get_global_mouse_position()
		
func _input(event):
	if event.is_action_pressed("ui_up"):
		$Light2D.enabled = !$Light2D.enabled
	



func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
