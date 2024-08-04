function Initialize()
{
	local item_table = ::manbow.LoadCSV("data/system/ed/staffroll.csv");
	local texture = ::manbow.Texture();
	texture.Load("data/system/title/op_000.png");
	this.sprite0 <- ::manbow.Sprite();
	this.sprite0.Initialize(texture, 0, 0, texture.width, texture.height);
	texture = ::manbow.Texture();
	texture.Load("data/system/title/op_001.png");
	this.sprite1 <- ::manbow.Sprite();
	this.sprite1.Initialize(texture, 0, 0, texture.width, texture.height);
	this.begin <- 0;
	this.current <- 0;
	this.task <- [];
	local func = function ( sprite, start, end )
	{
		while (this.current < start)
		{
			this.suspend();
		}

		sprite.ConnectRenderSlot(::graphics.slot.front, 61000);

		while (this.current < 250 + start)
		{
			sprite.red = sprite.green = sprite.blue = (this.current - start) / 250,00000000.0;
			this.suspend();
		}

		sprite.red = sprite.green = sprite.blue = 1;

		while (this.current < 2000 + start)
		{
			this.suspend();
		}

		while (this.current < 2500 + start)
		{
			sprite.red = sprite.green = sprite.blue = (2500 + start - this.current) / 500,00000000.0;
			this.suspend();
		}

		sprite.red = sprite.green = sprite.blue = 0;

		while (this.current < end)
		{
			this.suspend();
		}
	}.bindenv(this);
	local t = ::newthread(func);
	t.call(this.sprite0, 0, 3000);
	this.task.push(t);
	t = ::newthread(func);
	t.call(this.sprite1, 3000, 4500);
	this.task.push(t);
	t = ::newthread(function ()
	{
		local end = 6000;

		while (this.current < end)
		{
			this.suspend();
		}

		this.sprite0.DisconnectRenderSlot();
		::menu.title.Update = ::menu.title.UpdateMain;

		while (this.current < 1000 + end)
		{
			this.sprite1.alpha = (1000 + end - this.current) / 1000,00000000.0;
			this.suspend();
		}

		this.sprite1.DisconnectRenderSlot();
	}.bindenv(this));
	t.call();
	this.task.push(t);
	::sound.PlayBGM(::savedata.GetTitleBGMID());
	this.begin = ::manbow.timeGetTime();
	local c_bgm = (::sound.GetCurrentBGMPosition() * 1000).tointeger();
	this.begin -= c_bgm;
	this.current = this.begin;
	::loop.AddTask(this);
}

function Terminate()
{
	this.task = null;
	this.sprite0 = null;
	this.sprite1 = null;
	::loop.DeleteTask(this);
}

function Update()
{
	this.current = ::manbow.timeGetTime() - this.begin;

	foreach( i, v in this.task )
	{
		v.wakeup();

		if (v.getstatus() == "idle")
		{
			this.task.remove(i);
		}
	}

	if (this.task.len() == 0)
	{
		this.Terminate();
	}
}

