extends Node2D


export (NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path)
onready var Database =  preload("res://Scenes/API/Database.gd")
onready var item = preload("res://Assets/Common/Item.tscn")
onready var ErrorNotificate = get_node("ErrorNotification")

var topicList = ['Select a Topic','Mass','Light']
var itemList = []
var selectedTopic

# Called when the node enters the scene tree for the first time.
func _ready():
	dropdown.connect("item_selected",self,"on_item_selected")
	addTopicOption()
	
	pass # Replace with function body.
	
func on_item_selected(id):
	selectedTopic = topicList[id]

	if selectedTopic != 'Select a Topic':
		GetLeaderboardByTopicRequest(selectedTopic)
		print(selectedTopic)
	else:
		resetBoardList()
		#queue_free()
	
func addTopicOption():
	for i in topicList:
		dropdown.add_item(i)
		
func remove_all():
	dropdown.clear()
	dropdown.add_item('Select a Topic')

func createBoardItem(index,data,y_axis):
	#print(data)
	
	#Declare the "Item" 
	var i = item.instance()
	
	#Get all the child components
	var index_node = i.get_child(0)
	var name_node = i.get_child(1)
	var score_node = i.get_child(2)
	var time_node = i.get_child(3)
	
	#Set new values to the components
	index_node.text = str(index)
	name_node.text = data['student']
	score_node.text = str(data['score'])
	time_node.text = str(data['timeCompleted'])
	
	#Set the "item" position
	i.rect_position = Vector2(96,y_axis)
	
	#Append new object to scene
	add_child(i)
	itemList.append(i) #testing
	#i.add_to_group("items") #testing
	pass
	
func displayBoardList(data):
	var index = 1
	var y_axis = 244 # 184
	resetBoardList()
	for i in data:
		createBoardItem(index,i,y_axis)
		index += 1
		y_axis += 60
	pass

func resetBoardList():
	for i in itemList:
		if i == null:
			itemList.erase(i)
		else:
			i.queue_free()

	if itemList.size() > 0 and itemList[0] != null:
		if itemList[0] == null:
			#itemList = []
			print('itemList contains null')
			pass
		else:
			for i in itemList:
				i.queue_free()

#================= Start: API Methods =================
func GetLeaderboardByTopicRequest(TopicName:String = ""):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"GetLeaderboardByTopicResponse")
	
	var Leaderboard = Database.new().Leaderboard
	var leaderboard = Leaderboard.new()
	var query = leaderboard.setQuery(TopicName)  
	var url = leaderboard.setGetLeaderboardByTopicURL()
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func GetLeaderboardByTopicResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var r_data = body.get_string_from_utf8()
			var data = JSON.parse(r_data)
			
			
			if typeof(data.result) == TYPE_ARRAY:
				if data.result.size() > 0:
					displayBoardList(data.result)
					#print(data.result[0]) # Display 1st result from list
				else:
					resetBoardList()
			else:
				ErrorNotificate.text = "No result found!"
		else:
			ErrorNotificate.text = "HTTP Post error"
			resetBoardList()
	else:
		resetBoardList()
		ErrorNotificate.text = "HTTP Post error"
		
#================= End: API Methods =================

