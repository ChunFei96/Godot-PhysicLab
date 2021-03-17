extends Node

# Initial Function
func _ready():
	pass # Replace with function body.

#Functions
#Return to Game Character Selection page
func _on_back_pressed():
	pass # Replace with function body.
	get_tree().change_scene("res://MainLevels/Characters/character-selection.tscn")
	
#Confirm selection of character
func _on_select_pressed():
	pass # Replace with function body.
	#Get variable from Global Script
	var data = get_node("/root/Data")
	data.characterSelection[1]=true
	#Testing input
	#print(data.characterSelection[1])
	#Direct to select topic scene
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
	
#Link to browser for more details
func _on_reference_pressed():
	pass # Replace with function body.
	OS.shell_open("https://www.britannica.com/biography/Galileo-Galilei")

