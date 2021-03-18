extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# init dialog 
	$DialogManager/DialogBox.dialog = $DialogManager/DialogBox.load_dialog_file('res://MainLevels/Mass/Level2/dialogs.txt')
	$DialogManager/DialogBox.load_dialog($DialogManager/DialogBox.dialog)
	
	# init timer
	$TimerManager.setTime(60)
	
func _process(delta):
	if not is_instance_valid(get_node("DialogManager/DialogBox")) && is_instance_valid(get_node("TimerManager")):
		$TimerManager.timeStart()
	
	#if not is_instance_valid(get_node("TimerManager")):
	#	print("Time up")
	pass

