extends Node

var npcs: Array[Empleado] = []

func _ready() -> void:
	var data = preload("res://Assets/Dialogos - MJW20 - Hoja 1.csv")
	(data.records as Array).remove_at(0)
	print(data.records)
	print(data.records[1].slice(1,len(data.records[1])))
	for currito in data.records:
		var empleado = Empleado.new()
		empleado.name = currito[0]
		empleado.color = Color(float(currito[1]),float(currito[2]),float(currito[3]))
		for dialogo in currito.slice(4, len(currito)):
			if not (dialogo as String).is_empty():
				empleado.dialogs.append(dialogo)
		npcs.append(empleado)
	print("JA!")
