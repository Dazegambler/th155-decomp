local slot = ::graphics.slot;
this.mat_world <- this.manbow.Matrix();
this.mat_world.SetIdentity();
this.mat_world.Scale(-1, 1, 1);
this.mat_world.Rotate(3.14159203 / 2.00000000, 0, 0);
this.mat_world.Translate(0, 0, 0);
this.animation_set <- ::manbow.AnimationSet3D();
this.animation_set.Load(0, "data/background/bg04/bg04.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(0, 0);
this.actor0.SetWorldTransform(this.mat_world);
this.actor0.Update();
this.actor0.SortVertexNodeByMatrix(this.mat_world);
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
this.animation_set.Load(10, "data/background/bg04/bg04_front.msh", null);
this.actor1 <- ::manbow.AnimationController3D();
this.actor1.SetAnimationSet(this.animation_set);
this.actor1.SetMotion(10, 0);
this.actor1.SetWorldTransform(this.mat_world);
this.actor1.Update();
this.actor1.ConnectRenderSlot(slot.background3d_2, 0);
this.animation_set.Load(20, "data/background/bg04/hata.msh", null);
this.actor2 <- ::manbow.AnimationController3D();
this.actor2.SetAnimationSet(this.animation_set);
this.actor2.SetMotion(20, 0);
this.actor2.SetWorldTransform(this.mat_world);
this.actor2.Update();
this.actor2.ConnectRenderSlot(slot.background3d_0, 20);
local prop = this.manbow.Animation2DProperty();
this.animation_set2d_flag <- this.manbow.AnimationSet2D();
prop.texture_name = "data/background/bg04/mob/mob_hataA";
prop.id = 1;
prop.frame = 8;
this.animation_set2d_flag.Create(prop);
prop.texture_name = "data/background/bg04/mob/mob_hataB";
prop.id = 0;
prop.frame = 8;
this.animation_set2d_flag.Create(prop);
this.actor_material_flag <- [];

for( local i = 0; i < 12; i++ )
{
	this.actor_material_flag.append(::manbow.AnimationController2D());
	this.actor_material_flag[i].Init(this.animation_set2d_flag);
	this.actor_material_flag[i].SetMotion(i / 6, 0);
	this.actor_material_flag[i].SetKeyFrame(i % 6);
}

this.actor2.SetMaterialByName("data/backGround/bg04/hataR_00/mat5.mat", this.actor_material_flag[0]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataR_01/mat5.mat", this.actor_material_flag[1]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataR_02/mat7.mat", this.actor_material_flag[2]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataR_03/mat5.mat", this.actor_material_flag[3]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataR_04/mat6.mat", this.actor_material_flag[5]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataR_05/mat5.mat", this.actor_material_flag[4]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataL_00/mat8.mat", this.actor_material_flag[6]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataL_01/mat8.mat", this.actor_material_flag[9]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataL_02/mat8.mat", this.actor_material_flag[7]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataL_03/mat8.mat", this.actor_material_flag[8]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataL_04/mat8.mat", this.actor_material_flag[10]);
this.actor2.SetMaterialByName("data/backGround/bg04/hataL_05/mat8.mat", this.actor_material_flag[11]);
this.animation_set.Load(30, "data/background/bg04/bg04_a.msh", null);
this.actor3 <- ::manbow.AnimationController3D();
this.actor3.SetAnimationSet(this.animation_set);
this.actor3.SetMotion(30, 0);
this.actor3.SetWorldTransform(this.mat_world);
this.actor3.Update();
this.actor3.ConnectRenderSlot(slot.background3d_0, 10);
function Update()
{
	foreach( a in this.actor_material_flag )
	{
		a.Update();
	}
}

this.src_target <- ::manbow.RenderTarget();
this.src_target.Create(::graphics.width, ::graphics.height);
this.src_target.ConnectRenderSlot(slot.background_begin, 0, true);
this.src_target.ConnectRenderSlot(slot.background_end, 0, false);
this.bloom_filter <- ::manbow.Filter();
this.bloom_filter.InitBloom(this.src_target, 128, 1, 50.00000000, 1.00000000, 0.10000000, 0.69999999);
this.bloom_filter.ConnectRenderSlot(slot.background_end, 10);
