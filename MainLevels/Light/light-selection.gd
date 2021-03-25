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


func _on_CatBtn_pressed() -> void:
	get_tree().change_scene("res://MainLevels/Light/Cat/Cat.tscn")


func _on_QuizBtn_pressed() -> void:
	get_tree().change_scene("res://Scenes/Light/Quiz/mainScene.tscn")


func _on_Back_pressed() -> void:
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
