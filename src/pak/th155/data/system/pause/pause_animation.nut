this.anime_set <- ::actor.LoadAnimationData("data/system/pause/pause.pat");
function Initialize()
{
	this.action <- ::menu.pause.weakref();
	this.x <- 0;
	this.y <- 0;
	this.visible <- true;
	this.item <- [];
	local texture = ::manbow.Texture();
	texture.Load("data/system/pause/pause.png");
	local res = this.anime_set.title;
	this.title <- ::manbow.Sprite();
	this.title.Initialize(texture, res.left, res.top, res.width, res.height);
	this.item.push(this.title);
	local item_table = ::menu.common.LoadItemText("data/system/pause/item.csv");
	::menu.common.InitializeLayout.call(this, null, item_table);
	local data = ::sound.GetCurrentBGMData();

	if (data)
	{
		local _title = ::font.CreateSystemString(data.title);
		local author = ::font.CreateSystemString(data.author);
		author.sx = author.sy = 0.69999999;
		local w = _title.width;
		local w2 = author.width * author.sx;

		if (w2 > w)
		{
			w = w2;
		}

		w = (w + 128) / 2;
		_title.x = ::graphics.width / 2 - w;
		_title.y = 585;
		author.x = ::graphics.width / 2 + w - w2;
		author.y = _title.y + 32;
		local t = ::manbow.ObjectRenderer();
		t.Set(::menu.cursor.under);
		t.x = ::graphics.width / 2 - w;
		t.y = _title.y + 25;
		t.sx = w / 256.00000000;
		this.item.push(t);
		this.item.push(_title);
		this.item.push(author);
	}

	foreach( v in this.item )
	{
		v.ConnectRenderSlot(::graphics.slot.front, 0);
	}

	::loop.AddTask(this);
}

function Terminate()
{
	::menu.common.TerminateLayout.call(this);
	this.item = null;
	this.title = null;
	::menu.cursor.under.DisconnectRenderSlot();
	::loop.DeleteTask(this);
}

function Update()
{
	::menu.common.UpdateLayout.call(this, this);

	foreach( v in this.item )
	{
		v.SetWorldTransform(this.mat_world);
	}
}

function Show()
{
	foreach( v in this.text )
	{
		if (v)
		{
			v.visible = true;
		}
	}

	foreach( v in this.item )
	{
		v.visible = true;
	}
}

function Hide()
{
	foreach( v in this.text )
	{
		if (v)
		{
			v.visible = false;
		}
	}

	foreach( v in this.item )
	{
		v.visible = false;
	}
}

