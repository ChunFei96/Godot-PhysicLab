extends Control

export (NodePath) var questionTextPath
export (NodePath) var trueAnswerPath
export (NodePath) var falseAnswerPath
export (NodePath) var animatorPath
export (NodePath) var timerPath
export (NodePath) var questionHolderPath
export (NodePath) var scoreTextPath
export (NodePath) var trueButtonPath
export (NodePath) var falseButtonPath

onready var questionText = get_node(questionTextPath)
onready var trueAnswer = get_node(trueAnswerPath)
onready var falseAnswer = get_node(falseAnswerPath)
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
	
func set_question():
	var childAmount = questionHolder.get_child_count()
	var whichQuestion 
	
	if childAmount > 0:
		whichQuestion = questionHolder.get_child(rand_range(0,5))
		questionText.set_text(whichQuestion.fact)
		answer = whichQuestion.answer
	else:
		questionText.set_text(" The game has fineshed. Please press on close button")
		trueButton.disabled = true
		falseButton.disabled = true
		scoreText.set_text ("Score: " + str(score))
	
	if whichQuestion != null:
		questionHolder.remove_child(whichQuestion)

func _on_timer_timeout():
	#animator.play_backwards(animator.get_current_animation())
	set_question()
	


func _on_trueButton_button_up():
	if answer == false:
		trueAnswer.set_text("Wrong")
	else:
		trueAnswer.set_text("Correct")
		score += 1
		scoreText.set_text("Score: " + str(score))
	#animator.play("trueSlide")
	timer.start()


func _on_falseButton_button_up():
	if answer == true:
		falseAnswer.set_text("Wrong")
	else:
		falseAnswer.set_text("Correct")
		score += 1
		scoreText.set_text("Score: " + str(score))
	#animator.play("falseSlide")
	timer.start()
