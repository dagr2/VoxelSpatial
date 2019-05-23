extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var arr={}
#var octree = preload("res://Octree.gd").new()
# Called when the node enters the scene tree for the first time.
func _ready():
    pass#octree.set_block(Vector3(2,4,1),1)
    
func _input(event):
    if event is InputEventKey and event.pressed:
          
          
        if event.scancode==KEY_F1:
          $Level.load_chunk()
          
        if event.scancode==KEY_F2:
          $Level.save_chunk()

        if event.scancode==KEY_F5:
          OS.window_fullscreen = !OS.window_fullscreen

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
