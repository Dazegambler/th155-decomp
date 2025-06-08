local priority = 60000;
local func_init = function ( i )
{
	this.action <- ::menu.character_select.weakref();
	this.side <- i;
	this.dir <- this.side == 0 ? 1 : -1;
	this.cursor_inst <- this.action.t[this.side].cursor_slave;
	this.name <- [];
	this.mat_name <- ::manbow.Matrix();
	this.mat_name.SetTranslation(640 - this.dir * 640, 624, 0);
	function CreateName( id )
	{
		local f = ::manbow.AnimationController2D();
		f.Init(this.anime_set);
		f.SetMotion(4000 + id, this.side);
		f.SetWorldTransform(this.mat_name);
		f.ConnectRenderSlot(::graphics.slot.ui, priority);
		f.alpha = 0;
		f.Update();
		return f;
	}

	this.name.push(this.CreateName(this.cursor_inst.val));
	this.target_id <- this.cursor_inst.val;
	this.current_id <- -1;
};
local func_update = function ()
{
	local mat = ::manbow.Matrix();

	foreach( i, v in this.name )
	{
		mat.SetTranslation(-this.dir * (1.00000000 - v.alpha) * 100, 0, 0);
		mat.Multiply(this.mat_name);
		v.SetWorldTransform(mat);

		if (v == this.name.top() && (this.cursor_inst.active || this.cursor_inst.ok) && this.action.Update == this.action.UpdateCharacterSelect)
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

	if (this.cursor_inst.active || this.cursor_inst.ok)
	{
		if (this.current_id != this.cursor_inst.val || this.action.Update == this.action.UpdateCharacterSelect && this.name.len() == 0)
		{
			this.current_id = this.cursor_inst.val;
			this.name.append(this.CreateName(this.cursor_inst.val));
		}
	}
};

for( local i = 0; i < 2; i = ++i )
{
	local v = {};
	v.priority <- priority;
	v.anime_set <- this.anime_set;
	func_init.call(v, i);
	v.Update <- func_update;
	this.data.push(v);
}
