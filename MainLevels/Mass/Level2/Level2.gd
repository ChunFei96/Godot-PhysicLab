extends Control

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

func _process(delta):
	$Score.text = String(Global.getScore())
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	

