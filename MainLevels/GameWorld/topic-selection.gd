extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#Initial Function
func _ready():
	pass # Replace with function body.

#Functions

func _on_TextureButton_pressed():
	pass # Replace with function body.
	#Get variable from Global Script
	var data = get_node("/root/Data")
	data.topicSelection[0]=true
	#Testing input
	#print(data.topicSelection[0])
	
	#Direct to topic first screen
	get_tree().change_scene("res://MainLevels/Mass/Level2/Level2.tscn")

func _on_TextureButton4_pressed():
	pass # Replace with function body.
	#Get variable from Global Script
	var data = get_node("/root/Data")
	data.topicSelection[1]=true
	#Testing input
	#print(data.topicSelection[1])
	
	#Direct to topic first screen
	get_tree().change_scene("res://MainLevels/Light/Cat/Cat.tscn")
	
	



func _on_Leaderboard_pressed():
	#get_tree().change_scene("res://src/Mainscene.tscn")
	get_tree().change_scene("res://Assets/Common/Leaderboard.tscn")
	


func _on_Profile_pressed():
	get_tree().change_scene("res://MainLevels/Profile/Profile.tscn")
