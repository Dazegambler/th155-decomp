this.mat_world <- this.manbow.Matrix();
this.mat_world.SetIdentity();
this.mat_world.SetScaling(1280.00000000 / 1278.00000000, 720.00000000 / 718.00000000, 1);
this.animation_set <- ::manbow.AnimationSet2D();
local prop = this.manbow.Animation2DProperty();
prop.texture_name = "data/background/min/" + (this.id < 10 ? "0" : "") + this.id + ".dds";
prop.id = 0;
prop.left = 1;
prop.top = 1;
prop.width = 1278;
prop.height = 718;
prop.index = 1;
prop.frame = 9999;
prop.filter = 1;
this.animation_set.Create(prop);
this.actor <- this.manbow.AnimationController2D();
this.actor.Init(this.animation_set);
this.actor.SetMotion(0, 0);
this.actor.SetWorldTransform(this.mat_world);
this.actor.Update();
this.actor.ConnectRenderSlot(::graphics.slot.background2d_0, 100);
function Update()
{
}

