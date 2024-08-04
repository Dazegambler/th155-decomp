this.help <- [
	"B1",
	"play",
	null,
	"B2",
	"return",
	null,
	"UD",
	"select",
	null,
	"LR",
	"page"
];
this.data <- [];
this.page <- [];
this.cur_index <- -1;
this.cur_page <- -1;
this.anime <- {};
::manbow.CompileFile("data/system/music_room/music_room_animation.nut", this.anime);
function Initialize()
{
	::manbow.CompileFile("data/system/music_room/music_room_animation.nut", this.anime);
	::loop.Begin(this);
	this.data = [];

	foreach( i, v in ::sound.bgm.data )
	{
		if (v.page < 0)
		{
			continue;
		}

		local t = {};
		t.id <- i;
		t.page <- v.page;
		t.track_no <- v.track_no;

		if (i in ::savedata.bgm || v.hidden == 0)
		{
			t.enable <- true;
			t.title <- v.title;
			t.author <- v.author;
			t.comment <- v.comment;
		}
		else
		{
			t.enable <- false;
			t.title <- "？？？？？？？？？";
			t.author <- "？？？？？？？？？";
			t.comment <- "";
		}

		this.data.append(t);
	}

	local compare = function ( a, b )
	{
		if (a.page > b.page)
		{
			return 1;
		}
		else if (a.page < b.page)
		{
			return -1;
		}

		if (a.track_no > b.track_no)
		{
			return 1;
		}
		else if (a.track_no < b.track_no)
		{
			return -1;
		}

		return 0;
	};
	this.data.sort(compare);
	this.page <- [];
	local current_page = -1;

	foreach( i, v in this.data )
	{
		if (current_page != v.page)
		{
			current_page = v.page;
			this.page.append([]);
		}

		this.page.top().append(v);
	}

	this.cursor <- this.Cursor(0, this.page[0].len(), ::input_all);
	this.cursor.se_ok = 0;
	this.cursor_page <- this.Cursor(1, this.page.len(), ::input_all);
	this.cursor_page.enable_ok = false;
	this.cursor_page.enable_cancel = false;
	this.cur_index = -1;
	this.cur_page = -1;
	::menu.cursor.Activate();
	::menu.back.Activate();
	::menu.help.Set(this.help);
	this.BeginAnime();
}

function Terminate()
{
	this.page.resize(0);
	this.data.resize(0);
	::menu.back.Deactivate(true);
	::menu.cursor.Deactivate();
	::menu.help.Reset();
	this.EndAnime();
}

function Suspend()
{
}

function Resume()
{
}

function Update()
{
	this.cursor_page.Update();

	if (this.cursor_page.diff)
	{
		local prev = this.cursor.val;
		this.cursor <- this.Cursor(0, this.page[this.cursor_page.val].len(), ::input_all);
		this.cursor.se_ok = 0;
		this.cursor.val = this.cursor.item_num <= prev ? this.cursor.item_num - 1 : prev;
	}

	this.cursor.Update();

	if (this.cursor.ok)
	{
		if (this.page[this.cursor_page.val][this.cursor.val].enable)
		{
			this.cur_index = this.cursor.val;
			this.cur_page = this.cursor_page.val;
			::sound.PlayBGM(this.page[this.cursor_page.val][this.cursor.val].id);
		}
		else
		{
		}

		return;
	}
	else if (this.cursor.cancel)
	{
		::sound.StopBGM(500);
		::loop.EndWithFade();
		::input_all.Lock();
	}
}

