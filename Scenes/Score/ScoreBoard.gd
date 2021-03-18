extends Node2D


var PlayerScore = 0
var PlayerName = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func recordScore(score):#stage 1 to 4 = 0 to 3, combined = 4
	return score

func sendScore(): #send score and name to the database
	pass

func getScore(): #get score from database
	pass
	
func getName(): #get name from database
	pass
	
func increaseScore(value):
	PlayerScore += value
	pass

func _on_Button_pressed():
	increaseScore(100)
	$Player1Score.set_bbcode(str(recordScore(PlayerScore)))
	pass # Replace with function body.
