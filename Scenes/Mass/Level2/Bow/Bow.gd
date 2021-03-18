extends Node2D

const MAX_DISTANCE = 150

export(int) var elastic_factor = 4

var current_projectile = null
var launch_force := Vector2()
var velocity := Vector2()

onready var projectiles = get_tree().get_nodes_in_group("projectiles")
onready var rest = $RestPosition

func _ready():
	load_projectile()

func _process(delta):
	
	if current_projectile != null && current_projectile.isFire:
		# Update: delta is also needed here
		velocity += current_projectile.gravity_vec*current_projectile.gravity
		
		current_projectile.position += velocity*delta
		
		current_projectile.rotation = velocity.angle()

func load_projectile():
	if len(projectiles) > 0:
		current_projectile = projectiles.pop_back()
		current_projectile.global_position = rest.global_position
		

func _unhandled_input(event):
	if current_projectile == null:
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			_on_touch_pressed(event)
			get_tree().set_input_as_handled()
		else:
			_on_touch_released(event)
			get_tree().set_input_as_handled()
	if event is InputEventScreenDrag:
		_on_touch_drag(event)
		get_tree().set_input_as_handled()


func _on_touch_pressed(event: InputEventScreenTouch):
	pass


func _on_touch_released(event: InputEventScreenTouch):
	current_projectile.isFire = true
	velocity = Vector2(14,14) * launch_force * 0.8
	$ReloadTimer.start()


func _on_touch_drag(event: InputEventScreenDrag):
	launch_force = (rest.global_position - event.position).clamped(MAX_DISTANCE)
	current_projectile.position = rest.global_position - launch_force


func _on_ReloadTimer_timeout():
	load_projectile()


func _on_Back_pressed():
	get_tree().change_scene("res://MainLevels/GameWorld/topic-selection.tscn")
