extends Node

var npcs: Array[Empleado] = []

func _ready() -> void:
	var data = preload("res://Assets/Dialogos - MJW20 - Hoja 1.csv")
	(data.records as Array).remove_at(0)
	for currito in data.records:
		var empleado = Empleado.new()
		empleado.name = currito[0]
		empleado.cara = load("res://Assets/Caras/%s.png" % currito[0])
		empleado.color = Color(float(currito[1]),float(currito[2]),float(currito[3]))
		var halfPoint = currito.find("Painting")
		for dialogo in currito.slice(4, halfPoint):
			if not (dialogo as String).is_empty():
				empleado.intro.append(dialogo)
		for dialogo in currito.slice(halfPoint + 1, len(currito)):
			if not (dialogo as String).is_empty():
				empleado.resolution.append(dialogo)
		npcs.append(empleado)
	pass
