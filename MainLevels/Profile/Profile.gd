extends Control

onready var Data =  preload("Data.gd")
onready var Database =  preload("res://Scenes/API/Database.gd")
onready var ErrorNotificate = get_node("ErrorNotification")

func GetStudentProfileRequest(username:String = ""):
	#print('inner request')
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"GetStudentProfileResponse")

	var User = Database.new().User
	var user = User.new()
	var query = user.setGetStudentProfileQuery(username,"true")
	var url = user.setGetStudentProfileURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
	
# Has return value
func GetStudentProfileResponse(result, response_code, headers, body):
	#print('inner response')
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			#data = null #testing to toggle invalid case
			
			if data == null:
				ErrorNotificate.text = "No result found!"
			else:
				#print(data.result)
				
				#	#Get your text fields
				var name = get_node("NameInput")
				var age = get_node("AgeInput")
				var gender = get_node("GenderInput")
				var selectedChar = get_node("SelectedCharInput")
				
				#Update UI's text fields  
				name.text = data.result['studentName']
				age.text = str(data.result['age'])
				gender.text = data.result['gender']
				selectedChar.text = data.result['selectedCharacter']
		else:
			ErrorNotificate.text = "HTTP Post error "
	else:
		ErrorNotificate.text = "HTTP Post error "



# Called when the node enters the scene tree for the first time.
func _ready():
	GetStudentProfileRequest(Global.username)

func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")

#
#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	pass # Replace with function body.


func _on_bgm_finished():
	$bgm.play()
	pass # Replace with function body.


func _on_LoginScreen_tree_entered():
	$bgm.play()
	pass # Replace with function body.


func _on_LoginScreen_tree_exiting():
	$bgm.stop()
	pass # Replace with function body.
