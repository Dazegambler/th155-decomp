function ShowTitle( arg )
{
	local filename = arg[2];
	local image = this.Image();
	image.Create(filename);
	this.object_list.title <- image;
	local t = ::newthread(function ( t )
	{
		t.sprite.alpha = 0;
		t.Show();

		while (t.sprite.alpha < 1.00000000)
		{
			t.sprite.alpha += 0.10000000;
			this.suspend();
		}

		for( local i = 0; i < 120; i = ++i )
		{
			this.suspend();
		}

		while (t.sprite.alpha > 0.00000000)
		{
			t.sprite.alpha -= 0.10000000;
			this.suspend();
		}

		t.Hide();
	});
	t.call(image);
	::talk.async_task.title <- t;
}

function Change( arg )
{
	local name0 = arg[2];
	local name1 = arg[3];

	if (name0 in this.object_list)
	{
		this.object_list[name0].Hide(true);
		this.object_list[name0].Deactivate();
	}

	if (name1 in this.object_list)
	{
		this.current_obj = this.object_list[name1];
		this.current_obj.Activate();
		this.current_obj.Show(true);
		this.group[this.current_obj.group] <- this.current_obj;
	}
}

