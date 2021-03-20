extends Control

export (NodePath) var questionTextPath
export (NodePath) var animatorPath
export (NodePath) var timerPath
export (NodePath) var questionHolderPath
export (NodePath) var scoreTextPath
export (NodePath) var trueButtonPath
export (NodePath) var falseButtonPath

onready var questionText = get_node(questionTextPath)
onready var animator = get_node(animatorPath)
onready var timer = get_node(timerPath)
onready var questionHolder = get_node(questionHolderPath)
onready var scoreText = get_node(scoreTextPath)
onready var trueButton = get_node(trueButtonPath)
onready var falseButton = get_node(falseButtonPath)

var score = 0

var answer = null

func _ready():
	randomize()
	set_question()
	
	$DialogManager/DialogBox.dialog = $DialogManager/DialogBox.load_dialog_file('res://MainLevels/Mass/Level2/dialogs.txt')
	$DialogManager/DialogBox.load_dialog($DialogManager/DialogBox.dialog)
	
	# init timer
	$TimerManager.setTime(60)
	
	# setup signal
	$DialogManager/DialogBox.connect("tree_exiting", self, "_on_dialogbox_tree_exiting")
	$TimerManager.connect("tree_exiting", self, "_on_timer_tree_exiting")
	
	$GameOverLayer.visible = false
	
	# reset points
	Global.points = 0
	
func set_question():
	var childAmount = questionHolder.get_child_count()
	var whichQuestion 
	
	if childAmount > 0:
		var rand_question = rand_range(0,questionText.get_child_count())
		whichQuestion = questionHolder.get_child(rand_question)
		
		questionText.set_text(whichQuestion.fact)
		answer = whichQuestion.answer
		print("Answer: ", answer)
	else:
		questionText.set_text(" The game has fineshed. Please press on close button")
		trueButton.disabled = true
		falseButton.disabled = true
		$Score.text = "Score: " + str(Global.getScore())
		_on_timer_tree_exiting()
	
	if whichQuestion != null:
		questionHolder.remove_child(whichQuestion)

func _on_timer_timeout():
	#animator.play_backwards(animator.get_current_animation())
	set_question()
	trueButton.disabled = false
	falseButton.disabled = false
	


func _on_trueButton_button_up():
	trueButton.disabled = true
	falseButton.disabled = true
	if answer == false:
		$wrong_SFX.play()
		$wrong_effect.emitting = true
		$wrong_effect.position = Vector2(256.333, 351.5)
	else:
		$correct_SFX.play()
		$correct_effect.emitting = true
		$correct_effect.position = Vector2(256.333, 351.5)
		Global.increaseScore(10)
		$Score.text = "Score: " + str(Global.getScore())
		
	#animator.play("trueSlide")
	timer.start()


func _on_falseButton_button_up():
	trueButton.disabled = true
	falseButton.disabled = true
	if answer == true:
		$wrong_SFX.play()
		$wrong_effect.emitting = true
		$wrong_effect.position = Vector2(786.122, 351.066)
	else:
		$correct_SFX.play()
		$correct_effect.emitting = true
		$correct_effect.position = Vector2(786.122, 351.066)
		Global.increaseScore(10)
		$Score.text = "Score: " + str(Global.getScore())
	#animator.play("falseSlide")
	timer.start()

func _on_dialogbox_tree_exiting():
	$TimerManager.timeStart()

func _on_timer_tree_exiting():
	$TimerManager.timePause()
	$GameOverLayer.visible = true
	$GameOverLayer/AnimationPlayer.play("Fade")
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	
func _process(delta):
	$Score.text = String(Global.getScore())
	$GameOverLayer/ColorRect/PlayerScore.text = String(Global.getScore())
	print("time used" + String($TimerManager.timeUsed()))
