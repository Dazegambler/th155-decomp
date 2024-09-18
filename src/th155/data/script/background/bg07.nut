local slot = ::graphics.slot;
local mat_world = this.manbow.Matrix();
mat_world.SetIdentity();
mat_world.Scale(-1, 1, 1);
mat_world.Rotate(3.14159203 / 2.00000000, 0, 0);
mat_world.Translate(0, 0, 0);
this.animation_set <- ::manbow.AnimationSet3D();
this.animation_set.Load(0, "data/background/bg07/bg07.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(0, 0);
this.actor0.SetWorldTransform(mat_world);
this.actor0.Update();
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
this.animation_set.Load(10, "data/background/bg07/bg_a.msh", null);
this.actor1 <- ::manbow.AnimationController3D();
this.actor1.SetAnimationSet(this.animation_set);
this.actor1.SetMotion(10, 0);
this.actor1.SetWorldTransform(mat_world);
this.actor1.Update();
this.actor1.ConnectRenderSlot(slot.background3d_0, 0);
local mat = this.manbow.Matrix();
mat.SetIdentity();
this.actor1.SortVertexNodeByMatrix(mat);
this.animation_set.Load(20, "data/background/bg07/taki.msh", null);
this.actor2 <- ::manbow.AnimationController3D();
this.actor2.SetAnimationSet(this.animation_set);
this.actor2.SetMotion(20, 0);
this.actor2.SetWorldTransform(mat_world);
this.actor2.Update();
this.actor2.ConnectRenderSlot(slot.background3d_add, 0);
this.animation_set2d <- this.manbow.AnimationSet2D();
local prop = this.manbow.Animation2DProperty();
prop.texture_name = "data/background/bg07/mob/mob_taki";
prop.id = 0;
prop.frame = 5;
this.animation_set2d.Create(prop);
this.actor_material <- this.manbow.AnimationController2D();
this.actor_material.Init(this.animation_set2d);
this.actor_material.SetMotion(prop.id, 0);
this.actor2.SetMaterialByName("data/backGround/bg07/��/mat4.mat", this.actor_material);
function Update()
{
	this.actor_material.Update();
}

this.src_target <- ::manbow.RenderTarget();
this.src_target.Create(::graphics.width, ::graphics.height);
this.src_target.ConnectRenderSlot(slot.background_begin, 0, true);
this.src_target.ConnectRenderSlot(slot.background_end, 0, false);
this.bloom_filter <- ::manbow.Filter();
this.bloom_filter.InitBloom(this.src_target, 128, 1, 20.00000000, 1.00000000, 0.10000000, 0.94999999);
this.bloom_filter.ConnectRenderSlot(slot.background_end, 10);
