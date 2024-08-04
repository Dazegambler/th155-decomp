local slot = ::graphics.slot;
local mat_world = this.manbow.Matrix();
mat_world.SetIdentity();
mat_world.Scale(-1, 1, 1);
mat_world.Rotate(3,14159203.0 / 2,00000000.0, 0, 0);
mat_world.Translate(0, 0, 0);
this.animation_set <- ::manbow.AnimationSet3D();
this.animation_set.Load(0, "data/background/bg23/bg23.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(0, 0);
this.actor0.SetWorldTransform(mat_world);
this.actor0.Update();
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
this.animation_set.Load(10, "data/background/bg23/bg23_a.msh", null);
this.actor1 <- ::manbow.AnimationController3D();
this.actor1.SetAnimationSet(this.animation_set);
this.actor1.SetMotion(10, 0);
this.actor1.SetWorldTransform(mat_world);
this.actor1.Update();
this.actor1.ConnectRenderSlot(slot.background3d_alpha, 10);
local mat = this.manbow.Matrix();
mat.SetIdentity();
this.actor1.SortVertexNodeByMatrix(mat);
this.animation_set.Load(20, "data/background/bg23/taki.msh", null);
this.actor2 <- ::manbow.AnimationController3D();
this.actor2.SetAnimationSet(this.animation_set);
this.actor2.SetMotion(20, 0);
this.actor2.SetWorldTransform(mat_world);
this.actor2.Update();
this.actor2.ConnectRenderSlot(slot.background3d_add, 0);
this.animation_set2d <- this.manbow.AnimationSet2D();
local prop = this.manbow.Animation2DProperty();
prop.texture_name = "data/background/bg23/mob/mob_taki";
prop.id = 0;
prop.frame = 5;
this.animation_set2d.Create(prop);
this.actor_material <- this.manbow.AnimationController2D();
this.actor_material.Init(this.animation_set2d);
this.actor_material.SetMotion(prop.id, 0);
this.actor2.SetMaterialByName("data/backGround/bg23/‘ê/mat4.mat", this.actor_material);
function Update()
{
	this.actor_material.Update();
}

