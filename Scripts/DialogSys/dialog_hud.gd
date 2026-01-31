class_name DialogHud extends Control

@export var empleado: Empleado
@export var isIntro: bool
var _currentdialog: String
var _currentdialogIndex := 0
var text_is_showing := true

func _ready() -> void:
	$Label.text = empleado.name
	_currentdialog = empleado.intro[0] if isIntro else empleado.resolution[0]
	$TextureRect.modulate = empleado.color
	$Dialog.text = _currentdialog

func strip_bbcode(source:String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.+?\\]")
	return regex.sub(source, "", true)

func _on_timer_timeout() -> void:
	if len(strip_bbcode($Dialog.text)) >= $Dialog.visible_characters:
		if _currentdialog[$Dialog.visible_characters - 1] != " ":
			$AudioStreamPlayer.play()
		$Dialog.visible_characters += 1
		text_is_showing = len(strip_bbcode($Dialog.text)) >= $Dialog.visible_characters
		

func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.keycode == KEY_SPACE and event.pressed) and not event.is_echo():
		_currentdialogIndex += 1
		$Dialog.visible_characters = 0
		if _currentdialogIndex >= len(empleado.intro if isIntro else empleado.resolution):
			if isIntro:
				gameplayManager.startPainting.emit(empleado.name)
			else:
				gameplayManager.gameState = gameplayManager.GameState.WANDERING
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			queue_free()
		else:
			if (empleado.intro[_currentdialogIndex] if isIntro else empleado.resolution[_currentdialogIndex])[0] == "@":
				$Label.hide()
				$LeHablo.show()
				$MeHablan.hide()
				$TextureRect.modulate = Color.DARK_GRAY
				_currentdialog = empleado.intro[_currentdialogIndex] if isIntro else empleado.resolution[_currentdialogIndex]
				_currentdialog = _currentdialog.erase(0)
			elif (empleado.intro[_currentdialogIndex] if isIntro else empleado.resolution[_currentdialogIndex])[0] == "$":
				$Label.hide()
				$LeHablo.show()
				$MeHablan.hide()
				$TextureRect.modulate = Color.DARK_GRAY
				_currentdialog = empleado.intro[_currentdialogIndex] if isIntro else empleado.resolution[_currentdialogIndex]
				_currentdialog = _currentdialog.erase(0)
				_currentdialog = "[wave][i]" + _currentdialog + "[/i][/wave]"
			else:
				$Label.show()
				$LeHablo.hide()
				$MeHablan.show()
				$TextureRect.modulate = empleado.color
				_currentdialog = empleado.intro[_currentdialogIndex] if isIntro else empleado.resolution[_currentdialogIndex]
			$Dialog.text = _currentdialog
