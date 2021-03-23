extends Control

onready var ErrorNotificate = get_node("ErrorNotification")
onready var Database =  preload("res://Scenes/API/Database.gd")

var levelnumber = 2
var topicname = "Mass"
var set_total_time = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	# init dialog 
	$DialogManager/DialogBox.dialog = $DialogManager/DialogBox.load_dialog_file('res://MainLevels/Mass/Level2/dialogs.txt')
	$DialogManager/DialogBox.load_dialog($DialogManager/DialogBox.dialog)
	
	# init timer
	$TimerManager.setTime(set_total_time)
	
	# setup signal
	$DialogManager/DialogBox.connect("tree_exiting", self, "_on_dialogbox_tree_exiting")
	$TimerManager.connect("tree_exiting", self, "_on_timer_tree_exiting")
	
	$GameOverLayer.visible = false
	
	# reset points
	Global.points = 0
	
func _on_dialogbox_tree_exiting():
	$TimerManager.timeStart()

func _on_timer_tree_exiting():
	$GameOverLayer.visible = true
	SaveScore()
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	$GameOverLayer/AnimationPlayer.play("Fade")
	

func _process(delta):
	$Score.text = String(Global.getScore())
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	
func SaveScore():
	var completion_time = $TimerManager.timeUsed()
	print('completion_time: ' + str(completion_time))
	SaveGameScoreRequest(str(Global.getScore()),str(completion_time))
	pass
	
func SaveGameScoreRequest(score:String = "",timecompleted:String = ""):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"SaveGameScoreResponse")
	
	if Global.getUsername() == null:
		ErrorNotificate.text = "Username is null"
		pass
	else:
		var topic = Database.new().Topic
		var game = topic.new(null)
		var query = game.setSaveGameScoreQuery(Global.getUsername(),topicname,levelnumber,score,timecompleted)  
		var url = game.setSaveGameScoreURL()
		$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,query)
	
# Has return value
func SaveGameScoreResponse(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			pass
		else:
			ErrorNotificate.text = "HTTP Post error"
	else:
		ErrorNotificate.text = "HTTP Post error"


#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	pass # Replace with function body.
