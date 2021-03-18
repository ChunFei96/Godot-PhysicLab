extends Node2D

var DisplayValue = 0 
var totalTime
onready var timer = get_node("Timer")
onready var label = get_node("label")

# Called when the node enters the scene tree for the first time.
func _ready():
	initTimer(10)
	showTimer()
	startTimer()
	pass # Replace with function body.


func initTimer(time):
	totalTime = time
	timer.set_wait_time(time)
	pass

func getTotalTime():
	print('totalTime: ' + str(totalTime))
	return totalTime

func showTimer():
	label.text = str(getTotalTime()) + " seconds"
	pass
	
func startTimer():
	timer.start()
	DisplayValue = totalTime
	pass

func stopTimer():
	timer.stop()


func _on_Timer_timeout():
	DisplayValue -= 1
	print(DisplayValue)
	pass # Replace with function body.
