this.item <- [
	"se",
	"bgm",
	"screen",
	"vsync",
	"background",
	"fps",
	"key1p",
	"key2p",
	"replay_save",
	"replay_save_online",
	"lang",
	null,
	"exit"
];
this.proc <- {};
this.cursor_item <- ::menu.common.CreateCursor(this.item);
this.cursor_se <- this.Cursor(1, 11, ::input_all);
this.cursor_se.loop = false;
this.cursor_bgm <- this.Cursor(1, 11, ::input_all);
this.cursor_bgm.loop = false;
this.cursor_screen <- this.Cursor(1, 2, ::input_all);
this.cursor_vsync <- this.Cursor(1, 2, ::input_all);
this.cursor_background <- this.Cursor(1, 2, ::input_all);
this.cursor_fps <- this.Cursor(1, 2, ::input_all);
this.cursor_replay_save <- this.Cursor(1, 3, ::input_all);
this.cursor_replay_save_online <- this.Cursor(1, 2, ::input_all);
this.cursor_lang <- this.Cursor(1, 2, ::input_all);
this.help <- [
	"B1",
	"ok",
	null,
	"B2",
	"return",
	null,
	"UD",
	"select"
];
this.help_item <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"LR",
	"change"
];
this.Update <- null;
this.func_update_cursor <- null;
this.common_cursor <- null;
this.common_callback_ok <- null;
this.common_callback_cancel <- null;
this.anime <- {};
::manbow.CompileFile("data/system/config/config_animation.nut", this.anime);
function Initialize( enable_lang = false )
{
	::menu.cursor.Activate();
	::menu.back.Activate();
	::menu.help.Set(this.help);

	if (enable_lang)
	{
		this.item = [
			"se",
			"bgm",
			"screen",
			"vsync",
			"background",
			"fps",
			"key1p",
			"key2p",
			"replay_save",
			"replay_save_online",
			"lang",
			null,
			"exit"
		];
	}
	else
	{
		this.item = [
			"se",
			"bgm",
			"screen",
			"vsync",
			"background",
			"fps",
			"key1p",
			"key2p",
			"replay_save",
			"replay_save_online",
			null,
			"exit"
		];
	}

	this.cursor_item = ::menu.common.CreateCursor(this.item);
	this.cursor_item.val = 0;
	this.state <- 0;
	this.count <- 0;
	this.cursor_se.val = ::config.sound.se / 10;
	this.cursor_bgm.val = ::config.sound.bgm / 10;
	this.cursor_screen.val = ::config.graphics.fullscreen;
	this.cursor_vsync.val = ::config.graphics.vsync;
	this.cursor_background.val = ::config.graphics.background;
	this.cursor_fps.val = ::config.graphics.fps;
	this.cursor_replay_save.val = ::config.replay.save_mode;
	this.cursor_replay_save_online.val = ::config.replay.save_mode_online;
	this.cursor_lang.val = ::config.lang;
	this.BeginAnime();
	this.Update = this.UpdateMain;
	::loop.Begin(this);
}

function Terminate()
{
	this.state = -1;
	this.EndAnimeDelayed();
	::menu.help.Reset();
	::menu.back.Deactivate();
	::menu.cursor.Deactivate();
}

function Suspend()
{
	this.state = 1;
	::menu.help.Reset();
}

function Resume()
{
	this.state = 0;
	::menu.help.Set(this.help);
}

function Apply()
{
	::config.Apply();
	::config.Save();
}

function Reset()
{
	::config.Apply();
}

function UpdateMain()
{
	::menu.help.Set(this.help);
	this.cursor_item.Update();

	if (this.cursor_item.ok)
	{
		if (this.item[this.cursor_item.val])
		{
			this.proc[this.item[this.cursor_item.val]].call(this);
		}
	}

	if (this.cursor_item.cancel)
	{
		::loop.End();
		return;
	}
}

function UpdateCommonItem()
{
	this.common_cursor.Update();

	if (this.common_cursor.ok)
	{
		this.common_callback_ok();
		this.Apply();
		this.Update = this.UpdateMain;
	}
	else if (this.common_cursor.cancel)
	{
		this.common_callback_cancel();
		this.Update = this.UpdateMain;
	}
}

this.proc.se <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = function ()
	{
		this.cursor_se.Update();

		if (this.cursor_se.diff)
		{
			::sound.SetVolumeSE(this.cursor_se.val * 10 / 100.00000000);
		}

		if (this.cursor_se.ok)
		{
			::config.sound.se = this.cursor_se.val * 10;
			this.Apply();
			this.Update = this.UpdateMain;
		}
		else if (this.cursor_se.cancel)
		{
			this.cursor_se.val = ::config.sound.se / 10;
			::sound.SetVolumeSE(this.cursor_se.val * 10 / 100.00000000);
			this.Update = this.UpdateMain;
		}
	};
};
this.proc.bgm <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = function ()
	{
		this.cursor_bgm.Update();

		if (this.cursor_bgm.diff)
		{
			::sound.SetVolumeBGM(this.cursor_bgm.val * 10 / 100.00000000);
		}

		if (this.cursor_bgm.ok)
		{
			::config.sound.bgm = this.cursor_bgm.val * 10;
			this.Apply();
			this.Update = this.UpdateMain;
		}
		else if (this.cursor_bgm.cancel)
		{
			this.cursor_bgm.val = ::config.sound.bgm / 10;
			::sound.SetVolumeBGM(this.cursor_bgm.val * 10 / 100.00000000);
			this.Update = this.UpdateMain;
		}
	};
};
this.proc.screen <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_screen;
	this.common_callback_ok = function ()
	{
		::config.graphics.fullscreen = this.cursor_screen.val;
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_screen.val = ::config.graphics.fullscreen;
	};
};
this.proc.vsync <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_vsync;
	this.common_callback_ok = function ()
	{
		::config.graphics.vsync = this.cursor_vsync.val;
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_vsync.val = ::config.graphics.vsync;
	};
};
this.proc.background <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_background;
	this.common_callback_ok = function ()
	{
		::config.graphics.background = this.cursor_background.val;
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_background.val = ::config.graphics.background;
	};
};
this.proc.fps <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_fps;
	this.common_callback_ok = function ()
	{
		::config.graphics.fps = this.cursor_fps.val;
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_fps.val = ::config.graphics.fps;
	};
};
this.proc.key1p <- function ()
{
	if (this.cursor_item.ok)
	{
		this.Suspend();
		::menu.key_config.Initialize(0);
		return;
	}
};
this.proc.key2p <- function ()
{
	if (this.cursor_item.ok)
	{
		this.Suspend();
		::menu.key_config.Initialize(1);
		return;
	}
};
this.proc.replay_save <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_replay_save;
	this.common_callback_ok = function ()
	{
		::config.replay.save_mode = this.cursor_replay_save.val;
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_replay_save.val = ::config.replay.save_mode;
	};
};
this.proc.replay_save_online <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_replay_save_online;
	this.common_callback_ok = function ()
	{
		::config.replay.save_mode_online = this.cursor_replay_save_online.val;
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_replay_save_online.val = ::config.replay.save_mode_online;
	};
};
this.proc.lang <- function ()
{
	::menu.help.Set(this.help_item);
	this.Update = this.UpdateCommonItem;
	this.common_cursor = this.cursor_lang;
	this.common_callback_ok = function ()
	{
		if (::config.lang != this.cursor_lang.val)
		{
			::config.lang = this.cursor_lang.val;
			this.anime.UpdateLang();
		}
	};
	this.common_callback_cancel = function ()
	{
		this.cursor_lang.val = ::config.lang;
	};
};
this.proc.exit <- function ()
{
	if (this.cursor_item.ok)
	{
		::loop.End();
		return;
	}
};
