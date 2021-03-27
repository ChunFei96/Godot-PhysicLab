extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass



func _on_Register_pressed():
	get_tree().change_scene("res://Scenes/Login/CreateAccount.tscn")

func _on_Mastery_pressed():
	get_tree().change_scene("res://Assets/Common/MasteryTopic.tscn")
	


func _on_Leaderboard_pressed() -> void:
	get_tree().change_scene("res://Assets/Common/Leaderboard.tscn")


func _on_SignOut_pressed() -> void:
	get_tree().change_scene("res://Scenes/Login/LoginRegister.tscn")


func _on_bgm_finished():
	$bgm.play()
	pass # Replace with function body.


func _on_Tlanding_tree_entered():
	$bgm.play()
	pass # Replace with function body.


func _on_Tlanding_tree_exiting():
	$bgm.stop()
	pass # Replace with function body.
