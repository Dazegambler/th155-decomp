local priority = 10000;
local _mat_world = [
	::manbow.Matrix(),
	::manbow.Matrix()
];
_mat_world[0].SetIdentity();
_mat_world[1].SetScaling(-1, 1, 1);
_mat_world[1].Translate(1280, 0, 0);
local func_init = function ( i )
{
	this.action <- ::menu.character_select.weakref();
	this.index <- i;
	this.offset <- 3000 - i * 500;
	this.current_id <- -1;
	this.target_id <- -1;
	this.cursor_inst <- this.action.t[this.index].cursor_slave;
	this.cursor <- this.action.t[this.index].cursor_slave.val;
	this.mat_frame <- ::manbow.Matrix();
	this.mat_frame.SetTranslation(120, 450, 0);
	this.frame_parts <- [];
	this.mask <- ::manbow.AnimationControllerStencil();
	this.mask.Init(this.anime_set);
	this.mask.SetMotion(210, 0);
	this.mask.ConnectRenderSlot(::graphics.slot.ui, priority + 1000 + this.offset);
	this.mask.is_write = true;
	this.mask.SetWorldTransform(this.mat_frame);
	this.mask.Update();
	this.frame_parts.push(this.mask);
	this.back <- ::manbow.AnimationController2D();
	this.back.Init(this.anime_set);
	this.back.SetMotion(220 + this.index, 0);
	this.back.ConnectRenderSlot(::graphics.slot.ui, priority + 1010 + this.offset);
	this.back.SetWorldTransform(this.mat_frame);
	this.back.Update();
	this.frame_parts.push(this.back);
	this.frame <- ::manbow.AnimationController2D();
	this.frame.Init(this.anime_set);
	this.frame.SetMotion(200, 0);
	this.frame.ConnectRenderSlot(::graphics.slot.ui, priority + 1200 + this.offset);
	this.frame.SetWorldTransform(this.mat_frame);
	this.frame.Update();
	this.frame_parts.push(this.frame);
	this.face <- [];
	this.mat_face <- ::manbow.Matrix();
	function CreateFace( id )
	{
		local f = ::manbow.AnimationControllerStencil();
		f.Init(this.anime_set);
		f.SetMotion(id, 0);
		this.mat_face.SetScaling(0.69999999, 0.69999999, 1);
		this.mat_face.Translate(-120, 120, 0);
		this.mat_face.Multiply(this.mat_world);
		f.SetWorldTransform(this.mat_face);
		f.is_equal = true;
		f.stencil = this.mask;
		f.ConnectRenderSlot(::graphics.slot.ui, priority + 1100 + this.offset);

		if (id >= 2000)
		{
			this.frame.red = this.frame.blue = this.frame.green = 2.50000000;
			f.red = f.blue = f.green = 2.50000000;
		}
		else
		{
			f.alpha = 0;
		}

		f.Update();
		return f;
	}

	this.target_id = 1000 + this.cursor;
	this.dir <- this.index == 0 ? 1 : -1;
	this.rot <- 0 + this.index * 0.50000000;
	this.rot_acc <- 0.03000000;
	this.scale <- 0;
	this.id <- -1;
	this.count <- 0;
};
local func_update = function ()
{
	this.count++;
	local mat = ::manbow.Matrix();
	this.rot += this.rot_acc;

	if (this.fabs(this.rot_acc) > 0.00200000)
	{
		this.rot_acc *= 0.94999999;
	}

	mat.SetRotation(0.60000002, 0.50000000, this.rot);
	mat.Scale(this.scale, this.scale, 1);
	mat.Multiply(this.mat_frame);
	mat.Multiply(this.mat_world);

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
		color = color - 0.20000000;

		if (color < 0.50000000)
		{
			color = 0.50000000;
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
				v.alpha += 0.20000000;
			}
		}
		else if (v.alpha > 0.10000000)
		{
			v.alpha -= 0.10000000;
		}
		else
		{
			this.face.remove(i);
		}
	}

	if (this.cursor_inst.active || this.cursor_inst.ok)
	{
		if (this.scale > 1)
		{
			this.scale -= 0.15000001;

			if (this.scale < 1)
			{
				this.scale = 1;
			}
		}
		else if (this.scale < 1)
		{
			this.scale += 0.10000000;

			if (this.scale > 1)
			{
				this.scale = 1;
			}

			this.rot_acc = 0.15000001;
		}

		if (this.back.alpha < 1)
		{
			this.back.alpha += 0.05000000;
		}

		this.frame.alpha = this.back.alpha;
	}
	else
	{
		this.scale -= 0.05000000;

		if (this.scale < 0)
		{
			this.scale = 0;
		}

		if (this.back.alpha > 0)
		{
			this.back.alpha -= 0.05000000;
		}

		this.frame.alpha = this.back.alpha;
	}

	if (this.cursor_inst.ok)
	{
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
