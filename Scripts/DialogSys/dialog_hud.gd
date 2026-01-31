class_name DialogHud extends Control

@export var empleado: Empleado
var _currentdialog: String
var _currentdialogIndex := 0
var text_is_showing := true

func _ready() -> void:
	$VBoxContainer/Label.text = empleado.name
	_currentdialog = empleado.dialogs[0]
	$TextureRect.modulate = empleado.color
	$VBoxContainer/Dialog.text = _currentdialog

func strip_bbcode(source:String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.+?\\]")
	return regex.sub(source, "", true)

func _on_timer_timeout() -> void:
	if len(strip_bbcode($VBoxContainer/Dialog.text)) >= $VBoxContainer/Dialog.visible_characters:
		if _currentdialog[$VBoxContainer/Dialog.visible_characters - 1] != " ":
			$AudioStreamPlayer.play()
		$VBoxContainer/Dialog.visible_characters += 1
		text_is_showing = len(strip_bbcode($VBoxContainer/Dialog.text)) >= $VBoxContainer/Dialog.visible_characters
		

func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.keycode == KEY_SPACE and event.pressed) and not event.is_echo():
		_currentdialogIndex += 1
		$VBoxContainer/Dialog.visible_characters = 0
		if _currentdialogIndex >= len(empleado.dialogs):
			queue_free()
		else:
			_currentdialog = empleado.dialogs[_currentdialogIndex]
			$VBoxContainer/Dialog.text = _currentdialog
			if _currentdialog[0] == "@":
				$VBoxContainer/Label.hide()
			else:
				$VBoxContainer/Label.show()
