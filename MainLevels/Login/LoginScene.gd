extends Control

onready var email_input = get_node("Background/VBoxContainer/Email")
onready var userpassword_input = get_node("Background/VBoxContainer/Password")
onready var login_button = get_node("Background/VBoxContainer/Login")
onready var ErrorNotificate = get_node("Background/VBoxContainer/ErrorNotification")

onready var Data =  preload("userData.gd")
onready var Database =  preload("res://Scenes/API/Database.gd")

var Email;
var Password;


# =====================================================================================

func GetStudentProfileRequest(username:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"GetStudentProfileResponse")

	var User = Database.new().User
	var user = User.new()
	var query = user.setGetStudentProfileQuery(username)
	var url = user.setGetStudentListURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
	
# Has return value
func GetStudentProfileResponse(result, response_code, headers, body):
	print('inner')
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if data == null:
				print('no data returned')
			else:
				print(data.result)
		else:
			print('HTTP Post error ')
			return null
	else:
		return null
		
func ValidateLoginRequest(username:String = "",password:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"ValidateLoginResponse")
	
	var User = Database.new().User
	var user = User.new()
	var query = user.setValidateLoginQuery(username,password)  
	var url = user.setValidateLoginURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
func ValidateLoginResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
		
			print(data.result)
			print(data.result[0])
			print(data.result[1])
			print('----')
			var isValidLogin = bool(data.result[0])
			
			print(isValidLogin)
			if isValidLogin == true:
				var SelectedCharacter = data.result[1]
				print('SelectedCharacter: ' + str(SelectedCharacter))
				if SelectedCharacter == '':
					#print("Selected Character Page")
					get_tree().change_scene("res://MainLevels/Characters/character-selection.tscn")
					#pass #SelectedCharacter Page
				else:
					#print("Game Level Page")
					get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
					#pass #Game Level Page÷
			else:
				ErrorNotificate.text = "Please provide a vaild email and password"
		else:
			print('HTTP Post error ')
			return null
	else:
		return null

# =====================================================================================


func _on_Login_pressed():
	var username = email_input.text
	var password = userpassword_input.text
	var database = Database.new()
	ValidateLoginRequest(username,password)
			

func _on_CreateAccount_pressed():
	get_tree().change_scene("res://Scenes/Login/CreateAccount.tscn")
	pass # Replace with function body.



#func _on_HttpPost_request_completed(result, response_code, headers, body):
#	print('hi')
#	pass # Replace with function body.
