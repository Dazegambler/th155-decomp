local priority = 0;
local _mat_world = [
	::manbow.Matrix(),
	::manbow.Matrix()
];
_mat_world[0].SetIdentity();
_mat_world[0].Translate(-100, 0, 0);
_mat_world[1].SetScaling(-1, 1, 1);
_mat_world[1].Translate(1280 + 100, 0, 0);
local func_init = function ( i )
{
	this.action <- ::menu.character_select.weakref();
	this.index <- i;
	this.offset <- -i * 500;
	this.dir <- this.index == 0 ? 1 : -1;
	this.current_id <- -1;
	this.target_id <- -1;
	this.cursor_inst <- this.action.t[this.index].cursor_master;
	this.cursor <- this.action.t[this.index].cursor_master.val;
	this.mat_frame <- ::manbow.Matrix();
	this.mat_frame.SetTranslation(180 + 70 + 80, 360, 0);
	this.mat_frame.Multiply(this.mat_world);
	this.frame_parts <- [];
	this.mask <- ::manbow.AnimationControllerStencil();
	this.mask.Init(this.anime_set);
	this.mask.SetMotion(110, 0);
	this.mask.ConnectRenderSlot(::graphics.slot.ui, priority + 1000 + this.offset);
	this.mask.is_write = true;
	this.mask.SetWorldTransform(this.mat_frame);
	this.mask.Update();
	this.frame_parts.push(this.mask);
	this.back <- ::manbow.AnimationController2D();
	this.back.Init(this.anime_set);
	this.back.SetMotion(120 + this.index, 0);
	this.back.ConnectRenderSlot(::graphics.slot.ui, priority + 1010 + this.offset);
	this.back.SetWorldTransform(this.mat_frame);
	this.back.Update();
	this.frame_parts.push(this.back);
	this.frame <- ::manbow.AnimationController2D();
	this.frame.Init(this.anime_set);
	this.frame.SetMotion(100, 0);
	this.frame.ConnectRenderSlot(::graphics.slot.ui, priority + 1200 + this.offset);
	this.frame.SetWorldTransform(this.mat_frame);
	this.frame.Update();
	this.frame_parts.push(this.frame);
	this.face <- [];
	this.mat_face <- ::manbow.Matrix();
	this.mat_face.SetTranslation(0, -190, 0);
	this.mat_face.Multiply(this.mat_world);
	function CreateFace( id )
	{
		local f = id < 2000 ? ::manbow.AnimationControllerStencil() : ::manbow.AnimationController2D();
		f.Init(this.anime_set);
		f.SetMotion(id, 0);
		f.SetWorldTransform(this.mat_face);

		if (id < 2000)
		{
			f.stencil = this.mask;
			f.is_equal = true;
			f.ConnectRenderSlot(::graphics.slot.ui, priority + 1100 + this.offset);
			f.alpha = 0;
		}
		else
		{
			this.frame.red = this.frame.blue = this.frame.green = 2,50000000.0;
			f.red = f.blue = f.green = 2,50000000.0;
			f.ConnectRenderSlot(::graphics.slot.ui, priority + 2000 + this.offset);
		}

		f.Update();
		return f;
	}

	this.target_id = 1000 + this.cursor;
	this.rot <- 0 + this.index * 0,50000000.0;
	this.rot_acc <- 0,00500000.0;
	this.scale <- 0;
	this.scale_face <- 1;
};
local func_update = function ()
{
	local mat = ::manbow.Matrix();
	this.rot += this.rot_acc;

	if (this.fabs(this.rot_acc) > 0,00200000.0)
	{
		this.rot_acc *= 0,94999999.0;
	}

	mat.SetRotation(-0,40000001.0, 0,60000002.0, this.rot);
	mat.Scale(this.scale, this.scale, 1);
	mat.Multiply(this.mat_frame);

	foreach( v in this.frame_parts )
	{
		v.SetWorldTransform(mat);
		v.Update();
	}

	local color = this.frame.red;

	if (this.cursor_inst.active || this.action.t[this.index].state == this.action.SelectEnd)
	{
		color = 1;
	}
	else
	{
		color = color - 0,20000000.0;

		if (color < 0,50000000.0)
		{
			color = 0,50000000.0;
		}
	}

	this.frame.red = this.frame.blue = this.frame.green = color;

	foreach( i, v in this.face )
	{
		if (v == this.face.top())
		{
			v.red = v.blue = v.green = color;

			if (v.alpha < 1)
			{
				v.alpha += 0,20000000.0;
			}
		}
		else if (v.alpha > 0,10000000.0)
		{
			v.alpha -= 0,10000000.0;
		}
		else
		{
			this.face.remove(i);
		}

		v.shader = 1;
	}

	if (this.scale > 1)
	{
		this.scale -= 0,15000001.0;

		if (this.scale < 1)
		{
			this.scale = 1;
		}
	}
	else if (this.scale < 1)
	{
		this.scale += 0,10000000.0;

		if (this.scale > 1)
		{
			this.scale = 1;
		}
	}

	if (this.cursor_inst.ok)
	{
		if (this.target_id != 2000 + this.cursor_inst.val)
		{
			this.rot_acc = 0,10000000.0;

			foreach( v in this.face )
			{
				v.shader = 1;
			}
		}

		this.target_id = 2000 + this.cursor_inst.val;
	}
	else
	{
		this.target_id = 1000 + this.cursor_inst.val;
	}

	if (this.target_id != this.current_id)
	{
		if (this.target_id in this.action.anime.take_id)
		{
			this.current_id = this.target_id;
			this.face.append(this.CreateFace(this.target_id));
		}
	}
};

for( local i = 0; i < 2; i = ++i )
{
	local v = {};
	v.priority <- priority;
	v.anime_set <- this.anime_set;
	v.mat_world <- _mat_world[i];
	func_init.call(v, i);
	v.Update <- func_update;
	this.data.push(v);
}
