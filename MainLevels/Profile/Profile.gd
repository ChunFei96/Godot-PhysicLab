extends Control

onready var Data =  preload("Data.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	var data = JSON.parse(Data.new().data2)
	
	#Get your text fields
	var name = get_node("Name")
	var email = get_node("Email")
	var age = get_node("Age")
	var city = get_node("City")
	
	#Display result as JSON
	print("Json result: " + str(data.result))
	
	#Get Property's value from data.result
	var getName = str(data.result['name'])
	var getEmail = str(data.result['email'])
	var getAge = str(data.result['age'])
	var getCity = str(data.result['city'])
	
	#Print result to "Output" console
	print("Name2: " + getName)
	print("Email2: " + getEmail)
	print("Age2: " + getAge)
	print("City2: " + getCity)
	
	#Update UI's text fields  
	name.text = getName
	email.text = getEmail
	age.text = getAge
	city.text = getCity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
