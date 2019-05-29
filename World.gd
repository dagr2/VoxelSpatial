extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var arr={}
#var octree = preload("res://Octree.gd").new()
# Called when the node enters the scene tree for the first time.
var last_mouse_mode

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    last_mouse_mode=Input.get_mouse_mode()
    
func _input(event):
    $Menu.visible = Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE
    
    if Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE:
      return
    
    if event is InputEventKey and event.pressed:
        if event.scancode==KEY_F1:
          last_mouse_mode=Input.get_mouse_mode()
          Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
          $OpenDialog.invalidate()
          $OpenDialog.filename=""
          $OpenDialog.popup_centered()
         
          #$Level.load_chunk()
          
        if event.scancode==KEY_F2:
          last_mouse_mode=Input.get_mouse_mode()
          Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
          $SaveDialog.invalidate()
          $SaveDialog.filename=""
          $SaveDialog.popup_centered()
          #$Level.load_chunk()

          
        if event.scancode==KEY_F1:
            pass
          #$Level.load_chunk()      
        
        if Input.is_action_just_pressed("toggle_fullscreen"):
            OS.window_fullscreen = !OS.window_fullscreen              
            $Player/Camera/Cross.position= get_viewport().size/2.0# OS.window_size/2.0
            
        if event.scancode==KEY_F2:
            pass
          #$Level.save_chunk()


        if event.scancode==KEY_0:
          arr[0]="0"
        
        if event.scancode==KEY_1:
          arr[1]="1"
          arr[[1,1,1]]=1
          arr[Vector3(1,1,1)]=1
        if event.scancode==KEY_2:
          arr[2]="2"
          print(arr.has([1,1,1]))
          print(arr.has(Vector3(1,1,1)))
        if event.scancode==KEY_3:
          arr[3]="3"
        print(arr)  

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_OpenDialog_file_selected(path):
    $Level.load_chunk(path)
    Input.set_mouse_mode(last_mouse_mode)


func _on_SaveDialog_file_selected(path):
    $Level.save_chunk(path)
    Input.set_mouse_mode(last_mouse_mode)
