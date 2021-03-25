extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#Initial Function
func _ready():
	pass # Replace with function body.

#Functions

func _on_TextureButton_pressed():
	get_tree().change_scene("res://MainLevels/Mass/Level2/Level2.tscn")

func _on_TextureButton4_pressed():
	get_tree().change_scene("res://MainLevels/Light/light-selection.tscn")
	
func _on_Leaderboard_pressed():
	#get_tree().change_scene("res://src/Mainscene.tscn")
	get_tree().change_scene("res://Assets/Common/Leaderboard.tscn")
	
func _on_Profile_pressed():
	get_tree().change_scene("res://MainLevels/Profile/Profile.tscn")

func _on_SignOut_pressed() -> void:
	get_tree().change_scene("res://Scenes/Login/LoginRegister.tscn")
