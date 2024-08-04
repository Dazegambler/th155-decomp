local priority = 60000;
local func_init = function ( i )
{
	this.action <- ::menu.character_select.weakref();
	this.handle_name <- {};

	if (::config.lang == 1)
	{
		::manbow.LoadCSVtoTable("data/system/select/name/handle_name_en.csv", this.handle_name);
		this.handle_name2 <- [
			"duo",
			"trio",
			"quartet"
		];
		this.conj <- " & ";
		this.space <- " ";
	}
	else
	{
		::manbow.LoadCSVtoTable("data/system/select/name/handle_name.csv", this.handle_name);
		this.handle_name2 <- [
			"二人",
			"三人",
			"四人"
		];
		this.conj <- "";
		this.space <- "";
	}

	this.side <- i;
	this.dir <- this.side == 0 ? 1 : -1;
	this.cursor_master <- this.action.t[this.side].cursor_master;
	this.cursor_slave <- this.action.t[this.side].cursor_slave;
	this.name <- [];
	this.mat_name <- ::manbow.Matrix();
	this.mat_name.SetTranslation(640 - this.dir * 630, 524, 0);
	function CreateName()
	{
		local t;

		if (this.character_name[this.master_id] == "doremy" || this.character_name[this.slave_id] == "doremy")
		{
			t = this.handle_name.doremy.master;
		}
		else
		{
			t = this.handle_name[this.character_name[this.master_id]].master;
			t = t + (this.conj + this.handle_name[this.character_name[this.slave_id]].slave);
		}

		local n = this.handle_name[this.character_name[this.master_id]].count + this.handle_name[this.character_name[this.slave_id]].count;
		t = t + (this.space + this.handle_name2[n - 2]);
		local f = ::font.CreateSystemString(t);
		f.SetWorldTransform(this.mat_name);
		f.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
		f.alpha = 0;

		if (f.width > 450)
		{
			f.sx = 450,00000000.0 / f.width;
		}

		if (this.side == 1)
		{
			f.x = -f.width * f.sx;
		}

		f.Update();
		return f;
	}

	this.master_id <- -1;
	this.slave_id <- -1;
};
local func_update = function ()
{
	local mat = ::manbow.Matrix();

	if (this.cursor_slave.ok)
	{
		if (this.master_id != this.cursor_master.val || this.slave_id != this.cursor_slave.val || this.name.len() == 0)
		{
			this.master_id = this.cursor_master.val;
			this.slave_id = this.cursor_slave.val;
			this.name.push(this.CreateName());
		}
	}
	else
	{
		this.master_id = this.slave_id = -1;
	}

	foreach( i, v in this.name )
	{
		mat.SetTranslation(-this.dir * (1,00000000.0 - v.alpha) * 500, 0, 0);
		mat.Multiply(this.mat_name);
		v.SetWorldTransform(mat);

		if (v == this.name.top() && this.cursor_slave.ok && this.action.Update == this.action.UpdateCharacterSelect)
		{
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
			this.name.remove(i);
		}
	}
};

for( local i = 0; i < 2; i = ++i )
{
	local v = {};
	v.priority <- priority;
	func_init.call(v, i);
	v.Update <- func_update;
	this.data.push(v);
}
