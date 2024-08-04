function SetCamera()
{
	::camera.func_update_3d = function ( camera )
	{
		this.offset_x = camera.offset_x;
		this.offset_y = camera.offset_y;
		this.at_x = -(camera.camera2d.left + camera.camera2d.right) / 2 + 640;
		this.eye_x = this.at_x;
		this.at_y = ((camera.camera2d.top + camera.camera2d.bottom) / 2 - (560 + 700)) * 1;
		this.eye_y = this.at_y;
		local w = camera.camera2d.right - camera.camera2d.left;
		this.eye_z = -1900,00000000.0;
		this.fov = this.atan(w / -this.eye_z) * 1,29999995.0;
		this.z_far = 300000;
		this.at_z = this.eye_z + this.z_far;
	};
}

local slot = ::graphics.slot;
this.mat_world <- this.manbow.Matrix();
this.mat_world.SetIdentity();
this.mat_world.Scale(-1, 1, 1);
this.mat_world.Rotate(3,14159203.0 / 2,00000000.0, 0, 0);
this.mat_world.Translate(0, 0, 0);
this.animation_set <- ::manbow.AnimationSet3D();
this.count <- 0;
this.animation_set.Load(0, "data/background/bg43/stage01.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(0, 0);
this.actor0.SetWorldTransform(this.mat_world);
this.actor0.Update();
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
this.animation_set.Load(10, "data/background/bg43/sairium.msh", null);
this.actor10 <- ::manbow.AnimationController3D();
this.actor10.SetAnimationSet(this.animation_set);
this.actor10.SetMotion(10, 0);
this.actor10.SetWorldTransform(this.mat_world);
this.actor10.Update();
this.actor10.ConnectRenderSlot(slot.background3d_add, 0);
this.animation_set.Load(20, "data/background/bg43/sairium2.msh", null);
this.actor11 <- ::manbow.AnimationController3D();
this.actor11.SetAnimationSet(this.animation_set);
this.actor11.SetMotion(20, 0);
this.actor11.SetWorldTransform(this.mat_world);
this.actor11.Update();
this.actor11.ConnectRenderSlot(slot.background3d_add, 0);
this.animation_set.Load(30, "data/background/bg43/sairium3.msh", null);
this.actor12 <- ::manbow.AnimationController3D();
this.actor12.SetAnimationSet(this.animation_set);
this.actor12.SetMotion(30, 0);
this.actor12.SetWorldTransform(this.mat_world);
this.actor12.Update();
this.actor12.ConnectRenderSlot(slot.background3d_add, 0);
this.animation_set.Load(40, "data/background/bg43/orange.msh", null);
this.actor13 <- ::manbow.AnimationController3D();
this.actor13.SetAnimationSet(this.animation_set);
this.actor13.SetMotion(40, 0);
this.actor13.SetWorldTransform(this.mat_world);
this.actor13.Update();
this.actor13.ConnectRenderSlot(slot.background3d_add, 0);
this.actor14 <- ::manbow.AnimationController3D();
this.actor14.SetAnimationSet(this.animation_set);
this.actor14.SetMotion(40, 0);
this.actor14.SetWorldTransform(this.mat_world);
this.actor14.Update();
this.actor14.ConnectRenderSlot(slot.background3d_add, 0);
this.src_target <- ::manbow.RenderTarget();
this.src_target.Create(::graphics.width, ::graphics.height);
this.src_target.ConnectRenderSlot(slot.background_begin, 0, true);
this.src_target.ConnectRenderSlot(slot.background_end, 0, false);
this.bloom_filter <- ::manbow.Filter();
this.bloom_filter.InitBloom(this.src_target, 512, 2, 100,00000000.0, 5,00000000.0, 0,50000000.0, 0,75000000.0);
this.bloom_filter.ConnectRenderSlot(slot.background_end, 10);
this.anime_set <- ::manbow.AnimationSet2D();
this.anime_set.Load("data/background/mob/mob.pat", null);
this.actor1 <- this.manbow.AnimationController2D();
this.actor1.Init(this.anime_set);
this.actor1.SetMotion(0, 3);
this.actor1.ConnectRenderSlot(slot.background3d_3, 997);
this.actor2 <- this.manbow.AnimationController2D();
this.actor2.Init(this.anime_set);
this.actor2.SetMotion(1, 3);
this.actor2.ConnectRenderSlot(slot.background3d_3, 1000);
this.actor2b <- this.manbow.AnimationController2D();
this.actor2b.Init(this.anime_set);
this.actor2b.SetMotion(1, 5);
this.actor2b.ConnectRenderSlot(slot.background3d_3, 1000);
this.actor3 <- this.manbow.AnimationController2D();
this.actor3.Init(this.anime_set);
this.actor3.SetMotion(2, 3);
this.actor3.ConnectRenderSlot(slot.background3d_3, 999);
this.actor3b <- this.manbow.AnimationController2D();
this.actor3b.Init(this.anime_set);
this.actor3b.SetMotion(2, 5);
this.actor3b.ConnectRenderSlot(slot.background3d_3, 1000);
this.actor4 <- this.manbow.AnimationController2D();
this.actor4.Init(this.anime_set);
this.actor4.SetMotion(3, 3);
this.actor4.ConnectRenderSlot(slot.background3d_3, 998);
local mat = ::manbow.Matrix();
mat.SetTranslation(50, -580, -200);
this.actor1.SetWorldTransform(mat);
this.actor1.Update();
mat.SetTranslation(-50, -580, -220);
this.actor2.SetWorldTransform(mat);
this.actor2.Update();
mat.SetTranslation(-50, -580, -221);
this.actor2b.SetWorldTransform(mat);
this.actor2b.Update();
mat.SetTranslation(180, -580, -210);
this.actor3.SetWorldTransform(mat);
this.actor3.Update();
mat.SetTranslation(180, -580, -211);
this.actor3b.SetWorldTransform(mat);
this.actor3b.Update();
mat.SetTranslation(-180, -580, -220);
this.actor4.SetWorldTransform(mat);
this.actor4.Update();
this.begin <- ::manbow.timeGetTime();
this.bpm <- 174,00000000.0 / 2,00000000.0;
function Update()
{
	local mat = ::manbow.Matrix();
	this.count++;
	mat.SetTranslation(50, -650 + 10 * this.sin(1,08570004.0 * this.count * 3 * 0,01745329.0), -130);
	this.actor1.SetWorldTransform(mat);
	this.actor1.Update();

	if (this.count % 662 == 0)
	{
		this.actor1.SetMotion(0, 3);
		this.actor2.SetMotion(1, 2);
		this.actor2b.SetMotion(1, 4);
		this.actor3.SetMotion(2, 2);
		this.actor3b.SetMotion(2, 4);
		this.actor4.SetMotion(3, 2);
	}

	mat.SetScaling(-1, 1, 1);
	mat.Translate(-50 + 10 * this.sin(1,08570004.0 * this.count * 0,01745329.0), -580 + 5 * this.sin((1,08570004.0 * this.count + 90) * 3 * 0,01745329.0), -200);
	this.actor2.SetWorldTransform(mat);
	this.actor2.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(-50 + 10 * this.sin(1,08570004.0 * this.count * 0,01745329.0), -580 + 5 * this.sin((1,08570004.0 * this.count + 90) * 3 * 0,01745329.0), -210);
	this.actor2b.SetWorldTransform(mat);
	this.actor2b.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(180 - 20 * this.sin(1,08570004.0 * this.count * 0,01745329.0 * 2), -600 + 10 * this.sin((1,08570004.0 * this.count + 180) * 4 * 0,01745329.0), -180);
	this.actor3.SetWorldTransform(mat);
	this.actor3.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(180 - 20 * this.sin(1,08570004.0 * this.count * 0,01745329.0 * 2), -600 + 10 * this.sin((1,08570004.0 * this.count + 180) * 4 * 0,01745329.0), -190);
	this.actor3b.SetWorldTransform(mat);
	this.actor3b.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(-180 + 20 * this.sin(1,08570004.0 * this.count * 0,01745329.0 * 2), -600 + 10 * this.sin((1,08570004.0 * this.count + 270) * 4 * 0,01745329.0), -150);
	this.actor4.SetWorldTransform(mat);
	this.actor4.Update();
	local a = (::manbow.timeGetTime() - this.begin) * this.bpm / 60000,00000000.0 * 3,14159203.0;
	mat.SetTranslation(0, 0, this.pow(this.cos(a), 10) * 14);
	mat.Multiply(this.mat_world);
	this.actor10.SetWorldTransform(mat);
	this.actor10.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(0, -this.pow(this.cos(a + 0,13000000.0), 8), this.pow(this.cos(a + 0,12000000.0), 12) * 15);
	mat.Multiply(this.mat_world);
	this.actor11.SetWorldTransform(mat);
	this.actor11.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(0, -this.pow(this.cos(a + 0,13000000.0), 8), this.pow(this.cos(a + 0,13000000.0), 8) * 16);
	mat.Multiply(this.mat_world);
	this.actor12.SetWorldTransform(mat);
	this.actor12.Update();
	mat.SetScaling(-1, 1, 1);
	mat.Translate(0, 100 - this.pow(this.cos(a + 0,13000000.0), 8), this.pow(this.cos(a + 0,09000000.0), 8) * 16);
	mat.Multiply(this.mat_world);
	this.actor13.SetWorldTransform(mat);
	this.actor13.Update();
	mat.SetScaling(1, 1, 1);
	mat.Translate(150, 5 - this.pow(this.cos(a + 0,13000000.0), 8), this.pow(this.cos(a + 0,11000000.0), 8) * 15);
	mat.Multiply(this.mat_world);
	this.actor14.SetWorldTransform(mat);
	this.actor14.Update();
}

