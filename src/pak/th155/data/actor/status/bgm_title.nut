class this.BGMTitle 
{
	id = 0;
	item = null;
	count = 0;
	x = 0;
	Update = null;
	function Activate()
	{
		local d = ::sound.GetCurrentBGMData();

		if (d == null)
		{
			return;
		}

		this.item = [];
		local title = ::font.CreateSystemString(d.title);
		local author = ::font.CreateSystemString(d.author);
		local w = (title.width < author.width * 0.69999999 ? author.width * 0.69999999 : title.width) + 20;
		title.x = ::graphics.width - title.width - 10;
		title.y = 640;
		author.sx = author.sy = 0.69999999;
		author.x = ::graphics.width - author.width * author.sx - 10;
		author.y = title.y + 32;
		local t = ::manbow.ObjectRenderer();
		t.Set(::menu.cursor.under);
		t.x = ::graphics.width - w;
		t.y = title.y + 24;
		t.filter = 1;
		t.sx = w / 512.00000000;
		this.item.push(t);
		this.item.push(title);
		this.item.push(author);
		this.count = 60;
		this.x = this.count * this.count;
		local mat = ::manbow.Matrix();
		mat.SetTranslation(this.x, 0, 0);

		foreach( v in this.item )
		{
			v.SetWorldTransform(mat);
			v.ConnectRenderSlot(::graphics.slot.info, 1300);
		}

		this.Update = this.State0;
		::battle.AddTask(this);
	}

	function Deactivate()
	{
		if (this.Update == this.State0)
		{
			this.Update = this.State2;
		}
		else if (this.Update == this.State1)
		{
			this.count = 0;
			this.Update = this.State2;
		}
	}

	function State0()
	{
		this.x = this.count * this.count;
		local mat = ::manbow.Matrix();
		mat.SetTranslation(this.x, 0, 0);

		foreach( v in this.item )
		{
			v.SetWorldTransform(mat);
		}

		if (this.count-- == 0)
		{
			this.Update = this.State1;
			this.count = 180;
		}
	}

	function State1()
	{
		if (this.count-- == 0)
		{
		}
	}

	function State2()
	{
		this.x = this.count * this.count;
		local mat = ::manbow.Matrix();
		mat.SetTranslation(this.x, 0, 0);

		foreach( v in this.item )
		{
			v.SetWorldTransform(mat);
		}

		if (this.count++ > 60)
		{
			::battle.DeleteTask(this);
		}
	}

}

