extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  #get_node("Tabs/SettingTab1/cntChunks/scrlChunks").value=get_node("/root/global_settings").vchunks
  pass
  #$Tabs/Tab1/Chunks.

func _input(event):
  if Input.is_action_just_pressed("ui_cancel"):
    get_tree().change_scene("res://MainMenu.tscn")



func _on_scrlChunks_scrolling():
    var val=get_node("Tabs/SettingTab1/cntChunks/scrlChunks").value
    get_node("/root/global_settings").vchunks=val
    get_node("Tabs/SettingTab1/cntChunks/lblChunkCount").text=str(val)
