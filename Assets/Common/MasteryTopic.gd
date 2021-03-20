extends Node2D



export (NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path)
onready var Database =  preload("res://Scenes/API/Database.gd")
onready var ErrorNotificate = get_node("ErrorNotification")


var studentList = ['Select a Student']
var selectedStudent



# Called when the node enters the scene tree for the first time.
func _ready():
	initTotalLabels()
	initLightTopicLabel()
	GetValidStudentListRequest()
	dropdown.connect("item_selected",self,"on_item_selected")
	pass # Replace with function body.

func addStudentOption():
	for i in studentList:
		dropdown.add_item(i)

func on_item_selected(id):
	selectedStudent = studentList[id]
	
	var name = str(selectedStudent)
	#print(name)
	GetStudentProfileRequest(name)
	
func disable_option(id):
	dropdown.set_item_disabled(id,true)
	
func remove_all():
	dropdown.clear()
	dropdown.add_item('Select a Student')
	
func resetPlayerInfo():
	#	#Get your text fields
	var name = get_node("NameInput")
	var age = get_node("AgeInput")
	var gender = get_node("GenderInput")
	var selectedChar = get_node("CharacterInput")
	
	#Update UI's text fields  
	name.text = "-"
	age.text = "-"
	gender.text = "-"
	selectedChar.text = "-"
	
func resetTotalInfo():
	initTotalLabels()
	
func initLightTopicLabel():
	var light = get_node("Summary_light")
	
	#Update node's Label
	light.get_child(1).text = "Light"
	
func initTotalLabels():
	var total_topics = get_node("total_topics")
	var total_time = get_node("total_time")
	
	#Update node's Label
	total_topics.get_child(1).text = "Total Topics"
	total_time.get_child(1).text = "Total Time"
	
	total_topics.get_child(0).text = "-"
	total_time.get_child(0).text = "-"	
	
func displayTopicSummary(m,l):
	var mass = get_node("Summary_mass")
	var light = get_node("Summary_light")

	#Update node's Value
	mass.get_child(0).text = str(m)
	light.get_child(0).text = str(l)
	pass



# =========== Start: API CALLS ===========

func GetValidStudentListRequest():
	var headers = ["Content-Type: application/json"]
	$Http_stuList.connect("request_completed",self,"GetValidStudentListResponse")
	
	var User = Database.new().User
	var user = User.new()
	var url = user.setGetValidStudentListURL()
	$Http_stuList.request(url,headers,false,HTTPClient.METHOD_GET,"")
	
func GetValidStudentListResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			
			if typeof(data.result) == TYPE_ARRAY:
				if data.result.size() > 0:
					for i in data.result:
						studentList.append(i)
				else:
					ErrorNotificate.text = "No result found!"
			else:
				ErrorNotificate.text = "No result found!"
		else:
			ErrorNotificate.text = "No result found!"
	else:
		ErrorNotificate.text = "No result found!"
	addStudentOption()
	
func GetStudentProfileRequest(name:String = ""):
	var headers = ["Content-Type: application/json"]
	$Http_stuProfile.connect("request_completed",self,"GetStudentProfileResponse")

	if name == "Select a Student":
		resetPlayerInfo()
		resetTotalInfo()
	else:
		var User = Database.new().User
		var user = User.new()
		var query = user.setGetStudentProfileQuery(name,"false")
		var url = user.setGetStudentProfileURL()
		$Http_stuProfile.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
func GetStudentProfileResponse(result, response_code, headers, body):
	
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			
			if data == null:
				var ErrorNotificate = get_node("ErrorNotification")
				ErrorNotificate.text = "No result found!"
			else:
				#print(data.result)

				#	#Get your text fields
				var name = get_node("NameInput")
				var age = get_node("AgeInput")
				var gender = get_node("GenderInput")
				var selectedChar = get_node("CharacterInput")
				
				#Update UI's text fields  
				name.text = data.result['studentName'] if data.result['studentName'] != null else "-"
				age.text = str(data.result['age']) if data.result['age'] != null else "-"
				gender.text = data.result['gender'] if data.result['gender'] != null else "-"
				selectedChar.text = data.result['selectedCharacter'] if data.result['selectedCharacter'] != null else "-"
				
				displayTotalInfo()
		else:
			ErrorNotificate.text = "HTTP Post error !"
	else:
		ErrorNotificate.text = "HTTP Post error !"
		
func GetLeaderboardByTopicRequest(TopicName:String = ""):
	var headers = ["Content-Type: application/json"]
	$Http_leaderboard.connect("request_completed",self,"GetLeaderboardByTopicResponse")
	
	var Leaderboard = Database.new().Leaderboard
	var leaderboard = Leaderboard.new()
	var query = leaderboard.setQuery(TopicName)  
	var url = leaderboard.setGetLeaderboardByTopicURL()
	$Http_leaderboard.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
func GetLeaderboardByTopicResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
					
			if typeof(data.result) == TYPE_ARRAY:
				if data.result.size() > 0:
					print('===')
					print(data.result)
					showStatisticsByTotal(selectedStudent,data.result)
				else:
					#resetBoardList()
					pass
			else:
				ErrorNotificate.text = "No result found!"
		else:
			ErrorNotificate.text = "HTTP Post error"
			#resetBoardList()
	else:
		#resetBoardList()
		ErrorNotificate.text = "HTTP Post error"

# =========== End: API CALLS ===========

func displayTotalInfo():
	GetLeaderboardByTopicRequest()
	pass
	
func showStatisticsByTotal(username,arr):
	var newList = {
		"total_topics": [],
		"total_topics_score": [],
		"total_time": 0
	}
	
	for i in arr:
		if i.student == username:
			
			#checkDuplicateTopic return "-1" if not found in the list
			var checkDuplicateTopic = newList.total_topics.find(i.gameTopic)
			if  checkDuplicateTopic == -1:
				newList.total_topics.append(i.gameTopic)
			
			newList.total_time += i.timeCompleted
			
			var matchedIndex = newList.total_topics.find(i.gameTopic)
			#print(matchedIndex)
			#print(newList.total_topics)
			if matchedIndex > -1:
				#print('size:')
				#print(newList.total_topics_score.size())
				if newList.total_topics_score.size() == 0 or matchedIndex >= newList.total_topics_score.size():
					newList.total_topics_score.append(i.score)
				else:
					newList.total_topics_score[matchedIndex] += i.score

	addTotalNode("total_topics","Total Topics",newList.total_topics.size())
	addTotalNode("total_time","Total Time",newList.total_time)
	
	var mass_index = newList.total_topics.find("Mass")
	var light_index = newList.total_topics.find("Light")
	displayTopicSummary(newList.total_topics_score[mass_index],newList.total_topics_score[light_index]) #(x = Mass,y=Light)
	print('summary of newList')
	print(newList)	
	return newList

func addTotalNode(key,label,value):
	var element = get_node(key)
	element.get_child(0).text = str(value)  #Set the Node's value
	#element.get_child(1).text = label #Set the Node's Label
	pass


func _on_Back_pressed():
	
	#Pending: dont know why to redirect
	get_tree().change_scene("res://MainLevels/Login/LoginScene.tscn")
	pass # Replace with function body.
