extends Spatial

var ChunkLoader=load("res://ChunkLoader2.gd")
var chunkloader

func _ready():
  #Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  chunkloader = ChunkLoader.new()
  add_child(chunkloader)

func get_chunkloader():
  return chunkloader
    
func _input(event):
    if $Settings.visible:
        if Input.is_action_just_pressed("ui_cancel"):
            $Settings.visible=false
    else:
        if Input.is_action_just_pressed("toggle_fullscreen"):
            OS.window_fullscreen = !OS.window_fullscreen  
            $Player/Camera/Cross.position= OS.window_size/2.0
            
        if event is InputEventKey and event.is_pressed():
            if event.scancode==KEY_F1:
                $Settings.visible=true   
