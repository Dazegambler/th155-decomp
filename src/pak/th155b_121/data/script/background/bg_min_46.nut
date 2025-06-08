::manbow.CompileFile("data/script/background/bg_min_43.nut", this);
local prop = this.manbow.Animation2DProperty();
prop.texture_name = "data/background/min/46.dds";
prop.id = 1;
prop.left = 1;
prop.top = 1;
prop.width = 1278;
prop.height = 718;
prop.index = 1;
prop.frame = 9999;
prop.filter = 1;
this.animation_set.Create(prop);
this.actor.SetMotion(1, 0);
this.actor.Update();
local mat = ::manbow.Matrix();
mat.Set(this.mat_scale);
mat.Translate(667, 527, -200);
this.actor1.SetWorldTransform(mat);
this.actor1.Update();
mat.Set(this.mat_scale);
mat.Translate(613, 527, -220);
this.actor2.SetWorldTransform(mat);
this.actor2.Update();
mat.Set(this.mat_scale);
mat.Translate(613, 527, -221);
this.actor2b.SetWorldTransform(mat);
this.actor2b.Update();
mat.Set(this.mat_scale);
mat.Translate(545, 527, -210);
this.actor3.SetWorldTransform(mat);
this.actor3.Update();
mat.Set(this.mat_scale);
mat.Translate(545, 527, -211);
this.actor3b.SetWorldTransform(mat);
this.actor3b.Update();
mat.Set(this.mat_scale);
mat.Translate(735, 527, -220);
this.actor4.SetWorldTransform(mat);
this.actor4.Update();
this.actor1.SetMotion(0, 1);
this.actor2.SetMotion(1, 1);
this.actor2b.SetMotion(1, 0);
this.actor3.SetMotion(2, 1);
this.actor3b.SetMotion(2, 0);
this.actor4.SetMotion(3, 1);
this.UpdateMain <- this.Update;
function Update()
{
}

function Switch()
{
	this.actor.SetMotion(0, 0);
	this.actor1.SetMotion(0, 3);
	this.actor2.SetMotion(1, 3);
	this.actor2b.SetMotion(1, 5);
	this.actor3.SetMotion(2, 3);
	this.actor3b.SetMotion(2, 5);
	this.actor4.SetMotion(3, 3);
	this.Update = this.UpdateMain;
}

