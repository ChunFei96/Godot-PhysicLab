extends Node2D

onready var cats = get_tree().get_nodes_in_group("Cats")
onready var ErrorNotificate = get_node("ErrorNotification")
onready var Database =  preload("res://Scenes/API/Database.gd")

var levelnumber = 1
var topicname = "Light"
var rescuedCatCount = 0;
var set_total_time = 60

func _ready():
	# init dialog 
	$DialogManager/DialogBox.dialog = $DialogManager/DialogBox.load_dialog_file('res://MainLevels/Light/Cat/dialogs.txt')
	$DialogManager/DialogBox.load_dialog($DialogManager/DialogBox.dialog)
	
	# init timer
	$TimerManager.setTime(set_total_time)
	
	# setup signal
	$DialogManager/DialogBox.connect("tree_exiting", self, "_on_dialogbox_tree_exiting")
	$TimerManager.connect("tree_exiting", self, "_on_timer_tree_exiting")
	
	for cat in cats:
		cat.connect("tree_exiting", self, "_on_cat_tree_exiting")
	
	$GameOverLayer.visible = false
	
	# reset points
	Global.points = 0
	
	# init cat count
	$CatCount.text = String(rescuedCatCount) + "/" + String(len(cats))
	
	# disable light collision before game start
	$Lamp/LightDetection/CollisionShape2D.disabled = true

func _on_dialogbox_tree_exiting():
	$TimerManager.timeStart()
	$CanvasModulate.visible = true
	$Lamp.visible = true
	$Lamp/LightDetection/CollisionShape2D.disabled = false

func _on_timer_tree_exiting():
	$GameOverLayer.visible = true
	$TimerManager.timePause()
	SaveScore()
	$GameOverLayer/AnimationPlayer.play("Fade")
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	#print('_on_timer_tree_exiting')
	

func _on_cat_tree_exiting():
	#print('_on_cat_tree_exiting')
	rescuedCatCount += 1
	$CatCount.text = String(rescuedCatCount) + "/" + String(len(cats))
	if rescuedCatCount == len(cats):
		$CanvasModulate.visible = false
		$Lamp.visible = false
		_on_timer_tree_exiting()
	

func _process(delta):
	$Score.text = String(Global.getScore())
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())

func SaveScore():
	#print('SaveScore()')
	var completion_time = $TimerManager.timeUsed()
	#print('completion_time: ' + str(completion_time))
	#print('scores: ' + str(Global.getScore()))
	
	#Global.setUsername("Student1") #test
	if Global.getUsername() == null:
		ErrorNotificate.text = "Username is null"
		pass
	else:
		SaveGameScoreRequest(str(Global.getScore()),str(completion_time))

	
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
			ErrorNotificate.text = "HTTP Post error"
	else:
		ErrorNotificate.text = "HTTP Post error"


func _on_bgm_finished():
	$bgm.play()
	pass # Replace with function body.


func _on_Cat_tree_entered():
	$bgm.play()
	pass # Replace with function body.


func _on_Cat_tree_exiting():
	$bgm.play()
	pass # Replace with function body.
