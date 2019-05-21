tool
extends StaticBody

export(float) var BlockWidth=1.0/8

var blocks = {}
var mat = preload("res://mat1.tres")

func _ready():
  SetBlock(3,3,3,1)


func get_side(norm):
    if norm==Vector3(0,1,0):
        return 0
    if norm==Vector3(0,-1,0):
        return 1
    if norm==Vector3(0,0,-1):
        return 2
    if norm==Vector3(0,0,1):
        return 3
    if norm==Vector3(-1,0,0):
        return 4
    if norm==Vector3(1,0,0):
        return 5

func clicked_at(hit):
  var pos=hit.position
  var lpos=to_local(pos)

  var norm=hit.normal
  var center = lpos-norm*BlockWidth/2.0
  var bpos=Vector3(round(center.x),round(center.y),round(center.z))
  var bnum=Vector3(round(center.x*8),round(center.y*8),round(center.z*8))
  var side=get_side(norm)
  if side==0:
    SetBlock(bnum.x,bnum.y+1,bnum.z,1)
  if side==1:
    SetBlock(bnum.x,bnum.y-1,bnum.z,1)
  if side==2:
    SetBlock(bnum.x,bnum.y,bnum.z-1,1)
  if side==3:
    SetBlock(bnum.x,bnum.y,bnum.z+1,1)
  if side==4:
    SetBlock(bnum.x-1,bnum.y,bnum.z,1)
  if side==5:
    SetBlock(bnum.x+1,bnum.y,bnum.z,1)

  print("Global pos: "+str(pos))
  print("Local pos: "+str(lpos))
  print("Center pos: "+str(center))
  print("Block pos: "+str(bpos))
  print("Block num: "+str(bnum))

  #BuildGeometry()

func SetBlock(x,y,z,v):
  blocks[str(x)+","+str(y)+","+str(z)]=v
  BuildGeometry()
  
func GetBlock(x,y,z):
  if blocks.has(str(x)+","+str(y)+","+str(z)):
    return blocks[str(x)+","+str(y)+","+str(z)]
  else:
    return 0
    
func BuildGeometry():
  var verts=[]
  var cnt=8
  var w=BlockWidth # 1.0/cnt
  var w2=w/2.0

  
  for z in range(-10*cnt,10*cnt):
    for y in range(-10*cnt,10*cnt):
      for x in range(-10*cnt,10*cnt):
        var b=GetBlock(x,y,z)
        var btop=GetBlock(x,y+1,z)
        var bbot=GetBlock(x,y-1,z)
        var bfront=GetBlock(x,y,z-1)
        var bback=GetBlock(x,y,z+1)
        var bleft=GetBlock(x-1,y,z)
        var bright=GetBlock(x+1,y,z)
        
        #top
        if b>0 and btop<1:
          verts.append(Vector3( w*x-w2, y*w+w2, w*z-w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z-w2))
          verts.append(Vector3( w*x-w2, y*w+w2, w*z+w2))
          
          verts.append(Vector3( w*x-w2, y*w+w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z-w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z+w2))
        #bottom
        if b>0 and bbot<1:
          verts.append(Vector3( w*x-w2, y*w-w2, w*z-w2))
          verts.append(Vector3( w*x-w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z-w2))
          
          verts.append(Vector3( w*x-w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z-w2))
          
        #front
        if b>0 and bfront<1:
          verts.append(Vector3( w*x-w2, y*w-w2, w*z-w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z-w2))
          verts.append(Vector3( w*x-w2, y*w+w2, w*z-w2))

          verts.append(Vector3( w*x-w2, y*w+w2, w*z-w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z-w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z-w2))
        #back
        if b>0 and bback<1:
          verts.append(Vector3( w*x-w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x-w2, y*w+w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z+w2))

          verts.append(Vector3( w*x-w2, y*w+w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z+w2))
        
        #left
        if b>0 and bleft<1:
          verts.append(Vector3( w*x-w2, y*w-w2, w*z-w2))
          verts.append(Vector3( w*x-w2, y*w+w2, w*z-w2))
          verts.append(Vector3( w*x-w2, y*w-w2, w*z+w2))

          verts.append(Vector3( w*x-w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x-w2, y*w+w2, w*z-w2))
          verts.append(Vector3( w*x-w2, y*w+w2, w*z+w2))
        #right
        if b>0 and bright<1:
          verts.append(Vector3( w*x+w2, y*w-w2, w*z-w2))
          verts.append(Vector3( w*x+w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z-w2))

          verts.append(Vector3( w*x+w2, y*w-w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z+w2))
          verts.append(Vector3( w*x+w2, y*w+w2, w*z-w2))
  var conc=ConcavePolygonShape.new()
  conc.set_faces(verts)
  $CollisionShape.shape=conc
  var st = SurfaceTool.new()
  st.begin(Mesh.PRIMITIVE_TRIANGLES)
  for vert in verts:
    st.add_vertex(vert)
  st.generate_normals()
  st.set_material(mat)        
  $MeshInstance.mesh=st.commit()
      
