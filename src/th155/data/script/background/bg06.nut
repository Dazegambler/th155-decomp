function SetCamera()
{
	::camera.func_update_3d = function ( camera )
	{
		this.offset_x = camera.offset_x;
		this.offset_y = camera.offset_y;
		this.at_x = (-(camera.camera2d.left + camera.camera2d.right) / 2 + 640) * 1;
		this.eye_x = this.at_x;
		this.at_y = ((camera.camera2d.top + camera.camera2d.bottom) / 2 - (560 + 100)) * 1;
		this.eye_y = this.at_y;
		local w = camera.camera2d.right - camera.camera2d.left;
		this.eye_z = -1500,00000000.0;
		this.fov = this.atan(w / -this.eye_z) * 1,50000000.0;
		this.z_far = 300000;
		this.at_z = this.eye_z + this.z_far;
	};
}

local slot = ::graphics.slot;
local mat_world = this.manbow.Matrix();
mat_world.SetIdentity();
mat_world.Scale(-1, 1, 1);
mat_world.Rotate(3,14159203.0 / 2,00000000.0, 0, 0);
mat_world.Translate(0, 0, 0);
this.animation_set <- ::manbow.AnimationSet3D();
this.animation_set.Load(0, "data/background/bg06/bg06.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(0, 0);
this.actor0.SetWorldTransform(mat_world);
this.actor0.Update();
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
this.animation_set.Load(10, "data/background/bg06/bg06_a.msh", null);
this.actor1 <- ::manbow.AnimationController3D();
this.actor1.SetAnimationSet(this.animation_set);
this.actor1.SetMotion(10, 0);
this.actor1.SetWorldTransform(mat_world);
this.actor1.Update();
this.actor1.ConnectRenderSlot(slot.background3d_0, 0);
this.animation_set.Load(10, "data/background/bg06/light.msh", null);
this.actor2 <- ::manbow.AnimationController3D();
this.actor2.SetAnimationSet(this.animation_set);
this.actor2.SetMotion(10, 0);
this.actor2.SetWorldTransform(mat_world);
this.actor2.Update();
this.actor2.ConnectRenderSlot(slot.background3d_add, 0);
this.src_target <- ::manbow.RenderTarget();
this.src_target.Create(::graphics.width, ::graphics.height);
this.src_target.ConnectRenderSlot(slot.background_begin, 0, true);
this.src_target.ConnectRenderSlot(slot.background_end, 0, false);
this.bloom_filter <- ::manbow.Filter();
this.bloom_filter.InitBloom(this.src_target, 128, 1, 50,00000000.0, 1,00000000.0, 0,10000000.0, 0,80000001.0);
this.bloom_filter.ConnectRenderSlot(slot.background_end, 10);
