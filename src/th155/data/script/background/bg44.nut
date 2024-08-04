function SetCamera()
{
	::camera.func_update_3d = function ( camera )
	{
		this.offset_x = camera.offset_x;
		this.offset_y = camera.offset_y;
		this.at_x = -(camera.camera2d.left + camera.camera2d.right) / 2 + 640;
		this.eye_x = this.at_x;
		this.at_y = ((camera.camera2d.top + camera.camera2d.bottom) / 2 - (560 + 2000)) * 1;
		this.eye_y = this.at_y;
		local w = camera.camera2d.right - camera.camera2d.left;
		this.eye_z = -1900,00000000.0;
		this.fov = this.atan(w / -this.eye_z) * 1,00000000.0;
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
this.animation_set.Load(0, "data/background/bg44/stage01.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(0, 0);
this.actor0.SetWorldTransform(mat_world);
this.actor0.Update();
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
