extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var arr={}
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    
func _input(event):
    if event is InputEventKey and event.pressed:
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
