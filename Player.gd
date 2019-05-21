extends KinematicBody

export(float) var Sens=0.1
export(float) var Accel=0.1
export(float,0,1) var Friction=0.05

var pitch=0
var yaw=0
var mov=Vector3(0,0,0)

var hit={}

var collider
var colpos
var colnorm

func _ready():
  Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  
  
func test_ray():
  var ray=$Camera/RayCast
  if ray.is_colliding():
    hit["collider"]=ray.get_collider()
    hit["position"]=ray.get_collision_point()
    hit["normal"]=ray.get_collision_normal()
  else:
    hit={}
    
func _input(event):
  if event is InputEventMouseButton:
    if event.is_pressed():
      if not hit.size()==0 and hit.collider is StaticBody:
        print(hit)
        
  if event is InputEventMouseMotion:
    pitch -=event.relative.x*Sens
    yaw -=event.relative.y*Sens      

func _process(delta):
  test_ray()
  
  if Input.is_action_just_pressed("ui_cancel"):
    get_tree().quit()

  if Input.is_action_just_pressed("ui_focus_next"):
    if Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    else:
      Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
      
  if Input.is_action_pressed("ui_up"):
    mov -= $Camera.global_transform.basis.z*Accel
  if Input.is_action_pressed("ui_down"):
    mov += $Camera.global_transform.basis.z*Accel
  if Input.is_action_pressed("ui_left"):
    mov += -$Camera.global_transform.basis.x*Accel
  if Input.is_action_pressed("ui_right"):
    mov += $Camera.global_transform.basis.x*Accel
  if Input.is_action_pressed("jump"):
    mov += $Camera.global_transform.basis.y*Accel
  if Input.is_action_pressed("sneak"):
    mov += -$Camera.global_transform.basis.y*Accel

  if Input.is_action_pressed("reset"):
    get_tree().reload_current_scene()

  rotation.y=pitch
  $Camera.rotation.x=yaw
  
  move_and_slide(mov)
  mov=(1-Friction)*mov

  

    