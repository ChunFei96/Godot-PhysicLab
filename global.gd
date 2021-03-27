extends Node

onready var Database =  preload("res://Scenes/API/Database.gd")

var username
var playerID
var SelectedCharacter
var points = 0
var role = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func getScore(): #get score from database
	return points
	
func increaseScore(value):
	points += value
	
func getUsername():
	return username
	
func setUsername(usrname):
	username = usrname
	print('username: ' + str(getUsername()))
	
func getSelectedCharacter():
	return SelectedCharacter
	
func setSelectedCharacter(selectedChar):
	SelectedCharacter = selectedChar
	#print('SelectedCharacter: ' + str(getSelectedCharacter()))
	
func getPlayerID():
	return playerID
	
func setPlayerID(id):
	playerID = id
	#print('username: ' + str(getPlayerID()))

func init_user():
	pass

func getRole():
	return role

func setRole(r):
	role = r
	#print('set global role: ' + r)

