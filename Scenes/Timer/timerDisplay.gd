extends Control


var s = 30
var t = 0
var active = false

# Called when the node enters the scene tree for the first time.
func _process(delta):

	if s == 0:
		timePause()
		queue_free()
	$TimerDisplay.set_text( str(s) + " Seconds")

func setTime(time):
	s = time
	pass

func timeStart():
	active = true
	pass

func timePause():
	active = false
	pass

func timeLeft():
	return s
	

func timeUsed():
	return t

func _on_ms_timeout():
	if active == true:
		s -= 1
		t += 1
	pass # Replace with function body.

func ClearTimer():
	t = 0
	pass

func _on_Button_pressed(): #triggering portion
	timeLeft()
	timeUsed()
	pass # Replace with function body.


func _on_Button2_pressed(): #reset current timer
	setTime(30)
	ClearTimer()
	pass # Replace with function body.


func _on_Button3_pressed(): #cleared all records
	timeStart()
	pass # Replace with function body.

func _on_Button4_pressed():
	timePause()
	pass # Replace with function body.

