extends Node2D

export(bool) var add_to_mouse = true

export (float) var lightDimRate = 0.015
export (float) var textureScale = lightDimRate / 0.42857142857
export (float) var lightCollisionScaleRate = Vector2(lightDimRate/0.15, lightDimRate/0.15) 



func _process(delta):
	if add_to_mouse:
		global_position = get_global_mouse_position()
	
	if $Light2D.energy >= 0 && !$LightDetection/CollisionShape2D.disabled:
		$Light2D.energy -= lightDimRate * delta 
		$Light2D.texture_scale -=   textureScale * delta 
		$LightDetection/CollisionShape2D.scale -= lightCollisionScaleRate * delta
		
func _input(event):
	if event.is_action_pressed("ui_down"):
		#$Light2D.enabled = !$Light2D.enabled
		pass



func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")


