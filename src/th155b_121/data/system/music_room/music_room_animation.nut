function Initialize()
{
	this.action <- ::menu.music_room.weakref();
	this.anime_set <- ::actor.LoadAnimationData("data/system/music_room/music_room.pat");
	local texture = ::manbow.Texture();
	texture.Load("data/system/music_room/object.png");
	local res = this.anime_set.title;
	this.title <- ::manbow.Sprite();
	this.title.Initialize(texture, res.left, res.top, res.width, res.height);
	this.title.ConnectRenderSlot(::graphics.slot.front, 0);
	this.title.x = ::menu.common.title_x - res.width / 2;
	this.title.y = ::menu.common.title_y - 20;
	this.pager <- this.UIPager();
	this.page <- [];
	this.margin <- 42;
	local space = 20;
	local scale = 0,69999999.0;

	foreach( p, _page in this.action.page )
	{
		local t = {};
		t.x <- 1280;
		t.y <- 0;
		t.visible <- true;
		this.page.append(t);
		local ui = this.UIBase();
		ui.target = t.weakref();
		ui.ox = 0;
		this.pager.Append(ui);
		t.item <- [];
		local w_max0 = 0;
		local w_max1 = 0;

		foreach( i, v in _page )
		{
			local obj = [];
			local w = 0;
			local text = ::font.CreateSystemString(v.title);
			text.ConnectRenderSlot(::graphics.slot.front, 0);
			text.y = ::menu.common.item_y + i * this.margin - 24 - 10;
			obj.push(text);
			w = text.width + space;
			local author = ::font.CreateSystemString(v.author);
			author.ConnectRenderSlot(::graphics.slot.front, 0);
			obj.push(author);
			author.sy = scale;
			author.sx = scale * 0,75000000.0;

			if (v.comment2.len())
			{
				local comment = ::font.CreateSystemString(v.comment);
				comment.ConnectRenderSlot(::graphics.slot.front, 0);
				obj.push(comment);
				local comment2 = ::font.CreateSystemString(v.comment2);
				comment2.ConnectRenderSlot(::graphics.slot.front, 0);
				obj.push(comment2);
				comment2.sy = comment.sy = scale;
				comment2.sx = comment.sx = scale * 0,75000000.0;
				author.y = text.y - 8;
				comment.y = author.y + 18;
				comment2.y = comment.y + 18;
				local _w = comment.width * comment.sx;

				if (_w < author.width)
				{
					_w = author.width;
				}

				if (_w < comment2.width * comment2.sx)
				{
					_w = comment2.width * comment2.sx;
				}

				w = w + _w;
			}
			else if (v.comment.len())
			{
				local comment = ::font.CreateSystemString(v.comment);
				comment.ConnectRenderSlot(::graphics.slot.front, 0);
				obj.push(comment);
				comment.sy = scale;
				comment.sx = scale * 0,75000000.0;
				author.y = text.y;
				comment.y = text.y + 18;
				w = w + (comment.width > author.width ? comment.width : author.width) * author.sx;
			}
			else
			{
				author.y = text.y + 9;
				w = w + author.width * author.sx;
			}

			t.item.push(obj);

			if (w_max0 < text.width)
			{
				w_max0 = text.width;
			}

			if (w_max1 < w)
			{
				w_max1 = w;
			}
		}

		foreach( v in t.item )
		{
			v[0].x = (::graphics.width - w_max1) / 2;
			v[1].x = v[0].x + w_max0 + space;

			if (v.len() >= 3)
			{
				v[2].x = v[1].x;
			}

			if (v.len() >= 4)
			{
				v[3].x = v[1].x;
			}
		}
	}

	this.pager.Activate(0);
	this.cur_page <- this.action.cursor_page.val;
	this.page_index <- ::font.CreateSystemString("page 1/1");
	this.page_index.x = 1200;
	this.page_index.y = 660;
	this.page_index.ConnectRenderSlot(::graphics.slot.front, 0);
	::loop.AddTask(this);
}

function Terminate()
{
	::loop.DeleteTask(this);
	this.pager = null;
	this.page = null;
	this.title = null;
	this.page_index = null;
	this.anime_set = null;
}

function Update()
{
	this.pager.Set(this.action.cursor_page.val);
	local mat = ::manbow.Matrix();

	foreach( p, _page in this.page )
	{
		mat.SetTranslation(_page.x, 0, 0);

		foreach( i, _item in _page.item )
		{
			foreach( obj in _item )
			{
				obj.visible = _page.visible;

				if (obj.visible)
				{
					obj.SetWorldTransform(mat);

					if (i == this.action.cur_index && p == this.action.cur_page)
					{
						obj.red = obj.green = 1,00000000.0;
						obj.blue = 0,50000000.0;
					}
					else
					{
						obj.red = obj.green = obj.blue = i == this.action.cursor.val ? 1 : 0,50000000.0;
					}
				}
			}
		}
	}

	local t = this.page[this.action.cursor_page.val].item[this.action.cursor.val][0];
	::menu.cursor.SetTarget(t.x - 20, t.y + 23, 0,69999999.0);
	this.page_index.Set("page " + (this.action.cursor_page.val + 1) + "/" + this.action.cursor_page.item_num);
	this.page_index.x = 1200 - this.page_index.width;
}

