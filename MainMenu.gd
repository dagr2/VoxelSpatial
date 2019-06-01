extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    
func _input(event):
    if event is InputEventKey and event.pressed:
        if Input.is_action_just_pressed("ui_cancel"):
            get_tree().quit()
            
        if Input.is_action_just_pressed("toggle_fullscreen"):
            OS.window_fullscreen = !OS.window_fullscreen
        
func _on_BtnPaint_pressed():
    get_tree().change_scene("res://World.tscn")

func _on_BtnExit_pressed():
    get_tree().quit()

func _on_BtnPlay_pressed():
    get_tree().change_scene("res://Game.tscn")

func _on_BtnSettings_pressed():
  get_tree().change_scene("res://Settings.tscn")
