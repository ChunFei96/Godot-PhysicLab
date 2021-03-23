extends Control



onready var Database =  preload("res://Scenes/API/Database.gd")

var selectedChar

func _ready():
	pass # Replace with function body.
	
#Functions
# View Character Information - Einstein
func _on_einstein_pressed():
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	get_tree().change_scene("res://Scenes/Characters/character1.tscn")
	
# View Character Information - Galilei
func _on_galilei_pressed():
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	get_tree().change_scene("res://Scenes/Characters/character2.tscn")
	
# View Character Information - Newton
func _on_newton_pressed():
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	get_tree().change_scene("res://Scenes/Characters/character3.tscn")
	
# View Character Information - Tesla
func _on_tesla_pressed():
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	UpdateStudentCharacterRequest("PlayerA",selectedChar)
	#get_tree().change_scene("res://Scenes/Characters/character4.tscn")
	
