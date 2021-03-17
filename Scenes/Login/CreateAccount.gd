extends Control

export (NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path)

onready var Database =  preload("res://Scenes/API/Database.gd")

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



var studentList = ['Select a Student']


func GetStudentListRequest():
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"GetStudentListResponse")
	
	var User = Database.new().User
	var user = User.new()
	var url = user.setGetStudentListURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_GET,"")
	
# Has return value
func GetStudentListResponse(result, response_code, headers, body):
	var ErrorNotificate = get_node("ErrorNotification")

	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			
			if typeof(data.result) == TYPE_ARRAY:
				#var tt = true
				if data.result.size() > 0:  #and tt == false : use to toggle invalid case
					#This will return a List
					for i in data.result:
						studentList.append(i)
					#print(studentList)
				else:
					ErrorNotificate.text = "No result found!"
			else:
				ErrorNotificate.text = "No result found!"
		else:
			ErrorNotificate.text = "No result found!"
	else:
		ErrorNotificate.text = "No result found!"
	addStudentOption()
	disable_option(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	GetStudentListRequest()
	dropdown.connect("item_selected",self,"on_item_selected")
	pass

func addStudentOption():
	for i in studentList:
		dropdown.add_item(i)

func on_item_selected(id):
	print(studentList[id])

func disable_option(id):
	dropdown.set_item_disabled(id,true)


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







#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	pass # Replace with function body.
