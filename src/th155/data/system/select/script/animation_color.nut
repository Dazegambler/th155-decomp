local priority = 20000;
local _mat_world = [
	::manbow.Matrix(),
	::manbow.Matrix()
];
_mat_world[0].SetIdentity();
_mat_world[0].Translate(120 - 64, 310, 0);
_mat_world[1].SetScaling(1, 1, 1);
_mat_world[1].Translate(1160 + 64, 310, 0);
local func_init = function ( i, j )
{
	this.action <- ::menu.character_select.weakref();
	this.index <- j;
	this.side <- i;
	this.current_id <- -1;
	this.target_id <- -1;

	if (this.index == 0)
	{
		this.cursor_target <- this.action.t[this.side].cursor_master;
		this.cursor_inst <- this.action.t[this.side].cursor_color_master;
	}
	else
	{
		this.cursor_target <- this.action.t[this.side].cursor_slave;
		this.cursor_inst <- this.action.t[this.side].cursor_color_slave;
	}

	this.cursor_up <- ::manbow.AnimationController2D();
	this.cursor_up.Init(this.anime_set);
	this.cursor_up.SetMotion(410, 0);
	this.cursor_down <- ::manbow.AnimationController2D();
	this.cursor_down.Init(this.anime_set);
	this.cursor_down.SetMotion(411, 0);
	this.frame_parts <- [];
	this.palette <- [];
	this.x <- 0;
	this.y <- 0;
	this.target_x <- 0;
	this.target_y <- 0;
	this.dir <- this.side == 0 ? 1 : -1;
	this.height <- 1440;
	this.height_half <- 720;
	this.id <- -1;
	this.count <- 0;
	this.visible <- false;
};
local func_update = function ()
{
	this.count++;

	if (this.cursor_inst.diff)
	{
		this.count = 0;
	}

	if (this.cursor_target.ok && this.id != this.cursor_target.val)
	{
		this.id = this.cursor_target.val;
		local name = ::character_name[this.id];

		if (!(name in this.texture))
		{
			this.texture[name] <- ::manbow.Texture();
			this.texture[name].Load(this.filename + name + ".png");
		}

		if (this.texture[name])
		{
			this.palette = [];
			this.height = 128 * this.cursor_inst.item_num;
			this.height_half = this.height / 2;

			for( local i = 0; i < this.cursor_inst.item_num; i = ++i )
			{
				local p = ::manbow.Sprite();
				p.Initialize(this.texture[name], 0, i * 96, 320, 96);
				p.x = this.dir * (i * 32 - 1024);
				p.y = -i * 128;
				p.sx = this.dir;
				p.filter = 1;
				p.ConnectRenderSlot(::graphics.slot.ui, priority);
				this.palette.push(p);
			}

			this.y = this.target_y = this.cursor_inst.val * 128;
		}
	}

	if (this.cursor_inst.active)
	{
		if (!this.visible)
		{
			foreach( v in this.palette )
			{
				v.ConnectRenderSlot(::graphics.slot.ui, priority);
			}

			this.cursor_up.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
			this.cursor_down.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
			this.visible = true;
		}

		this.target_x <- 0;

		if (this.cursor_inst.diff)
		{
			this.target_y = this.cursor_inst.val * 128;

			if (this.target_y - this.y < -this.height_half)
			{
				this.y -= this.height;
			}
			else if (this.target_y - this.y > this.height_half)
			{
				this.y += this.height;
			}
		}
	}
	else
	{
		this.target_x <- -this.dir * 512;

		if (0 < this.dir * (this.target_x + this.dir - this.x))
		{
			if (this.visible)
			{
				foreach( v in this.palette )
				{
					v.DisconnectRenderSlot();
				}

				this.cursor_up.DisconnectRenderSlot();
				this.cursor_down.DisconnectRenderSlot();
				this.visible = false;
			}

			return;
		}
	}

	this.x += (this.target_x - this.x) * 0,15000001.0;
	this.y += (this.target_y - this.y) * 0,25000000.0;
	local mat = ::manbow.Matrix();
	mat.SetTranslation(this.x, 0, 0);
	mat.Multiply(this.mat_world);

	foreach( v in this.frame_parts )
	{
		v.SetWorldTransform(mat);
		v.Update();
	}

	foreach( i, v in this.palette )
	{
		local _y = this.y - 128 * i;

		if (_y > this.height_half)
		{
			_y = _y - this.height;
		}
		else if (_y < -this.height_half)
		{
			_y = _y + this.height;
		}

		local c = 1,00000000.0 - this.abs(_y) / 128,00000000.0;

		if (c < 0,50000000.0)
		{
			c = 0,50000000.0;
		}

		mat.SetTranslation(this.x, 0, 0);
		mat.Multiply(this.mat_world);
		v.red = v.green = v.blue = c;
		v.x = this.dir * _y * 0,25000000.0;
		v.y = _y;
		v.SetWorldTransform(mat);
	}

	local a = this.abs(this.sin(this.count * 0,10000000.0) * 4);
	mat.SetTranslation(this.x + 160 * this.dir, -a, 0);
	mat.Multiply(this.mat_world);
	this.cursor_up.SetWorldTransform(mat);
	mat.SetTranslation(this.x + 160 * this.dir, 96 + a, 0);
	mat.Multiply(this.mat_world);
	this.cursor_down.SetWorldTransform(mat);
};
this.texture_master <- {};
this.texture_slave <- {};

for( local i = 0; i < 2; i = ++i )
{
	for( local j = 0; j < 2; j = ++j )
	{
		local v = {};
		v.priority <- priority;
		v.anime_set <- this.anime_set;
		v.texture <- j == 0 ? this.texture_master : this.texture_slave;
		v.filename <- j == 0 ? "data/system/select/color_master/" : "data/system/select/color_slave/";
		v.mat_world <- _mat_world[i];
		func_init.call(v, i, j);
		v.Update <- func_update;
		this.data.push(v);
	}
}
