extends Node2D

onready var cats = get_tree().get_nodes_in_group("Cats")

var rescuedCatCount = 0;

func _ready():
	# init dialog 
	$DialogManager/DialogBox.dialog = $DialogManager/DialogBox.load_dialog_file('res://MainLevels/Light/Cat/dialogs.txt')
	$DialogManager/DialogBox.load_dialog($DialogManager/DialogBox.dialog)
	
	# init timer
	$TimerManager.setTime(60)
	
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
	$GameOverLayer/AnimationPlayer.play("Fade")
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	$TimerManager.timePause()

func _on_cat_tree_exiting():
	rescuedCatCount += 1
	$CatCount.text = String(rescuedCatCount) + "/" + String(len(cats))
	if rescuedCatCount == len(cats):
		$CanvasModulate.visible = false
		$Lamp.visible = false
		_on_timer_tree_exiting()
	

func _process(delta):
	$Score.text = String(Global.getScore())
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
