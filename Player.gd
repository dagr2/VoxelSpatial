extends KinematicBody

export(float) var Sens=0.01
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
  
  $Camera/Cross.position.x=OS.window_size.x/2
  $Camera/Cross.position.y=OS.window_size.y/2
  
  
func test_ray():
  var ray=$Camera/RayCast
  var target=get_parent().get_node("Target")
  if ray.is_colliding():
    target.show()
    hit["collider"]=ray.get_collider()
    hit["position"]=ray.get_collision_point()
    hit["normal"]=ray.get_collision_normal()
    target.translation=ray.get_collision_point()
  else:
    target.hide()
    hit={}
    
    
func _input(event):
  if event is InputEventMouseButton:
    if event.pressed:
      var button = event.button_index
      if not hit.size()==0 and hit.collider is StaticBody:
        hit.button=button
        if hit.collider.has_method("clicked_at"):
          hit.collider.clicked_at(hit)
        print(hit)
        
  if event is InputEventMouseMotion:
    pitch -=event.relative.x*Sens*.1
    yaw -=event.relative.y*Sens*.1
    if hit.size()==0:
      $Label2.text=""
    else:      
      $Label2.text=str(hit.position)  

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
  #$Label.text=str(translation)+", "+str(pitch)+", "+str(yaw)
  $Label.text=str(hit)
  

  

    