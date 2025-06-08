function UpdateCamera3D( camera )
{
	this.offset_x = camera.offset_x;
	this.offset_y = camera.offset_y;
	this.at_x = (-(camera.camera2d.left + camera.camera2d.right) / 2 + 640) * 1;
	this.eye_x = this.at_x;
	this.at_y = ((camera.camera2d.top + camera.camera2d.bottom) / 2 - (560 + 100)) * 1;
	this.eye_y = this.at_y;
	local w = camera.camera2d.right - camera.camera2d.left;
	this.eye_z = -1300.00000000;
	this.fov = this.atan(w / -this.eye_z) * 1.60000002;
	this.z_far = 300000;
	this.at_z = this.eye_z + this.z_far;
}

