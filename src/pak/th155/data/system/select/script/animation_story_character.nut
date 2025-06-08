local priority = 0;
local _mat_world = ::manbow.Matrix();
_mat_world.SetTranslation(900, 40, 0);
local func_init = function ()
{
	this.action <- ::menu.story_select.weakref();
	this.cursor_inst <- this.action.cursor_story;
	this.current_id <- -1;
	this.target_id <- 1000 + this.cursor_inst.val;
	this.mat_frame <- ::manbow.Matrix();
	this.mat_frame.SetScaling(1.50000000, 1.50000000, 1.50000000);
	this.mat_frame.Translate(0, 540, 0);
	this.mat_frame.Multiply(this.mat_world);
	this.frame_parts <- [];
	this.mask <- ::manbow.AnimationControllerStencil();
	this.mask.Init(this.anime_set);
	this.mask.SetMotion(110, 0);
	this.mask.ConnectRenderSlot(::graphics.slot.ui, priority + 1000);
	this.mask.is_write = true;
	this.mask.SetWorldTransform(this.mat_frame);
	this.mask.Update();
	this.frame_parts.push(this.mask);
	this.back <- ::manbow.AnimationController2D();
	this.back.Init(this.anime_set);
	this.back.SetMotion(120, 0);
	this.back.ConnectRenderSlot(::graphics.slot.ui, priority + 1010);
	this.back.SetWorldTransform(this.mat_frame);
	this.back.Update();
	this.frame_parts.push(this.back);
	this.frame <- ::manbow.AnimationController2D();
	this.frame.Init(this.anime_set);
	this.frame.SetMotion(100, 0);
	this.frame.ConnectRenderSlot(::graphics.slot.ui, priority + 1200);
	this.frame.SetWorldTransform(this.mat_frame);
	this.frame.Update();
	this.frame_parts.push(this.frame);
	this.face <- [];
	this.mat_face <- ::manbow.Matrix();
	this.mat_face.SetTranslation(0, 0, 0);
	this.mat_face.Multiply(this.mat_world);
	function CreateFace( id )
	{
		local f = ::manbow.AnimationController2D();
		f.Init(this.anime_set);
		f.SetMotion(id, 0);
		f.SetWorldTransform(this.mat_face);
		f.ConnectRenderSlot(::graphics.slot.ui, priority + 2000);
		f.alpha = 0;
		f.Update();
		return f;
	}

	this.rot <- 0;
	this.rot_acc <- 0.00500000;
	this.scale <- 0;
	this.scale_face <- 1;
};
local func_update = function ()
{
	local mat = ::manbow.Matrix();
	this.rot += this.rot_acc;

	if (this.fabs(this.rot_acc) > 0.00200000)
	{
		this.rot_acc *= 0.94999999;
	}

	mat.SetRotation(0, 0, this.rot);
	mat.Scale(this.scale, this.scale, 1);
	mat.Multiply(this.mat_frame);

	foreach( v in this.frame_parts )
	{
		v.SetWorldTransform(mat);
		v.Update();
	}

	foreach( i, v in this.face )
	{
		if (v == this.face.top())
		{
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
	}

	if (this.cursor_inst.ok)
	{
		if (this.target_id != 2000 + this.character_id_story[this.list[this.cursor_inst.val]])
		{
			this.rot_acc = 0.10000000;
		}

		this.target_id = 2000 + this.character_id_story[this.list[this.cursor_inst.val]];
	}
	else
	{
		this.target_id = 1000 + this.character_id_story[this.list[this.cursor_inst.val]];
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
local v = {};
v.priority <- priority;
v.anime_set <- this.anime_set;
v.mat_world <- _mat_world;
v.list <- ::menu.story_select.story_list;
v.Update <- func_update;
func_init.call(v);
this.data.push(v);
