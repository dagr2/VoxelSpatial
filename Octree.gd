extends Node

var root=null
export(Vector3) var position=Vector3(0,0,0)
export(Vector3) var size=Vector3(16,16,16)

class Octet:
  var subs={}
  var block=0
  export(Vector3) var position
  export(Vector3) var size
  
  func get_blocks():
    var res=[]
    if block>0:
      var b={}
      b.pos=position
      b.value=block
      res.append(b)
    else:
      for p in subs:
        for bb in subs[p].get_blocks():
          res.append(bb)
    return res
  
  func _init(pos,s):
    position=pos
    size=s
    
  func get_block(pos):
    var sx
    var sy
    var sz
    if pos.x>=position.x and pos.x<=position.x+size.x and pos.y>=position.y and pos.y<=position.y+size.y and pos.z>=position.z and pos.z<=position.z+size.z:
      if pos.z>=position.z+size.z/2:
        sz=1
      else:
        sz=0
      if pos.y>=position.y+size.y/2:
        sy=1
      else:
        sy=0
      if pos.x>=position.x+size.x/2:
        sx=1
      else:
        sx=0
      if size.x<2 and size.y<2 and size.z<2:
        return block
      else:
        if not subs.has([sx,sy,sz]):
          return 0
        else:
          return subs[[sx,sy,sz]].get_block(pos)
    else:
      #print(str(pos)+" is not in")
      return 0
  
  func set_block(pos,val):
    var sx
    var sy
    var sz
    if pos.x>=position.x and pos.x<=position.x+size.x and pos.y>=position.y and pos.y<=position.y+size.y and pos.z>=position.z and pos.z<=position.z+size.z:
      if pos.z>=position.z+size.z/2:
        sz=1
      else:
        sz=0
      if pos.y>=position.y+size.y/2:
        sy=1
      else:
        sy=0
      if pos.x>=position.x+size.x/2:
        sx=1
      else:
        sx=0
      if size.x<2 and size.y<2 and size.z<2:
        block=val
      else:
        if not subs.has([sx,sy,sz]):
          subs[[sx,sy,sz]]=Octet.new(Vector3(position.x+sx*size.x/2.0,position.y+sy*size.y/2.0,position.z+sz*size.z/2.0),Vector3(size.x/2.0,size.y/2.0,size.z/2.0))
        subs[[sx,sy,sz]].set_block(pos,val)
    else:
      print(str(pos)+" is not in")
  
func _init(pos,s):
  position=pos
  size=s
  
func set_block(pos,val):
  if root==null:
    root=Octet.new(position,size)
  root.set_block(pos,val)
  
func get_block(pos):
  if root==null:
    return 0
  else:
    return root.get_block(pos)
    
func clear():
  root=Octet.new(position,size)
      
func get_blocks():
  var res=[]
  if root!=null:
    res=root.get_blocks()
  return res

func _ready():
    pass # Replace with function body.
