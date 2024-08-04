this.texture <- ::manbow.Texture();
this.texture.Load("data/system/cursor/cursor.png");
this.texture_back <- ::manbow.Texture();
this.texture_back.Load("data/system/cursor/back.png");
this.sprite <- ::manbow.Sprite();
this.sprite.Initialize(this.texture, 0, 0, 64, 64);
this.sprite.filter = 1;
this.left <- ::manbow.Sprite();
this.left.Initialize(this.texture, 0, 64, 32, 32);
this.left.filter = 1;
this.right <- ::manbow.Sprite();
this.right.Initialize(this.texture, 0, 64, 32, 32);
this.right.sx = -1;
this.right.filter = 1;
this.under <- ::manbow.Sprite();
this.under.Initialize(this.texture, 0, 112, 512, 32);
this.under.filter = 1;
this.actor <- null;
this.mat_local <- ::manbow.Matrix();
this.mat_local.SetTranslation(-32, -32, 0);
this.mat_world <- ::manbow.Matrix();
this.rot <- 0;
this.ref_count <- 0;
this.x <- -20;
this.y <- 360;
this.scale <- 1;
this.target_x <- 0;
this.target_y <- 0;
this.target_scale <- 0;
function Activate()
{
	this.ref_count++;

	if (this.ref_count == 1)
	{
		this.Show();
		::loop.AddTask(this);
	}
}

function Deactivate()
{
	this.ref_count--;

	if (this.ref_count == 0)
	{
		this.target_x = this.x = -100;
		this.Hide();
		::loop.DeleteTask(this);
	}
}

function Show()
{
	this.sprite.ConnectRenderSlot(::graphics.slot.front, 60000);
	local v = ::manbow.Vector3();
	v.x = this.x;
	v.y = this.y;

	if (this.actor == null)
	{
		this.actor = ::manbow.effect.CreateActor(0, v, ::effect.MASK_GLOBAL);
		this.actor.ConnectRenderSlot(::graphics.slot.front, 59999);
	}
}

function Hide()
{
	if (this.actor)
	{
		this.actor.Release();
		this.actor = null;
	}

	this.sprite.DisconnectRenderSlot();
}

function SetTarget( _x, _y, _scale, imm = false )
{
	if (imm)
	{
		this.x = this.target_x = _x;
		this.y = this.target_y = _y;
		this.scale = this.target_scale = _scale;
	}
	else
	{
		this.target_x = _x;
		this.target_y = _y;
		this.target_scale = _scale;
	}
}

function Update()
{
	if (this.abs(this.target_x - this.x) > 24 || this.abs(this.target_y - this.y) > 24)
	{
		local v = ::manbow.Vector3();
		v.x = this.x;
		v.y = this.y;
		::effect.Create(1, v, null, ::graphics.slot.front, 59999, ::effect.MASK_GLOBAL);
	}

	this.x += (this.target_x - this.x) * 0,20000000.0;
	this.y += (this.target_y - this.y) * 0,20000000.0;
	this.scale += (this.target_scale - this.scale) * 0,20000000.0;
	this.rot += 0,03000000.0;
	local mat = ::manbow.Matrix();
	mat.Set(this.mat_local);
	mat.Scale(this.scale, this.scale, this.scale);
	mat.Rotate(0, 0, this.rot);
	mat.Translate(this.x, this.y, 0);
	this.sprite.SetWorldTransform(mat);

	if (this.actor)
	{
		this.actor.x = this.x;
		this.actor.y = this.y;
	}

	return;
	local v = ::manbow.Vector3();
	v.x = this.x;
	v.y = this.y;
	::effect.Create(0, v, null, ::graphics.slot.front, 59999, ::effect.MASK_GLOBAL);
}

