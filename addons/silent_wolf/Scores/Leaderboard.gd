tool
extends Node2D

const ScoreItem = preload("ScoreItem.tscn")
const SWLogger = preload("../utils/SWLogger.gd")

var list_index = 0
var reverse_index = 0
var rindex = 0
var ld_name = "main"
var reversed = false

func _ready():
	print("SilentWolf.Scores.leaderboards: " + str(SilentWolf.Scores.leaderboards))
	print("SilentWolf.Scores.ldboard_config: " + str(SilentWolf.Scores.ldboard_config))
	#var scores = SilentWolf.Scores.scores
	call_leaderboards()


func call_leaderboards():
	
	var scores = []
	if ld_name in SilentWolf.Scores.leaderboards:
		scores = SilentWolf.Scores.leaderboards[ld_name]
	var local_scores = SilentWolf.Scores.local_scores
	
	if len(scores) > 0: 
		add_loading_scores_message()
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
		hide_message()
		render_board(scores, local_scores)
	else:
		# use a signal to notify when the high scores have been returned, and show a "loading" animation until it's the case...
		add_loading_scores_message()
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
		hide_message()
		render_board(SilentWolf.Scores.scores, local_scores)

func render_board(scores, local_scores):
	var all_scores = scores
	if ld_name in SilentWolf.Scores.ldboard_config and is_default_leaderboard(SilentWolf.Scores.ldboard_config[ld_name]):
		all_scores = merge_scores_with_local_scores(scores, local_scores)
		if !scores and !local_scores:
			add_no_scores_message()
	else:
		if !scores:
			add_no_scores_message()
	if reversed == true:
		scores.invert()
	
	for score in scores:
		print(score)
		reverse_index = scores.size()  + 1
		add_item(score.player_name, str(int(score.score)), score.metadata.time)
		
func is_default_leaderboard(ld_config):
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return  default_insert_opt and not_time_based

func merge_scores_with_local_scores(scores, local_scores, max_scores=10):
	if local_scores:
		for score in local_scores:
			var in_array = score_in_score_array(scores, score)
			if !in_array:
				scores.append(score)
			scores.sort_custom(self, "sort_by_score");
	var return_scores = scores
	if scores.size() > max_scores:
		return_scores = scores.resize(max_scores)
	return return_scores
	
	#sort scores 
func sort_by_score(a, b):
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;
	
func score_in_score_array(scores, new_score):
	var in_score_array =  false
	if new_score and scores:
		for score in scores:
			if score.score_id == new_score.score_id: # score.player_name == new_score.player_name and score.score == new_score.score:
				in_score_array = true
	return in_score_array

func add_item(player_name, score,metadata):
	var item = ScoreItem.instance()
	list_index += 1
	reverse_index -= list_index 
	if reversed:
		item.get_node("Index").text = str(reverse_index) + str(". ") 
	else:
		item.get_node("Index").text = str(list_index) + str(". ") 
	item.get_node("Score").text = score
	item.get_node("Player").text = player_name
	item.get_node("time").text = str(metadata) + str("s")
	item.margin_top = list_index * 100
	$"Board/HighScores/ScoreItemContainer".add_child(item)

func add_no_scores_message():
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "No scores yet!"
	$"Board/MessageContainer".show()
	item.margin_top = 135
	
func add_loading_scores_message():
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "Loading scores..."
	$"Board/MessageContainer".show()
	item.margin_top = 135
	
func hide_message():
	$"Board/MessageContainer".hide()

func filter():
	reversed = !reversed
	for child in $Board/HighScores/ScoreItemContainer.get_children():
		child.queue_free()
	list_index = 0
	call_leaderboards()

func _on_CloseButton_pressed():
	var scene_name = SilentWolf.scores_config.open_scene_on_close
	SWLogger.info("Closing SilentWolf leaderboard, switching to scene: " + str(scene_name))
	#global.reset()
	get_tree().change_scene(scene_name)


func _on_score_pressed():
	filter()
	pass # Replace with function body.


func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
