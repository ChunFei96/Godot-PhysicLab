extends Node

onready var Database =  preload("res://Scenes/API/Database.gd")

# Initial Function
func _ready():
	pass # Replace with function body.

#Functions
#Return to Game Character Selection page
func _on_back_pressed():
	pass # Replace with function body.
	get_tree().change_scene("res://MainLevels/Characters/character-selection.tscn")

#Confirm selection of character
func _on_select_pressed():
	
	Global.setSelectedCharacter('Albert_Einstein')
	
	Global.setUsername('Student1') #test
	UpdateStudentCharacterRequest(Global.getUsername(),Global.getSelectedCharacter())
	print('Selected Char: ' + Global.getSelectedCharacter())

	#Direct to select topic scene
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
	pass # Replace with function body.
	
#Link to browser for more details
func _on_reference_pressed():
	pass # Replace with function body.
	OS.shell_open("https://www.britannica.com/biography/Albert-Einstein")
	

func UpdateStudentCharacterRequest(username:String = "",character:String = ""):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"UpdateStudentCharacterResponse")
	
	var User = Database.new().User
	var user = User.new()
	var query = user.setUpdateStudentCharacterQuery(username,character)
	var url = user.setUpdateStudentCharacterURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
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
	else:
		print('XX')


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var r_data = body.get_string_from_utf8()
	var data = JSON.parse(r_data)
	print(data.result)
	pass # Replace with function body.
