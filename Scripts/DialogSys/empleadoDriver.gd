extends Node3D

func interact():
	gameplayManager.interactedWith.emit(name)
	gameplayManager.switchFaces.connect(check_incoming_face)

#func _ready() -> void:
	#change_face_to(load("res://icon.svg"))

func check_incoming_face(incoming_name):
	if incoming_name == name:
		var me = DialogImporter.npcs.filter(func(npc): return npc.name == incoming_name)[0]
		#var me = DialogImporter.npcs[DialogImporter.npcs.find_custom(func(npc): return npc.name == incoming_name)]
		change_face_to(me.cara_pintada)

func change_face_to(new_face) -> void:
	var meshThingy = ($model/Skeleton3D/meshymeshy as MeshInstance3D)
	var new_face_mat = meshThingy.mesh.surface_get_material(1) as BaseMaterial3D
	pass
	new_face_mat.albedo_texture = new_face
	pass
	($model/Skeleton3D/meshymeshy as MeshInstance3D).set_surface_override_material(1, new_face_mat)
