::manbow.CompileFile("data/script/background/bg43.nut", this);
local slot = ::graphics.slot;
this.animation_set.Load(5, "data/background/bg46/stage01.msh", null);
this.actor0 <- ::manbow.AnimationController3D();
this.actor0.SetAnimationSet(this.animation_set);
this.actor0.SetMotion(5, 0);
this.actor0.SetWorldTransform(this.mat_world);
this.actor0.Update();
this.actor0.ConnectRenderSlot(slot.background3d_0, 0);
this.UpdateMain <- this.Update;
function Update()
{
}

this.actor10.DisconnectRenderSlot();
this.actor11.DisconnectRenderSlot();
this.actor12.DisconnectRenderSlot();
this.actor13.DisconnectRenderSlot();
this.actor14.DisconnectRenderSlot();
this.actor1.SetMotion(0, 1);
this.actor2.SetMotion(1, 1);
this.actor2b.SetMotion(1, 0);
this.actor3.SetMotion(2, 1);
this.actor3b.SetMotion(2, 0);
this.actor4.SetMotion(3, 1);
function Switch()
{
	this.actor0.SetMotion(0, 0);
	this.actor0.Update();
	this.actor1.SetMotion(0, 3);
	this.actor2.SetMotion(1, 3);
	this.actor2b.SetMotion(1, 5);
	this.actor3.SetMotion(2, 3);
	this.actor3b.SetMotion(2, 5);
	this.actor4.SetMotion(3, 3);
	this.actor10.ConnectRenderSlot(slot.background3d_add, 0);
	this.actor11.ConnectRenderSlot(slot.background3d_add, 0);
	this.actor12.ConnectRenderSlot(slot.background3d_add, 0);
	this.actor13.ConnectRenderSlot(slot.background3d_add, 0);
	this.actor14.ConnectRenderSlot(slot.background3d_add, 0);
	this.begin = ::manbow.timeGetTime();
	this.Update <- this.UpdateMain;
}

