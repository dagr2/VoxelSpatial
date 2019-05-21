tool
extends StaticBody

var blocks = {}
var mat = preload("res://mat1.tres")

func _ready():
  SetBlock(0,0,0,1)
  SetBlock(1,1,0,1)
  SetBlock(2,0,0,1)
  SetBlock(3,1,0,1)



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
  var w=1.0/cnt
  var w2=w/2.0

  
  for z in range(0,cnt):
    for y in range(0,cnt):
      for x in range(0,cnt):
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
      
