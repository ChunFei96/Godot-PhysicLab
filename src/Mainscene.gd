extends Node2D



#var LeaderBoard = preload("res://addons/silent_wolf/Scores/Leaderboard.tscn")

func _ready():
#	SilentWolf.Scores.wipe_leaderboard()
	pass

func add_score(): #this adds the score to the leaderboard online
	var player_name = $Menu/details/Name.text
	var score = $Menu/details/value.text
	var ld_name = 'main'
	var time = $Menu/details/time.text
	var metadata = {
		'time': time
	}
	yield(SilentWolf.Scores.persist_score(player_name, int(score),ld_name, metadata),"sw_score_posted")
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
	pass

func _on_Button_pressed():
#	$Menu.hide()
	add_score()
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
	pass # Replace with function body.
