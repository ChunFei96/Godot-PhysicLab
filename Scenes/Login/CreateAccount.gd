extends Control

#Create account nodes
onready var name_input = get_node("Background/Name")
onready var gender_male_button = get_node("Background/Male")
onready var gender_female_button = get_node("Background/Female")
onready var age_input = get_node("Background/Age")
onready var email_input = get_node("Background/Email")
onready var password_input = get_node("Background/Password")
onready var password_repeat_input = get_node("Background/ConfirmPassword")
onready var errorMessage = get_node("Background/ErrorMessage")
onready var register_button = get_node("Background/RegisterButton")
onready var cancel_button = get_node("Background/Cancel")

#Test Daat
onready var Data =  preload("userData.gd")

#for the Gender ratio Button
var group

# Called when the node enters the scene tree for the first time.
func _ready():
	define_gender()

#To define gender
func define_gender():
	group = ButtonGroup.new()
	$Background/Male.set_button_group(group)
	$Background/Female.set_button_group(group)
	
#define gender with button
func _on_Male_toggled(button_pressed):
	pass

	
#define gender with button
func _on_Female_toggled(button_pressed):
	pass


#Link API
#var current_token := ""

#func _get_token_id_from_result(result: Array) -> String:
#	var result_body := JSON.parse(result[0].get_string_from_ascii()).result as Dictionary
#	return result_body.idToken
	

#func register(name: String, age: int, email: String, password: String, http: HTTPRequest) -> void:
#	var body:={
#		"name" : name,
#		"gender" : gender,
#		"age" : age,
#		"email" : email,
#		"password" : password,}
	#http.request([], false, HTTPClient.METHOD_POST, to_json(body))
	#var result := yield(http, "request_completed") as Array 
	#if result[1] == 200:
	#	current_token = _get_token_id_from_result(result)
		
		

#Get user details to create account
func _on_Register_pressed():
	#email verify
	var data = JSON.parse(Data.new().User)
	var getEmail = str(data.result['email'])

	#Verficate and get gender value 
	var getGender = ""
	if str($Background/Male.pressed) == "True" and str($Background/Female.pressed) == "False":
		getGender = $Background/Male.get_name()
		print("if male press: " + getGender)
	#if str($Background/Female.pressed):
	else:
		getGender = $Background/Female.get_name()
		print("else female press: " + getGender)
		
	if name_input.get_text() == "":
		errorMessage.text = "Invalid Name"
		print("Please provide a valid username")
		
	elif str($Background/Male.pressed) == "False" and str($Background/Female.pressed) == "False":
		errorMessage.text = "Gender not selected"
		
	elif age_input.get_text() == "":
		errorMessage.text = "Invalid Age"
		print("Please provide a valid age")
		
	elif email_input.get_text() == "":
		errorMessage.text = "Invalid Email"
		print("Please provide a valid Email")
		
	elif email_input.get_text() == getEmail:
		errorMessage.text = "Existing Email"
		print("existing Email")
		
	elif password_input.get_text() == "" or password_repeat_input.get_text() == "":
		errorMessage.text = "Invalid Password"
		print("Please provide a valid password")
		
	elif password_input.get_text() != password_repeat_input.get_text():
		errorMessage.text = "Password does not match!"
		print("Password don't match!")
		
	else:
		cancel_button.disabled = true
		var name = name_input.get_text()
		print("name: "+ name)
		var gender = getGender
		print("gender: "+ gender)
		var age = age_input.get_text() 
		print("age: " + age)
		var email = email_input.get_text()
		print("emial: " + email)
		var password = password_input.get_text()
		print("password: " + password)
		
		#After sucessful register, will auto transfer to login page in 1sec
		errorMessage.text = "Registration Sucessful"
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://MainLevels/Login/LoginScene.tscn")
	#register(name_input, age_input,email_input, password_input, http)
	 
	
# /back to the pervious page
func _on_Cancel_pressed():
	get_tree().change_scene("res://MainLevels/Login/LoginScene.tscn")





