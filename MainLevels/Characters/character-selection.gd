extends Control



onready var Database =  preload("res://Scenes/API/Database.gd")

var selectedChar

func _ready():
	pass # Replace with function body.
	
#Functions
# View Character Information - Einstein
func _on_einstein_pressed():
	selectedChar = "Albert_Einstein"
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	get_tree().change_scene("res://Scenes/Characters/character1.tscn")
	
# View Character Information - Galilei
func _on_galilei_pressed():
	selectedChar = "Gallieo"
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	get_tree().change_scene("res://Scenes/Characters/character2.tscn")
	
# View Character Information - Newton
func _on_newton_pressed():
	selectedChar = "Newton"
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	get_tree().change_scene("res://Scenes/Characters/character3.tscn")
	
# View Character Information - Tesla
func _on_tesla_pressed():
	selectedChar = "Nikola_Tesla"
	#UpdateStudentCharacterRequest(Global.username,selectedChar)
	UpdateStudentCharacterRequest("PlayerA",selectedChar)
	#get_tree().change_scene("res://Scenes/Characters/character4.tscn")
	

func UpdateStudentCharacterRequest(username:String = "",character:String = ""):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"UpdateStudentCharacterResponse")
	
	var User = Database.new().User
	var user = User.new()
	var query = user.setUpdateStudentCharacterQuery(username,character)
	var url = user.setUpdateStudentCharacterURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# No return value
func UpdateStudentCharacterResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_BOOL:
				print('test')
				print(data.result)
			else:
				print("Unexpected results.")
		else:
			print('HTTP Post error')
			return null
	else:
		return null
