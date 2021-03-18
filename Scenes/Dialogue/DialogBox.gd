extends Control

var dialog = []

var dialog_index = 0
var finished = false

func _ready():
	pass
	

func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog(dialog)
	
func load_dialog(dialog):
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	dialog_index += 1

func load_dialog_file(filepath):
	var result = []
	var f = File.new()
	if not f.file_exists(filepath):
		return
	f.open(filepath, File.READ)
	var index = 1
	while not f.eof_reached():
		var line = f.get_line()
		result.append(line)
		index += 1
	return result
	f.close()


func _on_Tween_tween_completed(object, key):
	finished = true
