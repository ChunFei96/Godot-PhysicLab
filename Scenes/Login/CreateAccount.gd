extends Control

export (NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path)
onready var Database =  preload("res://Scenes/API/Database.gd")
onready var ErrorNotificate = get_node("ErrorNotification")
onready var register_button = get_node("Background/RegisterButton")
onready var cancel_button = get_node("Background/Cancel")

var studentList = ['Select a Student']
var selectedStudent

func GetStudentListRequest():
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"GetStudentListResponse")
	
	var User = Database.new().User
	var user = User.new()
	var url = user.setGetStudentListURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_GET,"")
	
# Has return value
func GetStudentListResponse(result, response_code, headers, body):
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
	selectedStudent = studentList[id]
	print(studentList[id])
	
func disable_option(id):
	dropdown.set_item_disabled(id,true)
	
func remove_all():
	dropdown.clear()
	dropdown.add_item('Select a Student')
	
func RegisterStudentRequest(username:String = ""):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"RegisterStudentResponse")
	var User = Database.new().User
	var user = User.new()
	var query = user.setRegisterStudentQuery(username)  
	var url = user.setRegisterStudentURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func RegisterStudentResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			
			#var tt = false
			if typeof(data.result) == TYPE_BOOL: # and tt == true
				#print(data.result)
				remove_all()
				ErrorNotificate.text = "Registration Sucessful"
				yield(get_tree().create_timer(1.0), "timeout")
				get_tree().change_scene("res://Login/LoginScene.tscn")
				$bgm.stop()
			else:
				print("Unexpected results.")
				ErrorNotificate.text = "HTTP Post error"
		else:
			print('HTTP Post error ')
			ErrorNotificate.text = "HTTP Post error"
			return null
	else:
		ErrorNotificate.text = "HTTP Post error"


#Get user details to create account
func _on_Register_pressed():
	RegisterStudentRequest(selectedStudent)	 

	
# /back to the pervious page
func _on_Cancel_pressed():
	#get_tree().change_scene("res://Login/LoginScene.tscn")
	get_tree().change_scene("res://MainLevels/Teacher/TLanding.tscn")
	$bgm.stop()







#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	pass # Replace with function body.


func _on_bgm_finished():
	$bgm.play()
	pass # Replace with function body.
