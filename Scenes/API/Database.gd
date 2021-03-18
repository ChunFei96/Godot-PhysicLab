extends CanvasLayer


# ===================  Start of Classes ===================

class EnumList:	
	func setGetEnumbyTypeURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/common/get-enum-by-type"
		return str(url)

	# Set API's param. Eg: data = "GameTopic" or "Difficulties" etc
	func setQuery(data):
		return JSON.print({"enumType" : str(data)})
		
class Topic:
	var topic;
	var updateTopicJSON;
	
	#constructor
	func _init(tpc):
		topic = tpc
		print(topic)
		print('init')

	func RetrieveTopic():
		return topic
		
	#API
	func UpdateTopic():
		print('calling UpdateTopic()....')
		
	#Start: Get the properties of 'Topic' table from database 
	func getStudentId():
		return topic.studentId	
	
	func getTopicId():
		return topic.id	
	
	func getScore():
		return topic.score	
	
	func getTimeCompleted():
		return topic.timeCompleted	
		
	func getTrialCount():
		return topic.trialCount	
	
	func getStatus():
		return topic.status	
		
	func setSaveGameScoreURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/game/save-game-score"
		return str(url)
		
	func setQuery(username,topicname,levelnumber,score,timecompleted):
		return JSON.print({
			"username" : str(username),
			"topicname" : str(topicname),
			"levelnumber" : str(levelnumber),
			"score" : str(score),
			"timecompleted" : str(timecompleted)
		})

class Leaderboard:	
	func setGetLeaderboardByTopicURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/leaderboard/get-leaderboard-by-topic"
		return str(url)

	# Set API's param.
	func setQuery(data):
		return JSON.print({"TopicName" : str(data)})

class User:
	func setValidateLoginURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/user/validate-login"
		return str(url)

	# Set API's param.
	func setValidateLoginQuery(username, password):
		return JSON.print({
			"username" : str(username),
			"password" : str(password)
		})
		
	func setRegisterStudentURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/user/register-student"
		return str(url)

	# Set API's param.
	func setRegisterStudentQuery(username):
		return JSON.print({
			"username" : str(username)
		})
		
	func setUpdateStudentCharacterURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/user/update-student-character"
		return str(url)

	# Set API's param.
	func setUpdateStudentCharacterQuery(username,character):
		return JSON.print({
			"username" : str(username),
			"character" : str(character)
		})
	
	func setGetStudentListURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/user/get-student-for-registration"
		return str(url)
	
	func setGetStudentProfileURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/user/get-student-profile"
		return str(url)
	
	# Set API's param.
	func setGetStudentProfileQuery(username):
		return JSON.print({
			"username" : str(username)
		})
		

# ===================  END of Classes ===================

func _ready():
	#self.set_use_threads(true)
	#$HttpGet.connect("request_completed", self, "_on_request_completed")
	pass

# ===================  Create Common Method ===================


# API Call
#Function 1 - 16/3/21 1:30am
func GetEnumByTypeRequest(enumType:String = ""):
	print('calling GetEnumbyType()....')	
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"GetEnumByTypeResponse")
	
	var enumList = EnumList.new()
	var query = enumList.setQuery(enumType)  
	var url = enumList.setGetEnumbyTypeURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func GetEnumByTypeResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_ARRAY:
				if data.result.size() > 0:
					#This will return a List
					# Please use 'for-loop' to get all the results
					print(data.result[0]) # Display 1st result from list
					print(data.result[1]) # Display 2nd result from list
				else:
					print("No result found")
			else:
				print("Unexpected results.")	
		else:
			print('HTTP Post error ')
			return null
	else:
		return null
		
#Function 2 - 16/3/21 6:29pm
func SaveGameScoreRequest(username:String = "",topicname:String = "",levelnumber:String = "", score:int = 0, timecompleted:int = 0):
	print('calling GetEnumbyType()....')	
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"SaveGameScoreResponse")
	
	var topic = Topic.new(null)
	var query = topic.setQuery(username,topicname,levelnumber,score,timecompleted)
	var url = topic.setSaveGameScoreURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# No return value
func SaveGameScoreResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			pass
		else:
			print('HTTP Post error')
			return null
	else:
		return null

#Function 3 - 16/3/21 9:52pm
func GetLeaderboardByTopicRequest(TopicName:String = ""):
	print('calling GetLeaderboardByTopicRequest()....')	
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"GetLeaderboardByTopicResponse")
	
	var leaderboard = Leaderboard.new()
	var query = leaderboard.setQuery(TopicName)  
	var url = leaderboard.setGetLeaderboardByTopicURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func GetLeaderboardByTopicResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_ARRAY:
				if data.result.size() > 0:
					#This will return a List
					# Please use 'for-loop' to get all the results
					print(data.result[0]) # Display 1st result from list
					print(data.result[1]) # Display 2nd result from list
				else:
					print("No result found")
			else:
				print("Unexpected results.")
		else:
			print('HTTP Post error ')
			return null
	else:
		return null

#Function 4 - 16/3/21 10:15pm
func ValidateLoginRequest(username:String = "",password:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"ValidateLoginResponse")
	
	var user = User.new()
	var query = user.setValidateLoginQuery(username,password)  
	var url = user.setValidateLoginURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func ValidateLoginResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_BOOL:
				print(data.result)
			else:
				print("Unexpected results.")
		else:
			print('HTTP Post error ')
			return null
	else:
		return null

#Function 5 - 16/3/21 10:21pm
func RegisterStudentRequest(username:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"RegisterStudentResponse")
	
	var user = User.new()
	var query = user.setRegisterStudentQuery(username)  
	var url = user.setRegisterStudentURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func RegisterStudentResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_BOOL:
				print(data.result)
			else:
				print("Unexpected results.")
		else:
			print('HTTP Post error ')
			return null
	else:
		return null

#Function 6 - 16/3/21 10:59pm
func UpdateStudentCharacterRequest(username:String = "",character:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"UpdateStudentCharacterResponse")
	
	var user = User.new()
	var query = user.setUpdateStudentCharacterQuery(username,character)
	var url = user.setUpdateStudentCharacterURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# No return value
func UpdateStudentCharacterResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			pass
		else:
			print('HTTP Post error')
			return null
	else:
		return null

#Function 7 - 16/3/21 11:14pm
func GetStudentListRequest():
	var headers = ["Content-Type: application/json"]
	$HttpGet.connect("request_completed",self,"GetStudentListResponse")
	
	var user = User.new()
	var url = user.setGetStudentListURL()
	$HttpGet.request(url,headers,false,HTTPClient.METHOD_GET,"")
	
# Has return value
func GetStudentListResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			if typeof(data.result) == TYPE_ARRAY:
				if data.result.size() > 0:
					#This will return a List
					# Please use 'for-loop' to get all the results
					print(data.result[0]) # Display 1st result from list
				else:
					print("No result found")
			else:
				print("Unexpected results.")
		else:
			print('HTTP Post error ')
			return null
	else:
		return null

#Function 8 - 16/3/21 11:43pm
func GetStudentProfileRequest(username:String = ""):
	var headers = ["Content-Type: application/json"]
	$HttpPost.connect("request_completed",self,"GetStudentProfileResponse")
	
	var user = User.new()
	var query = user.setGetStudentProfileQuery(username)
	var url = user.setGetStudentListURL()
	$HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
	
# Has return value
func GetStudentProfileResponse(result, response_code, headers, body):
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









# =================== Actual Get / Post ============
func _on_Button_Post_pressed():

	#Testing inner function call API
	#GetEnumByTypeRequest("GameTopic")  #DONE Valid Input
	#SaveGameScoreRequest("Student1","Mass","2",10,23) #DONE Valid Input
	#SaveGameScoreRequest("Student1","mass","2",10,23) #DONE Invalid Input
	#GetLeaderboardByTopicRequest("Light") #DONE Valid Input
	#ValidateLoginRequest("Student1","Student123") #DONE Valid Input
	#ValidateLoginRequest("Student1","Student1234") #DONE Invalid Input
	#RegisterStudentRequest("WJ") #DONE Valid Input
	#UpdateStudentCharacterRequest("Student1","1")
	#GetStudentProfileRequest("Student1") #DONE Valid Input
	pass
	




# =================================== HTTP GET ================================================
func _on_Button_Get_pressed():
	#GetStudentListRequest() #DONE Valid
	pass





# =================================== GAME TEST Button ================================================

func _on_Button_pressed():
	print('_on_Button_pressed')
	pass # Replace with function body.


func _on_Game_request_completed(result, response_code, headers, body):
	print('_on_Game_request_completed')
	pass # Replace with function body.



