local priority = 60000;
local func_init = function ()
{
	this.action <- ::menu.character_select.weakref();
	this.cursor_inst <- this.action.cursor_stage;
	this.cursor <- this.action.cursor_stage.val;
	this.name <- [];
	this.mat_name <- ::manbow.Matrix();
	this.mat_name.SetRotation(0, 0, 0);
	this.mat_name.Translate(0, 520, 0);
	function CreateName( id )
	{
		local f = ::manbow.AnimationController2D();
		f.Init(this.anime_set);
		f.SetMotion(6000 + id, 0);
		f.SetWorldTransform(this.mat_name);
		f.ConnectRenderSlot(::graphics.slot.ui, priority);
		f.alpha = 0;
		f.Update();
		return f;
	}

	this.name.push(this.CreateName(this.cursor));
	this.target_id <- this.cursor;
	this.current_id <- -1;
};
local func_update = function ()
{
	local mat = ::manbow.Matrix();

	foreach( i, v in this.name )
	{
		mat.SetTranslation((1.00000000 - v.alpha) * -500, 0, 0);
		mat.Multiply(this.mat_name);
		v.SetWorldTransform(mat);

		if (v == this.name.top() && this.action.Update != this.action.UpdateCharacterSelect)
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
			this.name.remove(i);
		}
	}

	if (this.current_id != this.cursor_inst.val || this.action.Update != this.action.UpdateCharacterSelect && this.name.len() == 0)
	{
		this.current_id = this.cursor_inst.val;
		this.name.append(this.CreateName(this.action.stage[this.cursor_inst.val]));
	}
};
local v = {};
v.priority <- priority;
v.anime_set <- this.anime_set;
func_init.call(v);
v.Update <- func_update;
this.data.push(v);
