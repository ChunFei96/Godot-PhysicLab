extends Control

onready var Data =  preload("Data.gd")
onready var Database =  preload("res://Scenes/API/Database.gd")


func GetStudentProfileRequest(username:String = ""):
	print('inner request')
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"GetStudentProfileResponse")

	var User = Database.new().User
	var user = User.new()
	var query = user.setGetStudentProfileQuery(username)
	var url = user.setGetStudentListURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
	
# Has return value
func GetStudentProfileResponse(result, response_code, headers, body):
	print('inner response')
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



# Called when the node enters the scene tree for the first time.
func _ready():
	GetStudentProfileRequest("Student1")
	
#	var data = JSON.parse(Data.new().data2)
#
#	#Get your text fields
#	var name = get_node("Name")
#	var email = get_node("Email")
#	var age = get_node("Age")
#	var gender = get_node("Gender")
#
#	#Display result as JSON
#	print("Json result: " + str(data.result))
#
#	#Get Property's value from data.result
#	var getName = str(data.result['name'])
#	var getEmail = str(data.result['email'])
#	var getAge = str(data.result['age'])
#	var getCity = str(data.result['gender'])
#
#	#Print result to "Output" console
#	print("Name2: " + getName)
#	print("Email2: " + getEmail)
#	print("Age2: " + getAge)
#	print("City2: " + getCity)
#
#	#Update UI's text fields  
#	name.text = getName
#	email.text = getEmail
#	age.text = getAge
#	gender.text = getCity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
