extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ChunkLoader = load("res://ChunkLoader.gd")
var chunkloader
# Called when the node enters the scene tree for the first time.
func _ready():
  Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  chunkloader = ChunkLoader.new()
  #chunkloader.AddChunk(0,0)
  #chunkloader.set_block(1,1,1,1)
  
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
