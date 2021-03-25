extends Node

onready var Database =  preload("res://Scenes/API/Database.gd")
onready var ErrorNotificate = get_node("ErrorNotification")

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
	
	#Global.setUsername('Student1') #test
	
	if Global.getUsername() == null:
		ErrorNotificate.text = "Username is null"
		pass
	else:
		UpdateStudentCharacterRequest(Global.getUsername(),Global.getSelectedCharacter())
		print('Selected Char: ' + Global.getSelectedCharacter())
	
#Link to browser for more details
func _on_reference_pressed():
	pass # Replace with function body.
	OS.shell_open("https://www.britannica.com/biography/Albert-Einstein")
	


func UpdateStudentCharacterRequest(username:String = "",character:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"UpdateStudentCharacterResponse")
	
	var User = Database.new().User
	var user = User.new()
	#character = 'Gallieo' #test
	var query = user.setUpdateStudentCharacterQuery(username,character)
	var url = user.setUpdateStudentCharacterURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
	
# No return value
func UpdateStudentCharacterResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_BOOL:
				var isUpdateOK = data.result
				#print(data.result)
				
				#isUpdateOK = false #test
				if isUpdateOK == true:
					ErrorNotificate.text = "Character selected successfully!"
					yield(get_tree().create_timer(5.0), "timeout")
					get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
				else:
					ErrorNotificate.text = "Invalid character selection"
			else:
				ErrorNotificate.text = "HTTP Post error"
		else:
			ErrorNotificate.text = "HTTP Post error"
	else:
		ErrorNotificate.text = "HTTP Post error"


