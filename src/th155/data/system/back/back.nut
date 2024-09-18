this.margin <- 120;
local texture = ::manbow.Texture();
texture.Load("data/system/back/config_back2.png");
this.sprite_back <- ::manbow.Sprite();
this.sprite_back.Initialize(texture, 0, 0, texture.width, texture.height);
this.sprite_back.oy = 360;
this.sprite_back.sy = 0;
this.sprite_back.alpha = 0;
texture = ::manbow.Texture();
texture.Load("data/system/back/config_front.png");
this.sprite0 <- ::manbow.Sprite();
this.sprite0.Initialize(texture, 0, 0, 448, texture.height);
this.sprite1 <- ::manbow.Sprite();
this.sprite1.Initialize(texture, 1280 - 448, 0, 448, texture.height);
this.sprite1.x = 1280 - 448;
this.ref_count <- 0;
this.count <- 30;
function Activate()
{
	if (this.ref_count == 0)
	{
		this.sprite_back.sy = 0;
		this.sprite_back.alpha = 0;
		this.count = 0;
		::loop.AddTask(this);
		this.Show();
	}

	this.ref_count++;
}

function Deactivate( imm = false )
{
	if (this.ref_count > 0)
	{
		this.ref_count--;

		if (this.ref_count == 0)
		{
			if (imm)
			{
				this.Hide();
				::loop.DeleteTask(this);
			}
			else
			{
				::loop.AddTask(this);
			}
		}
	}
}

function Show()
{
	this.sprite_back.ConnectRenderSlot(::graphics.slot.overlay, -1);
	this.sprite0.ConnectRenderSlot(::graphics.slot.overlay, 99999);
	this.sprite1.ConnectRenderSlot(::graphics.slot.overlay, 99999);
}

function Hide()
{
	this.sprite_back.DisconnectRenderSlot();
	this.sprite0.DisconnectRenderSlot();
	this.sprite1.DisconnectRenderSlot();
}

function Update()
{
	if (this.ref_count > 0)
	{
		if (this.sprite_back.sy < 1)
		{
			this.sprite_back.sy += 0.10000000;
		}
		else
		{
			::loop.DeleteTask(this);
			return;
		}

		this.sprite_back.alpha = this.sprite_back.sy;
		this.Show();
		local v = (1.00000000 - this.sprite_back.alpha) * 20.00000000;
		this.sprite0.x = -v * v - this.margin;
		this.sprite1.x = 1280 - 448 + v * v + this.margin;
	}
	else
	{
		if (this.count++ < 16 && this.sprite_back.sy >= 1.00000000)
		{
			return;
		}

		if (this.sprite_back.sy > 0)
		{
			this.sprite_back.sy -= 0.10000000;
			this.sprite_back.alpha = this.sprite_back.sy;
			local v = (1.00000000 - this.sprite_back.alpha) * 20.00000000;
			this.sprite0.x = -v * v - this.margin;
			this.sprite1.x = 1280 - 448 + v * v + this.margin;
		}
		else
		{
			this.Hide();
			::loop.DeleteTask(this);
		}
	}
}

