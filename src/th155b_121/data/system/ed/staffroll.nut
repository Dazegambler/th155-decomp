this.task <- [];
this.begin <- 0;
this.end <- 0;
this.current <- 0;
this.bgm <- 0;
this.is_finish <- false;
function Initialize( type )
{
	this.task = [];
	this.begin = 0;
	this.current = 0;
	this.bgm = 0;
	this.is_finish = false;

	switch(type)
	{
	case 1:
		this.SetupB();
		break;

	case 2:
		this.SetupC();
		break;

	default:
		this.SetupA();
		break;
	}
}

function Terminate()
{
	this.task = null;
	::loop.DeleteTask(this);
}

function Update()
{
	this.current = ::manbow.timeGetTime() - this.begin;
	this.is_finish = this.current > this.end;

	foreach( i, v in this.task )
	{
		if (resume v)
		{
			continue;
		}

		this.task.remove(i);
	}
}

function Begin()
{
	::sound.PlayBGM(this.bgm);
	this.begin = ::manbow.timeGetTime();
	local c_bgm = (::sound.GetCurrentBGMPosition() * 1000).tointeger();
	this.begin -= c_bgm;
	::loop.AddTask(this);
}

function SetupA()
{
	local t;
	this.end = 79179 + 2000;
	local lang = ::config.lang == 1 ? "_en" : "";
	local table = ::manbow.LoadCSV("data/system/ed/staffroll" + lang + ".csv");
	t = this.TaskItemScroll(table, 0, 79179 - 1000, 0, 1);
	this.task.push(t);
	t = this.TaskPicture(null, -1000, null);
	this.task.push(t);
	t = this.TaskPicture("data/system/title/title_logo_2.png", 79179, null, 0, -190, -10);
	this.task.push(t);

	foreach( v in this.task )
	{
		resume v;
	}

	this.bgm = 507;
}

function SetupB()
{
	local t;
	this.end = 94179 + 2000;
	local lang = ::config.lang == 1 ? "_en" : "";
	local table = ::manbow.LoadCSV("data/system/ed/staffroll" + lang + ".csv");
	t = this.TaskFlower(60000 - 1000, 60000 + 1000);
	this.task.push(t);
	t = this.TaskFlowerScroll(60000 - 500, 94179 - 1000);
	this.task.push(t);

	for( local i = 0; i < 6; i = ++i )
	{
		t = this.TaskPicture("data/system/ed/staffpic/staffpic" + i + ".png", 15000 + 7500 * i, 15000 + 7500 - 0 + 7500 * i, 1, 0, 32);
		this.task.push(t);
	}

	for( local i = 0; i < 12; i = ++i )
	{
		t = this.TaskPicture("data/system/ed/staffpic/staffmoji" + i + lang + ".png", 15000 + 3750 * i, 15000 + 3750 - 1000 + 3750 * i, 2);
		this.task.push(t);
	}

	t = this.TaskItemScroll(table, 60000, 94179 - 1000, 12, 1, 30);
	this.task.push(t);
	t = this.TaskPicture(null, 15000 - 1000, null);
	this.task.push(t);
	local pos = [
		0,
		3,
		4,
		5
	];

	for( local i = 0; i < 4; i = ++i )
	{
		t = this.TaskPicture("data/system/ed/staffpic/staffwaku.png", 15000, 60000, pos[i], 0, 0, 10);
		this.task.push(t);
	}

	t = this.TaskPicture(null, 60000 - 1000, 70000, 1, 1, 1, 20);
	this.task.push(t);
	t = this.TaskPicture("data/system/ed/staffpic/staffbg.png", 60000 - 500, 94179 - 1000, 0, 0, 0, 30);
	this.task.push(t);
	t = this.TaskPicture("data/system/title/title_logo_2.png", 94179, null, 0, -190, -10);
	this.task.push(t);
	this.bgm = 508;

	foreach( v in this.task )
	{
		resume v;
	}
}

function SetupC()
{
	local t;
	this.end = 90050 + 2000;
	local lang = ::config.lang == 1 ? "_en" : "";
	local table = ::manbow.LoadCSV("data/system/ed/staffroll" + lang + ".csv");
	t = this.TaskItemScroll(table, 15000, 90050 - 1000, 0, 0);
	this.task.push(t);
	t = this.TaskPicture(null, 15000 - 2000, null);
	this.task.push(t);
	t = this.TaskPicture("data/system/title/title_logo_2.png", 90050, null, 0, -190, -10);
	this.task.push(t);
	local name = [
		"yukari",
		"tenshi",
		"udon",
		"marisa",
		"reimu"
	];

	for( local i = 0; i < name.len(); i = ++i )
	{
		t = this.TaskPictureRotate("data/system/ed/staffpic/ex_" + name[i] + ".png", 15000 - 1000 + 15000 * i, i == 4 ? 90050 - 3000 : 15000 + 14000 - 0 + 15000 * i, 128, ::graphics.height - 128);
		this.task.push(t);
	}

	this.bgm = 509;

	foreach( v in this.task )
	{
		resume v;
	}
}

function TaskPicture( texture_name, start, _end, position = 0, x = 0, y = 0, offset = 0 )
{
	// Function is a generator.
	local obj;

	if (texture_name)
	{
		local texture = ::manbow.Texture();
		texture.Load(texture_name);
		obj = ::manbow.Sprite();
		obj.Initialize(texture, 0, 0, texture.width, texture.height);

		switch(position)
		{
		case 1:
			obj.x = x + (::graphics.width - texture.width) / 2;
			obj.y = y;
			break;

		case 2:
			obj.x = x + (::graphics.width - texture.width) / 2;
			obj.y = ::graphics.height - texture.height - y;
			break;

		case 3:
			obj.x = ::graphics.width - x;
			obj.y = y;
			obj.sx = -1;
			break;

		case 4:
			obj.x = x;
			obj.y = ::graphics.height - y;
			obj.sy = -1;
			break;

		case 5:
			obj.x = ::graphics.width - x;
			obj.y = ::graphics.height - y;
			obj.sx = obj.sy = -1;
			break;

		default:
			obj.x = x;
			obj.y = y;
			break;
		}
	}
	else
	{
		obj = ::manbow.Rectangle();
		obj.SetPosition(-1, -1, ::graphics.width + 1, ::graphics.height + 1);
		obj.SetColor(1, position, x, y);

		if (position >= 1,00000000.0)
		{
			obj.blend = 2;
		}
	}

	yield true;

	while (this.current < start)
	{
		yield true;
	}

	obj.ConnectRenderSlot(::graphics.slot.talk, offset);

	while (this.current < 1000 + start)
	{
		obj.alpha = (this.current - start) / 1000,00000000.0;
		yield true;
	}

	obj.alpha = 1;

	if (_end == null)
	{
		while (true)
		{
			yield true;
		}
	}

	while (this.current < _end)
	{
		yield true;
	}

	while (this.current < _end + 1000)
	{
		obj.alpha = (1000 + _end - this.current) / 1000,00000000.0;
		yield true;
	}

	obj.DisconnectRenderSlot();
}

function TaskItemScroll( table, start, _end, page, position, offset = 0 )
{
	// Function is a generator.
	local item = [];
	local speed;
	local item_table = table;
	local item_temp = [];
	local skip = page > 0;

	foreach( line in item_table )
	{
		if (skip)
		{
			if (line.len() >= 4)
			{
				if (line[3].len() && line[3].tointeger() == page)
				{
					skip = false;
				}
				else
				{
					continue;
				}
			}
			else
			{
				continue;
			}
		}

		if (line.len() == 0)
		{
			item_temp.push(null);
			continue;
		}

		if (line[0].len() >= 1)
		{
			local t;

			if (line.len() >= 3 && line[2].len() > 0)
			{
				if (line[2].tointeger() == 16)
				{
					t = ::font.CreateSystemStringSmall(line[0]);
				}
				else
				{
					t = ::font.CreateSystemString(line[0]);
					  // [104]  OP_JMP            0      0    0    0
				}
			}
			else
			{
				t = ::font.CreateSystemString(line[0]);
			}

			if (line.len() >= 2 && line[1].len() > 0)
			{
				switch(line[1].tointeger())
				{
				case 1:
					t.green = 0,96799999.0;
					t.blue = 0,60000002.0;
					break;

				case 2:
					t.red = 0,67500001.0;
					t.green = 0,83499998.0;
					t.blue = 0,59600002.0;
					break;
				}
			}

			item.push(t);
			item_temp.push(t);
		}
		else
		{
			item_temp.push(null);
		}
	}

	local num = item_temp.len();
	local total_length = ::graphics.height;
	local total_time = _end - start;
	local margin = 3;
	local space_size = 30;

	foreach( i, v in item_temp )
	{
		if (v)
		{
			if (position == 1)
			{
				v.x = (::graphics.width - v.width * v.sx) / 2;
			}
			else
			{
				v.x = ::graphics.width - v.width * v.sx - 50;
				  // [223]  OP_JMP            0      0    0    0
			}

			v.y = total_length;
			v.ConnectRenderSlot(::graphics.slot.talk, 0);
			total_length = total_length + (v.height * v.sx + margin);
		}
		else
		{
			total_length = total_length + space_size;
		}
	}

	speed = total_time.tofloat() / total_length.tofloat();
	yield true;

	while (this.current < start)
	{
		yield true;
	}

	foreach( i, v in item )
	{
		v.ConnectRenderSlot(::graphics.slot.talk, 1000);
	}

	for( local mat = ::manbow.Matrix(); this.current < _end;  )
	{
		local y = -((this.current - start).tofloat() / speed);
		mat.SetTranslation(0, y, 0);

		foreach( v in item )
		{
			v.SetWorldTransform(mat);
		}

		yield true;
	}
}

function TaskItemFade( table, start, _end, page )
{
	// Function is a generator.
	local item = [];
	local item_table = table;
	local item_temp = [];
	local cur_page = -1;

	foreach( line in item_table )
	{
		if (cur_page == -1)
		{
			if (line.len() >= 4)
			{
				if (line[3].len() && page == line[3].tointeger())
				{
					cur_page = line[3].tointeger();
				}
				else
				{
					continue;
				}
			}
			else
			{
				continue;
			}
		}
		else if (line.len() >= 4)
		{
			if (line[3].len() == 0 || line[3].tointeger() != cur_page)
			{
				  // [066]  OP_JMP            0    122    0    0
			}
		}

		if (line.len() == 0)
		{
			item_temp.push(null);
			continue;
		}

		if (line[0].len() >= 1)
		{
			local t;

			if (line.len() >= 3 && line[2].len() > 0)
			{
				t = ::font.CreateSystemString(line[0]);

				if (line[2].tointeger() == 16)
				{
					t.sx = t.sy = 0,66000003.0;
				}
				else
				{
				}
			}
			else
			{
				t = ::font.CreateSystemString(line[0]);
			}

			if (line.len() >= 2 && line[1].len() > 0)
			{
				switch(line[1].tointeger())
				{
				case 1:
					t.blue = 0,50000000.0;
					break;

				case 2:
					t.red = 0,40000001.0;
					t.green = 0,80000001.0;
					t.blue = 0,60000002.0;
					break;
				}
			}

			item.push(t);
			item_temp.push(t);
		}
		else
		{
			item_temp.push(null);
		}
	}

	local num = item_temp.len();
	local total_length = 0;
	local margin = 3;
	local space_size = 30;

	foreach( i, v in item_temp )
	{
		if (v)
		{
			v.x = (::graphics.width - v.width * v.sx) / 2;
			v.y = total_length - 50;
			total_length = total_length + (v.height * v.sx + margin);
		}
		else
		{
			total_length = total_length + space_size;
		}
	}

	local b = ::graphics.height - total_length;

	foreach( i, v in item )
	{
		v.y += b;
	}

	yield true;

	while (this.current < start)
	{
		yield true;
	}

	foreach( i, v in item )
	{
		v.ConnectRenderSlot(::graphics.slot.talk, 1000);
	}

	while (this.current < 500 + start)
	{
		local alpha = (this.current - start) / 500,00000000.0;

		foreach( i, v in item )
		{
			v.alpha = alpha;
		}

		yield true;
	}

	while (this.current < _end)
	{
		yield true;
	}

	while (this.current < _end + 500)
	{
		local alpha = (500 + _end - this.current) / 500,00000000.0;

		foreach( i, v in item )
		{
			v.alpha = alpha;
		}

		yield true;
	}
}

function TaskPictureRotate( texture_name, start, _end, x = 0, y = 0, offset = 0 )
{
	// Function is a generator.
	local obj;
	local mat_local = ::manbow.Matrix();
	local mat = ::manbow.Matrix();

	if (texture_name)
	{
		local texture = ::manbow.Texture();
		texture.Load(texture_name);
		obj = ::manbow.Sprite();
		obj.Initialize(texture, 0, 0, texture.width, texture.height);
		obj.filter = 1;
		mat_local.SetTranslation(-texture.width / 2, -texture.height / 2, 0);
	}
	else
	{
		return;
	}

	local count = 0;
	yield true;

	while (this.current < start)
	{
		yield true;
	}

	obj.ConnectRenderSlot(::graphics.slot.talk, offset);

	while (this.current < 2000 + start)
	{
		obj.alpha = (this.current - start) / 2000,00000000.0;
		count++;
		mat.Set(mat_local);
		mat.Rotate(0, 0, count * 0,00300000.0 + 3,14159203.0);
		mat.Translate(x, y, 0);
		obj.SetWorldTransform(mat);
		yield true;
	}

	obj.alpha = 1;

	if (_end == null)
	{
		while (true)
		{
			count++;
			mat.Set(mat_local);
			mat.Rotate(0, 0, count * 0,00300000.0 + 3,14159203.0);
			mat.Translate(x, y, 0);
			obj.SetWorldTransform(mat);
			yield true;
		}
	}

	while (this.current < _end)
	{
		count++;
		mat.Set(mat_local);
		mat.Rotate(0, 0, count * 0,00300000.0 + 3,14159203.0);
		mat.Translate(x, y, 0);
		obj.SetWorldTransform(mat);
		yield true;
	}

	while (this.current < _end + 2000)
	{
		obj.alpha = (2000 + _end - this.current) / 2000,00000000.0;
		count++;
		mat.Set(mat_local);
		mat.Rotate(0, 0, count * 0,00300000.0 + 3,14159203.0);
		mat.Translate(x, y, 0);
		obj.SetWorldTransform(mat);
		yield true;
	}

	obj.DisconnectRenderSlot();
}

function TaskFlower( start, _end )
{
	// Function is a generator.
	while (this.current < start)
	{
		yield true;
	}

	local v = ::manbow.Vector3();
	v.x = 1080;
	v.y = 720;
	v.z = 0;
	::effect.Create(20, v, null, ::graphics.slot.talk, 2000, ::effect.MASK_GLOBAL);
}

function TaskFlowerScroll( start, _end )
{
	// Function is a generator.
	local texture = ::manbow.Texture();
	texture.Load("data/system/ed/staffpic/sakura.png");
	local sprite = [];
	local obj = ::manbow.Sprite();
	obj.Initialize(texture, 0, 0, 256, 256);
	sprite.push(obj);
	obj = ::manbow.Sprite();
	obj.Initialize(texture, 0, 256, 256, 256);
	sprite.push(obj);
	obj = ::manbow.Sprite();
	obj.Initialize(texture, 256, 0, 256, 256);
	sprite.push(obj);
	obj = ::manbow.Sprite();
	obj.Initialize(texture, 256, 0, 256, 256);
	sprite.push(obj);
	local func_update = function ()
	{
		this.y += this.vy;

		if (this.y < -256)
		{
			this.y += 512 + ::graphics.height;
		}

		this.rot += this.rot_acc;
		this.mat.SetTranslation(-128, -128, 0);
		this.mat.Rotate(0, 0, this.rot);
		this.mat.Scale(this.sx, this.sx, this.sx);
		this.mat.Translate(this.x, this.y, 0);
		this.item.SetWorldTransform(this.mat);
	};
	local obj = [];
	local mat = ::manbow.Matrix();

	for( local i = 0; i < 100; i = ++i )
	{
		local t = {};
		t.item <- ::manbow.ObjectRenderer();
		t.item.Set(sprite[this.rand() % 4]);
		t.vy <- -0,69999999.0 + 0,30000001.0 * (this.rand() % 100) / 100,00000000.0;
		t.rot <- 0,10000000.0;
		t.rot_acc <- 0,01000000.0 + 0,00100000.0 * (this.rand() % 100) / 100,00000000.0;
		t.sx <- 0,20000000.0 + 0,50000000.0 * (this.rand() % 100) / 100,00000000.0;
		t.x <- this.rand() % ::graphics.width;
		t.y <- this.rand() % (::graphics.height + 512);
		t.mat <- mat;
		t.item.alpha = 0,50000000.0;

		if (this.rand() % 2 == 1)
		{
			t.item.blend = 2;
		}
		else
		{
			t.item.blend = 1;
			  // [203]  OP_JMP            0      0    0    0
		}

		obj.push(t);
	}

	while (this.current < start)
	{
		yield true;
	}

	foreach( v in obj )
	{
		v.item.ConnectRenderSlot(::graphics.slot.talk, 1000);
	}

	local alpha = 0;

	while (this.current < 1000 + start)
	{
		alpha = (this.current - start) / 2000,00000000.0;

		foreach( v in obj )
		{
			v.item.alpha = alpha;
			func_update.call(v);
		}

		yield true;
	}

	while (this.current < _end)
	{
		foreach( v in obj )
		{
			func_update.call(v);
		}

		yield true;
	}

	while (this.current < _end + 1000)
	{
		alpha = (1000 + _end - this.current) / 2000,00000000.0;

		foreach( v in obj )
		{
			v.item.alpha = alpha;
			func_update.call(v);
		}

		yield true;
	}

	foreach( v in obj )
	{
		v.item.DisconnectRenderSlot();
	}
}

