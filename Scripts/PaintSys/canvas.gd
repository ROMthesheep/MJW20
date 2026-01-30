extends Sprite2D

@export var paint_color := Color.CYAN
@export var img_size := Vector2i(800, 800)
@export var brush_size := 3

var img: Image 

func _ready() -> void:
	img = Image.create_empty(int(get_viewport().get_visible_rect().size.x), int(get_viewport().get_visible_rect().size.y), false, Image.FORMAT_RGBA8)
	img.fill(Color(0,0,0,0))
	texture = ImageTexture.create_from_image(img)

func _paint(pixel_point) -> void:
	img.fill_rect(Rect2i(pixel_point, Vector2i(1,1)).grow(brush_size), paint_color)
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
				var local_position := to_local(event.position)
				var image_position := local_position + get_rect().size/2.0
				_paint(image_position)
				texture.update(img)
	if event is InputEventMouseMotion:
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
