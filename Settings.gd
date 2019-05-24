extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  pass
  #$Tabs/Tab1/Chunks.

func _input(event):
  if Input.is_action_just_pressed("ui_cancel"):
    get_tree().change_scene("res://MainMenu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
