extends KinematicBody

export(float) var Sens=0.01
export(float) var Accel=0.001
export(float,0,1) var Friction=0.1
export(float) var GRAV=0.5
export(float) var JUMP=15.0

var pitch=0
var yaw=0
var mov=Vector3(0,0,0)
var grav_on=false

var hit={}

var collider
var colpos
var colnorm
var game
func _ready():
  #Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  global_settings.player=self

  $Camera/Cross.position.x=OS.window_size.x/2
  $Camera/Cross.position.y=OS.window_size.y/2
  game=get_parent()
  
func test_ray():
  var ray=$Camera/RayCast
  var target=get_parent().get_node("Target")
  if ray.is_colliding():
    #target.show()
    hit["collider"]=ray.get_collider()
    hit["position"]=ray.get_collision_point()
    hit["normal"]=ray.get_collision_normal()
    target.translation=ray.get_collision_point()
  else:
    #target.hide()
    hit={}
    
var slot=0

func _input(event):
  if event is InputEventKey:
    if event.pressed and event.scancode==KEY_G:
        grav_on = !grav_on
        
  if event is InputEventMouseButton:
    #print(event)
    if Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE:
      return

    if event.pressed:
      var button = event.button_index
      if button==BUTTON_LEFT or button==BUTTON_RIGHT:
        if not hit.size()==0 and hit.collider is StaticBody:
          hit.button=button
          hit.slot=slot
          if hit.collider.has_method("clicked_at"):
            hit.collider.clicked_at(hit)
          print(hit)
          
      if event.button_index==BUTTON_WHEEL_UP:
        if slot<9:
          slot+=1      
          $Inv.slot=slot
      if event.button_index==BUTTON_WHEEL_DOWN:
        if slot>0:
          slot -= 1
          $Inv.slot=slot
                 
  if event is InputEventMouseMotion:
    pitch -=event.relative.x*Sens*.1
    yaw -=event.relative.y*Sens*.1
    if hit.size()==0:
      $Label2.text=""
    else:      
      $Label2.text=str(hit.position)  

func _process(delta):
    pass
    
func _physics_process(delta):
  #$Camera/Cross.position.x=OS.window_size.x/2
  #$Camera/Cross.position.y=OS.window_size.y/2

  if Input.is_action_just_pressed("ui_focus_next"):
    if Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    else:
      Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    
  if Input.is_action_just_pressed("ui_cancel"):
    get_tree().change_scene("res://MainMenu.tscn")
            
  if Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE:
    return
    
  test_ray()
  
  if Input.is_action_just_pressed("light"):
    $Camera/SpotLight.visible = !$Camera/SpotLight.visible
  if Input.is_action_pressed("ui_up"):
    mov -= $Camera.global_transform.basis.z*Accel
  if Input.is_action_pressed("ui_down"):
    mov += $Camera.global_transform.basis.z*Accel
  if Input.is_action_pressed("ui_left"):
    mov += -$Camera.global_transform.basis.x*Accel
  if Input.is_action_pressed("ui_right"):
    mov += $Camera.global_transform.basis.x*Accel
  if Input.is_action_pressed("jump"):
    if grav_on:
        if is_on_floor():
            mov += Vector3(0,JUMP,0)
    else:
        mov += $Camera.global_transform.basis.y*Accel
  if Input.is_action_pressed("sneak"):
    mov += -$Camera.global_transform.basis.y*Accel    

  if Input.is_action_pressed("reset"):
    get_tree().reload_current_scene()
  if Input.get_mouse_mode()==Input.MOUSE_MODE_VISIBLE:
    return
  rotation.y=pitch
  $Camera.rotation.x=yaw
  if grav_on and not is_on_floor():
    mov += Vector3(0,-GRAV,0)
    
  move_and_slide(mov,Vector3(0,1.0,0))
  mov=(1-Friction)*mov
  #$Label.text=str(translation)+", "+str(pitch)+", "+str(yaw)
  $Label.text=str(hit)
  

  

    