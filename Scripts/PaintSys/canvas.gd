extends Sprite2D

@export var paint_color := Color.CYAN
@export var brush_size := 6

var img: Image
var currentMode: PaintMode = PaintMode.NONE

const _sello1 = preload("uid://d0li3jh55ek1g")
const _sello2 = preload("uid://mgk8x0743nig")
const _sello3 = preload("uid://baxrfqh2tbmrp")
const _sello4 = preload("uid://bjy1sew6vstj2")
const _sello5 = preload("uid://cbks0f2b166o3")
const _sello6 = preload("uid://buy2r7x11v064")

enum PaintMode {FLOR, PATITA, MARIQUITA, SOLECITO, CONEJITO, MONKE, NONE}

func _ready() -> void:
	img = Image.create_empty(int(get_viewport().get_visible_rect().size.y), int(get_viewport().get_visible_rect().size.y), false, Image.FORMAT_RGBA8)
	#img.fill(Color(0,0,0,0))
	#img.fill(Color.CYAN)
	var face_file = ("res://Assets/Caras/%s.png" % get_parent().empleado.name) as String
	img = load(face_file).get_image()
	img.decompress()
	texture = ImageTexture.create_from_image(img)

func _paint(pixel_point) -> void:
	img.fill_rect(Rect2i(pixel_point, Vector2i(1,1)).grow(brush_size), paint_color)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
			var local_position := to_local(event.position)
			var image_position := local_position + get_rect().size/2.0
			if currentMode == PaintMode.NONE:
				_paint(image_position)
			else:
				var selectedStamp
				match currentMode:
					PaintMode.FLOR:
						selectedStamp = _sello1
					PaintMode.PATITA:
						selectedStamp = _sello2
					PaintMode.MARIQUITA:
						selectedStamp = _sello3
					PaintMode.SOLECITO:
						selectedStamp = _sello4
					PaintMode.CONEJITO:
						selectedStamp = _sello5
					PaintMode.MONKE:
						selectedStamp = _sello6
				var stamp_img = selectedStamp.get_image()
				var sello_position = Vector2(image_position.x - stamp_img.get_size().x/2,image_position.y - stamp_img.get_size().y/2)
				img.blend_rect(stamp_img, Rect2i(Vector2.ZERO, stamp_img.get_size()), sello_position)
						
			texture.update(img)
	if event is InputEventMouseMotion and currentMode == PaintMode.NONE:
		if event.button_mask == MOUSE_BUTTON_LEFT:
				var local_position := to_local(event.position)
				var image_position := local_position + get_rect().size/2.0
				if event.relative.length_squared() > 0:
					var num = ceil(event.relative.length())
					var target_position = image_position - event.relative
					for i in num:
						image_position = image_position.move_toward(target_position, 1.0)
						_paint(image_position)
				texture.update(img)


func _on_black_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.BLACK

func _on_gold_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.GOLD


func _on_gray_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.GRAY


func _on_brown_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.BROWN


func _on_purple_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.MEDIUM_PURPLE


func _on_light_blue_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.LIGHT_BLUE


func _on_dark_green_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.DARK_GREEN


func _on_light_green_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.LIGHT_GREEN


func _on_red_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.RED


func _on_oranje_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.ORANGE


func _on_yellow_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.YELLOW


func _on_white_crayon_button_pressed() -> void:
	currentMode = PaintMode.NONE
	paint_color = Color.WHITE


func _on_sello_flor_button_pressed() -> void:
	currentMode = PaintMode.FLOR


func _on_sello_patita_button_pressed() -> void:
	currentMode = PaintMode.PATITA


func _on_sello_mariquita_button_pressed() -> void:
	currentMode = PaintMode.MARIQUITA


func _on_sello_solecito_button_pressed() -> void:
	currentMode = PaintMode.SOLECITO


func _on_sello_conejito_button_pressed() -> void:
	currentMode = PaintMode.CONEJITO


func _on_sello_monke_button_pressed() -> void:
	currentMode = PaintMode.MONKE
