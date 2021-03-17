


func _ready():
	pass
		
		
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
		
	func SaveGameScore(playerId,topicId,score,time):
		updateTopicJSON = {
			"id" : topicId,
			"studentId" : playerId,
			"score" : score,
			"timeCompleted" : time,
		}
		print(str(updateTopicJSON))
		print('SaveGameScore')
		UpdateTopic()
	
	#--End--
		

class User:
	var user;
	
	#constructor
	func _init(usr):
		user = usr
		print('init')
	
	func getUser():
		print('calling getUser()....')
		
	# Username = email
	func getUsername():
		print('calling getUsername()....')
		
	func getPassword():
		print('calling getPassword()....')
		
	func getName():
		print('calling getName()....')
	
	func getGender():
		print('calling getGender()....')
		
	func getAge():
		print('calling getAge()....')
		
	func ValidateUser():
		print('calling ValidateUser()....')
		
	func RegisterUser():
		print('calling RegisterUser()....')
	
	func GetPlayerList():
		print('calling GetPlayerList()....')
		
	#API
	func CreatePlayerRecord():
		print('calling CreatePlayerRecord()....')
		
	#API
	func GetPlayerProfile():
		print('calling GetPlayerProfile()....')

class GameTopic:
	func GetAllTopics():
		print('calling GetAllTopics()....')
	
class Leaderboard:
	func DisplayLeaderboard():
		print('calling DisplayLeaderboard()....')
			
	func GetTopicList():
		print('calling GetTopicList()....')	

class EnumList:
#	var enumList
#
#	#constructor
#	func _init(enumlist):
#		enumList = enumlist
		
	#API HTTP POST
	func setGetEnumbyTypeURL():
		var localhost = "http://localhost:53921"
		var url = localhost + "/api/common/get-enum-by-type"
		return str(url)

	# Set API's param. Eg: data = "GameTopic" or "Difficulties" etc
	func setQuery(data):
		return JSON.print({"enumType" : str(data)})
		
	# Convert Array-liked string to actual Array
	func toArray(d):
		return d.replace('[', '').replace(']', '').split(",")
	
	# Register C# API to gd.script function
	func reqTest(headers,HttpPost):
		HttpPost.connect("request_completed",self,"doSomething")
		var query = setQuery("GameTopic")
		var url = setGetEnumbyTypeURL()
		HttpPost.request(url,headers,false,HTTPClient.METHOD_POST,query)

	
	

	func GetEnumbyType(enumType):
		print('calling GetEnumbyType()....')	
