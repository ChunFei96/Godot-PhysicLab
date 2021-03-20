extends AnimatedSprite

var isRescue = false
export (int) var rescueRate = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isRescue:
		$RescueBar.value += delta * rescueRate
		if $RescueBar.value >= 100:
			queue_free()


func _on_CatArea_area_entered(area):
	if area.name == "LightDetection":
		$RescueBar.visible = true
		isRescue = true;


func _on_CatArea_area_exited(area):
	$RescueBar.value = 0
	$RescueBar.visible = false
	isRescue = false;

func _on_Cat_tree_exiting():
	Global.increaseScore(100)
