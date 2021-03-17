extends Control

onready var email_input = get_node("Background/VBoxContainer/Email")
onready var userpassword_input = get_node("Background/VBoxContainer/Password")
onready var login_button = get_node("Background/VBoxContainer/Login")
onready var ErrorNotificate = get_node("Background/VBoxContainer/ErrorNotification")

onready var Data =  preload("userData.gd")

var Email;
var Password;

func _on_Login_pressed():
	var data = JSON.parse(Data.new().User)
	var email = str(data.result['email'])
	var password = str(data.result['password'])
	var SelectedCharacter = str(data.result['SelectedCharacter'])
	
	if email_input.text != email or userpassword_input.text != password:
		ErrorNotificate.text = "Please provide a vaild email and password"
		print("Please provide vaild userName and password")
	else:
		email_input.get_text() == email
		userpassword_input.get_text() == password
		print("attempting to login")
		if SelectedCharacter == "false":
			print("Selected Character Page")
			get_tree().change_scene("res://MainLevels/Characters/character-selection.tscn")
			pass #SelectedCharacter Page
		else:
			print("Game Level Page")
			get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
			pass #Game Level Page÷

func _on_CreateAccount_pressed():
	get_tree().change_scene("res://Scenes/Login/CreateAccount.tscn")
	pass # Replace with function body.

