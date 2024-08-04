this.staffroll <- {};
::manbow.CompileFile("data/system/ed/staffroll.nut", this.staffroll);
this.Update <- null;
this.count <- 0;
this.message <- null;
this.back <- null;
this.skip <- false;
this.fade <- ::manbow.Rectangle();
this.fade.SetPosition(-1, -1, ::graphics.width + 1, ::graphics.height + 1);
this.fade.SetColor(0, 0, 0, 0);
this.fade_task <- {};
this.fade_task.Update <- function ()
{
	if (::ed.fade.alpha < 1)
	{
		::ed.fade.alpha += 0,05000000.0;
	}
	else
	{
		::loop.DeleteTask(this);
	}
};
function Initialize()
{
	::loop.Move(this);
	this.fade.SetColor(0, 0, 0, 0);
	this.count = 0;
	::talk.Load("data/event/script/" + ::story.name + "/ed.pl");
	::talk.Begin("main_1");

	if (::story.name != "reimu")
	{
		local texture = ::manbow.Texture();
		texture.Load("data/system/ed/ed_back.png");
		this.back = ::manbow.Sprite();
		this.back.Initialize(texture, 0, 0, texture.width, texture.height);
		this.back.ConnectRenderSlot(::graphics.slot.talk, 0);
		texture = ::manbow.Texture();
		texture.Load("data/system/ed/ed_message.png");
		this.message = ::manbow.Sprite();
		this.message.Initialize(texture, 0, 0, texture.width, texture.height);
		this.message.x = 963;
		this.message.y = 67;
		this.message.ConnectRenderSlot(::graphics.slot.talk, 0);
		local type = 0;

		if (::story.name == "yukari")
		{
			this.skip = ::savedata.ed.type1 > 0;
			::savedata.ed.type1++;
			type = 1;
		}
		else if (::story.name == "jyoon")
		{
			type = 2;
			this.skip = ::savedata.ed.type2 > 0;
			::savedata.ed.type2++;
		}
		else
		{
			this.skip = ::savedata.ed.type0 > 0;
			::savedata.ed.type0++;
		}

		this.staffroll.Initialize(type);
	}
	else
	{
		this.skip = ::savedata.story.reimu.ed > 0;
		this.staffroll.is_finish = true;
		this.back = ::manbow.Rectangle();
		this.back.SetPosition(-1, -1, ::graphics.width + 1, ::graphics.height + 1);
		this.back.SetColor(1, 0, 0, 0);
		this.back.ConnectRenderSlot(::graphics.slot.talk, 0);
		this.message = null;
	}

	this.Update = this.UpdateMain;
	::savedata.story[::story.name].ed = ::savedata.story[::story.name].ed | 1 << ::story.difficulty;
	::savedata.UpdateFlag();
	::savedata.Save();
}

function Terminate()
{
	this.message = null;
	this.back = null;
	::talk.Clear();
	this.fade.DisconnectRenderSlot();
	::loop.DeleteTask(this.fade_task);
	this.staffroll.Terminate();
	::sound.StopBGM(500);
}

function UpdateMain()
{
	::talk.Update();
	this.count++;

	if (this.count >= 60 && ::input_all.b1 == 1 && this.skip || ::input_all.b0 == 1 && this.staffroll.is_finish && !::talk.is_active)
	{
		::sound.StopBGM(1000);
		this.fade.ConnectRenderSlot(::graphics.slot.talk, 65535);
		::loop.AddTask(this.fade_task);
		::replay.Confirm(null);
		this.Update = function ()
		{
			::loop.Fade(function ()
			{
				::loop.End(::menu.title);
			}, 60);
		};
	}
}

function Hide()
{
	this.message = null;

	if (this.back)
	{
		this.back.red = this.back.green = this.back.blue = 0;
	}
}

function BeginStaffroll()
{
	this.staffroll.Begin();
}

