# AstroQuest Blender procedural starter.
# Run in Blender's Scripting workspace.
import bpy
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

def cube(name, location, scale):
    bpy.ops.mesh.primitive_cube_add(location=location)
    obj=bpy.context.object; obj.name=name; obj.scale=scale; return obj

def sphere(name, location, radius):
    bpy.ops.mesh.primitive_uv_sphere_add(radius=radius, location=location)
    obj=bpy.context.object; obj.name=name; return obj

cube('Mission_Console',(0,0,0.7),(3.5,1.2,0.7))
for i,x in enumerate((-2,0,2),1): cube(f'HUD_Screen_{i}',(x,-1.35,1.9),(0.8,0.08,0.55))
sphere('Moon_Training_Object',(0,5,1),2.2)
cube('Lander_Body',(0,2.5,1.2),(0.9,0.9,0.45))
bpy.ops.object.camera_add(location=(10,-14,9)); bpy.context.scene.camera=bpy.context.object
bpy.ops.object.light_add(type='AREA', location=(4,-4,10)); bpy.context.object.data.energy=1200
print('AstroQuest starter scene created.')
