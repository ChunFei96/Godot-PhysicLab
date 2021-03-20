extends Control

onready var Database =  preload("res://Scenes/API/Database.gd")

var levelnumber = 2
var topicname = "Mass"

# Called when the node enters the scene tree for the first time.
func _ready():
	# init dialog 
	$DialogManager/DialogBox.dialog = $DialogManager/DialogBox.load_dialog_file('res://MainLevels/Mass/Level2/dialogs.txt')
	$DialogManager/DialogBox.load_dialog($DialogManager/DialogBox.dialog)
	
	# init timer
	$TimerManager.setTime(10)
	
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
	$GameOverLayer/AnimationPlayer.play("Fade")
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	SaveScore()

func _process(delta):
	$Score.text = String(Global.getScore())
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	
func SaveScore():
	#TODO: wait for Lee method to return TotalTimeTaken, and replace the urgument below
	SaveGameScoreRequest(str(Global.getScore()),"20")
	pass
	
func SaveGameScoreRequest(score:String = "",timecompleted:String = ""):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed",self,"SaveGameScoreResponse")
	
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
			print('HTTP Post error')
			return null
	else:
		return null


#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	pass # Replace with function body.
