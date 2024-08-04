this.anime_set <- ::actor.LoadAnimationData("data/system/practice/practice.pat");
function Initialize()
{
	this.action <- ::menu.practice.weakref();
	local texture = ::manbow.Texture();
	texture.Load("data/system/practice/practice_part000.png");
	function create_sprite( name )
	{
		local res = this.anime_set[name];
		local sprite = ::manbow.Sprite();
		sprite.Initialize(texture, res.left, res.top, res.width, res.height);
		sprite.ConnectRenderSlot(::graphics.slot.overlay, 0);
		return sprite;
	}

	local item_table = ::menu.common.LoadItemTextArray("data/system/practice/item.csv");
	this.indicator <- {};
	this.indicator.life <- [
		"life",
		"regain",
		"life_back"
	];
	this.indicator.sp <- [
		"sp",
		"sp_back"
	];
	this.indicator.mp <- [
		"mp",
		"mp_back"
	];
	this.indicator.op <- [
		"occult",
		"occult_back"
	];
	this.indicator.position <- [
		"position_cursor_a",
		"position_cursor_b",
		"position_back"
	];
	local update_position = function ()
	{
		if (this.cursor.active)
		{
			if (!this.active)
			{
				this.highlight.Set(this.text.x - 8, this.text.y + 10, this.text.x + this.width + 8, this.text.y + ::font.system_size + 13);
				this.active = true;
			}
		}
		else if (this.active)
		{
			this.highlight.Reset();
			this.active = false;
		}

		if (this.cursor.val == 0)
		{
			this.text.SetWorldTransform(this.mat_world);
			this.text.visible = true;
			this.obj_a.visible = this.obj_b.visible = this.back.visible = false;
		}
		else
		{
			this.text.visible = false;
			this.back.visible = true;
			this.back.SetWorldTransform(this.mat_world);
			local x = this.width * (this.cursor.val - 1) / (this.cursor.item_num - 1);

			if (this.cursor.val % 4 == 1)
			{
				this.obj_a.x = this.back.x + x;
				this.obj_a.visible = true;
				this.obj_b.visible = false;
				this.obj_a.SetWorldTransform(this.mat_world);
			}
			else
			{
				this.obj_b.x = this.back.x + x;
				this.obj_a.visible = false;
				this.obj_b.visible = true;
				this.obj_b.SetWorldTransform(this.mat_world);
			}
		}
	};
	local update_indicator = function ()
	{
		if (this.cursor.active)
		{
			if (!this.active)
			{
				this.highlight.Set(this.text.x - 8, this.text.y + 10, this.text.x + this.res.width + 8, this.text.y + ::font.system_size + 13);
				this.active = true;
			}
		}
		else if (this.active)
		{
			this.highlight.Reset();
			this.active = false;
		}

		if (this.cursor.val == 0)
		{
			this.text.SetWorldTransform(this.mat_world);
			this.text.visible = true;
			this.back.visible = false;
			this.bar.visible = false;
		}
		else
		{
			this.text.visible = false;
			this.back.visible = true;
			this.bar.visible = true;
			this.bar.SetUV(this.res.left, this.res.top, this.res.width * (this.cursor.val - 1) / (this.cursor.item_num - 2), this.res.height);
			this.bar.Update();
			this.bar.SetWorldTransform(this.mat_world);
			this.back.SetWorldTransform(this.mat_world);
		}
	};
	local update_life_indicator = function ()
	{
		if (this.cursor.active || this.cursor2.active)
		{
			if (!this.active)
			{
				this.highlight.Set(this.text.x - 8, this.text.y + 10, this.text.x + this.res.width + 8, this.text.y + ::font.system_size + 13);
				this.active = true;
			}
		}
		else if (this.active)
		{
			this.highlight.Reset();
			this.active = false;
		}

		if (this.cursor.val == 0)
		{
			this.text.SetWorldTransform(this.mat_world);
			this.text.visible = true;
			this.back.visible = false;
			this.bar.visible = false;
			this.bar2.visible = false;
		}
		else
		{
			this.text.visible = false;
			this.back.visible = true;
			this.bar.visible = true;
			this.bar.SetUV(this.res.left, this.res.top, this.res.width * (this.cursor.val - 1) / (this.cursor.item_num - 2), this.res.height);
			this.bar.Update();
			this.bar2.visible = true;
			this.bar2.SetUV(this.res2.left, this.res2.top, this.res2.width * (this.cursor2.val - 1) / (this.cursor2.item_num - 2), this.res2.height);
			this.bar2.Update();
			this.bar.SetWorldTransform(this.mat_world);
			this.bar2.SetWorldTransform(this.mat_world);
			this.back.SetWorldTransform(this.mat_world);
		}
	};
	local show = function ()
	{
		this.text.visible = true;
	};
	local hide = function ()
	{
		this.text.visible = false;

		foreach( v in this.obj )
		{
			v.visible = false;
		}
	};
	local left = ::menu.common.item_x - 240;
	local top = ::menu.common.item_y - 32;
	local res;
	this.cursor_x <- left - 20;
	this.cursor_y <- top + 16;
	this.space <- 32;
	local highlight = this.UIItemHighlight();
	this.cur_page <- this.action.cursor_page.val;
	this.page <- [
		{},
		{},
		{},
		{}
	];

	foreach( i, p in this.page )
	{
		p.state <- -2;
		p.x <- -1280;
		p.y <- 0;
		p.visible <- true;
		p.title <- this.create_sprite("title_p" + (i + 1));
		p.title.x = ::menu.common.title_x - this.anime_set["title_p" + (i + 1)].width / 2;
		p.title.y = ::menu.common.title_y - 32;
		p.ui <- this.UIBase();
		p.ui.action = p.weakref();
		p.ui.target = p.weakref();
		p.cursor <- this.action.cursor_item_list[i];
		p.mat_world <- ::manbow.Matrix();
		p.text <- [];
		p.item <- [];

		foreach( j, v in this.action.item_list[i] )
		{
			if (v == null)
			{
				p.item.append(null);
				continue;
			}

			local cur_table = item_table[v];
			local text = ::font.CreateSystemString(cur_table[0]);
			text.ConnectRenderSlot(::graphics.slot.overlay, 0);
			text.x = left;
			text.y = top - 8 + j * this.space;
			p.text.append(text);
			local item = {};
			p.item.append(item);
			item.text <- text;
			item.select_obj <- null;

			if (!(v in this.action.page[i].cursor))
			{
				continue;
			}

			if (v in this.indicator)
			{
				local t = {};
				t.obj <- [];
				t.cursor <- this.action.page[i].cursor[v];
				t.mat_world <- p.mat_world;
				t.text <- ::font.CreateSystemString(::menu.common.GetMessageText("no_setting"));
				t.text.ConnectRenderSlot(::graphics.slot.overlay, 0);
				t.text.x = text.x + 240;
				t.text.y = text.y;
				t.text.blue = 0;
				t.active <- false;
				t.highlight <- highlight;

				if (v == "position")
				{
					t.Update <- update_position;
					local res = this.anime_set["position" + (i == 0 ? "_1p" : "_2p")];
					t.width <- res.width + 2;
					t.back <- this.create_sprite("position" + (i == 0 ? "_1p" : "_2p"));
					t.obj_a <- this.create_sprite("position_cursor_a" + (i == 0 ? "_1p" : "_2p"));
					t.obj_b <- this.create_sprite("position_cursor_b" + (i == 0 ? "_1p" : "_2p"));
					t.back.x = text.x + 240;
					t.back.y = text.y + 12 + ::font.system_size / 2 - res.height / 2;
					t.obj_a.x = t.obj_b.x = t.back.x;
					t.obj_a.y = t.obj_b.y = t.back.y;
					t.obj.push(t.back);
					t.obj.push(t.obj_a);
					t.obj.push(t.obj_b);
				}
				else if (v == "life")
				{
					t.cursor2 <- this.action.page[i].cursor.regain;
					t.Update <- update_life_indicator;
					t.back <- this.create_sprite(this.indicator[v].top());
					local n = this.indicator.life[1] + (i == 0 ? "_1p" : "_2p");
					t.res2 <- this.anime_set[n];
					t.bar2 <- this.create_sprite(n);
					n = this.indicator.life[0] + (i == 0 ? "_1p" : "_2p");
					t.res <- this.anime_set[n];
					t.bar <- this.create_sprite(n);
					t.bar.x = text.x + 240;
					t.bar.y = text.y + 12 + ::font.system_size / 2 - t.res.height / 2;
					t.bar2.x = t.bar.x;
					t.bar2.y = t.bar.y;
					t.back.x = t.bar.x;
					t.back.y = t.bar.y;
					t.obj.push(t.back);
					t.obj.push(t.bar2);
					t.obj.push(t.bar);
				}
				else
				{
					t.Update <- update_indicator;
					local n = this.indicator[v][0] + (i == 0 ? "_1p" : "_2p");
					t.res <- this.anime_set[n];
					t.back <- this.create_sprite(this.indicator[v].top());
					t.bar <- this.create_sprite(n);
					t.bar.x = text.x + 240;
					t.bar.y = text.y + 12 + ::font.system_size / 2 - t.res.height / 2;
					t.back.x = t.bar.x;
					t.back.y = t.bar.y;
					t.obj.push(t.back);
					t.obj.push(t.bar);
				}

				t.Show <- show;
				t.Hide <- hide;
				item.select_obj = t;
				continue;
			}

			item.select_obj = this.UIItemSelectorSingle(cur_table.slice(1), text.x + (i == 2 ? 320 : 240), text.y, p.mat_world, this.action.page[i].cursor[v]);
			item.select_obj.SetColor(1, 1, 0);
		}
	}

	this.page[this.cur_page].ui.Activate(-1);
	::loop.AddTask(this);
}

function Terminate()
{
	foreach( i, p in this.page )
	{
		p.title = null;
		p.text = [];
		p.item = [];
	}

	this.page = null;
	::loop.DeleteTask(this);
}

function Show()
{
	foreach( v in this.page )
	{
		v.visible = true;
		v.title.visible = true;

		foreach( i, t in v.item )
		{
			if (t == null)
			{
				continue;
			}

			t.text.visible = true;

			if (t.select_obj)
			{
				t.select_obj.Show();
			}
		}
	}
}

function Hide()
{
	foreach( v in this.page )
	{
		v.visible = false;
		v.title.visible = false;

		foreach( i, t in v.item )
		{
			if (t == null)
			{
				continue;
			}

			t.text.visible = false;

			if (t.select_obj)
			{
				t.select_obj.Hide();
			}
		}
	}
}

function Update()
{
	if (this.action.cursor_page.diff)
	{
		this.page[this.cur_page].state = -this.action.cursor_page.diff;
		this.cur_page = this.action.cursor_page.val;
		this.page[this.cur_page].ui.Activate(this.action.cursor_page.diff);
	}
	else
	{
		this.page[this.cur_page].state = this.action.state;
	}

	if (this.action.state == 0)
	{
		::menu.cursor.SetTarget(this.cursor_x, this.cursor_y + this.action.cursor_item.val * this.space, 0,69999999.0);
	}

	foreach( v in this.page )
	{
		v.ui.Update();

		if (!v.visible)
		{
			continue;
		}

		v.mat_world.SetTranslation(v.x, v.y, 0);
		v.title.SetWorldTransform(v.mat_world);

		foreach( i, t in v.item )
		{
			if (t == null)
			{
				continue;
			}

			t.text.SetWorldTransform(v.mat_world);
			i = v.cursor.val == i ? 1,00000000.0 : 0,50000000.0;
			t.text.red = t.text.green = t.text.blue = i;

			if (t.select_obj)
			{
				t.select_obj.Update();
			}
		}
	}
}

