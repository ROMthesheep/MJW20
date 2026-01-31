class_name GameplayManager extends Node

signal interactedWith(name)
signal startPainting(name)
signal startResolution(name)
signal switchFaces(name)

const DIALOG_HUD = preload("uid://cfcmje4xr0xu6")
const PAINTING_HUD = preload("uid://cukgpeh8k0lyb")

enum GameState { WANDERING, INTRO, PAINTING, RESOLUTION }
var gameState: GameState = GameState.WANDERING

func _ready() -> void:
	interactedWith.connect(_started_talking_intro)
	startPainting.connect(_no_mistakes_happy_accidents)
	startResolution.connect(_started_talking_resolution)
	
func _started_talking_intro(name: String):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var dialogHub := DIALOG_HUD.instantiate() as DialogHud
	dialogHub.empleado = DialogImporter.npcs.filter(func(npc): return npc.name == name)[0]
	dialogHub.isIntro = true
	get_tree().root.add_child(dialogHub)
	gameState = GameState.INTRO

func _no_mistakes_happy_accidents(name: String):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var instance := PAINTING_HUD.instantiate()
	instance.empleado = DialogImporter.npcs.filter(func(npc): return npc.name == name)[0]
	get_tree().root.add_child(instance)
	gameState = GameState.PAINTING

func _started_talking_resolution(name: String):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var dialogHub := DIALOG_HUD.instantiate() as DialogHud
	dialogHub.empleado = DialogImporter.npcs.filter(func(npc): return npc.name == name)[0]
	dialogHub.isIntro = false
	get_tree().root.add_child(dialogHub)
	gameState = GameState.RESOLUTION
	

func find_npc(npc, name) -> bool:
	return npc.name == name
