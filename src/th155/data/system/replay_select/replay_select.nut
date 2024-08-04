this.current_dir <- null;
this.current_file <- null;
this.state_stack <- [];
this.dir_stack <- [];
this.dir_name_stack <- [];
this.current_dir_name <- "";
this.file <- [];
this.dir <- [];
this.all <- [];
this.page_size <- 10;
this.page <- [];
this.read_list <- [];
this.suspend <- false;
this.help <- [
	"B1",
	"play",
	null,
	"B2",
	"return",
	null,
	"B3",
	"delete",
	null,
	"UD",
	"select",
	null,
	"LR",
	"page"
];
function Initialize()
{
	::loop.Begin(this);
	this.view <- {};
	::manbow.CompileFile("data/system/replay_select/replay_select_view.nut", this.view);
	this.view.Initialize(this);
	this.root <- ::manbow.EnumFile("replay", null);
	this.current_dir <- this.root;
	this.state_stack = [];
	this.current_dir_name = "replay/";
	this.cursor <- this.Cursor(0, 1, ::input_all);
	this.cursor_page <- this.Cursor(1, 1, ::input_all);
	this.cursor_page.enable_ok = false;
	this.cursor_page.enable_cancel = false;
	this.read_list = [];
	this.CreateFileList(this.root);
	this.suspend = false;
	::menu.cursor.Activate();
	::menu.back.Activate();
}

function Terminate()
{
	::replay.Reset();
	this.state_stack = [];
	this.view.Terminate();
	this.view = null;
	this.current_dir = null;
	this.current_file = null;
	this.file = [];
	this.dir = [];
	this.all = [];
	this.page = [];
	this.read_list = [];

	if (!this.suspend)
	{
		::menu.back.Deactivate(true);
		::menu.cursor.Deactivate();
		::menu.help.Reset();
	}
}

function Suspend()
{
	this.suspend = true;
	::menu.help.Reset();
	::menu.cursor.Deactivate();
	::menu.back.Deactivate(true);
	this.view.Terminate();
}

function Resume()
{
	if (!this.suspend)
	{
		return;
	}

	this.suspend = false;
	::sound.PlayBGM(::savedata.GetTitleBGMID());
	::menu.cursor.Activate();
	::menu.back.Activate();
	::menu.help.Set(this.help);
	this.view.Initialize(this);
	this.view.CreatePage(this.all);
}

function Update()
{
	::menu.help.Set(this.help);
	this.cursor_page.Update();

	if (this.cursor_page.diff && this.page.len())
	{
		this.cursor.SetItemNum(this.page[this.cursor_page.val].len());
	}

	this.cursor.Update();
	this.current_file = this.page.len() == 0 ? null : this.page[this.cursor_page.val][this.cursor.val];

	if (this.cursor.ok && this.current_file)
	{
		if (this.current_file.is_directory)
		{
			local t = {};
			t.dir <- this.current_file.child;
			t.dir_name <- this.current_file.name;
			t.cursor <- this.cursor;
			t.cursor_page <- this.cursor_page;
			this.state_stack.push(t);
			this.cursor <- this.Cursor(0, 1, ::input_all);
			this.cursor_page <- this.Cursor(1, 1, ::input_all);
			this.CreateFileList(this.current_file.child);
		}
		else if (::replay.Load(this.current_dir_name + this.current_file.name))
		{
			if (::replay.GetGameMode() == 10)
			{
				this.BeginStory();
			}
			else
			{
				this.BeginVS();
			}
		}
	}

	if (this.cursor.cancel)
	{
		if (this.state_stack.len())
		{
			this.cursor = this.state_stack.top().cursor;
			this.cursor_page = this.state_stack.top().cursor_page;
			this.state_stack.pop();
		}
		else
		{
			::loop.EndWithFade();
			return;
		}

		if (this.state_stack.len())
		{
			this.CreateFileList(this.state_stack.top().dir);
		}
		else
		{
			this.CreateFileList(this.root);
		}
	}

	if (::input_all.b2 == 1 && this.current_file)
	{
		if (!this.current_file.is_directory)
		{
			::Dialog(1, "ファイルを削除し�\x2584すか？", function ( t )
			{
				if (t)
				{
					this.DeleteFile(this.current_file);
				}
			}.bindenv(this), 1);
		}
	}

	this.view.Update();
}

function BeginVS()
{
	local param = ::vs.InitializeParam();
	::replay.GetUserData(param, param.param_list);
	::sound.StopBGM(500);
	::loop.Fade(function ()
	{
		::menu.replay_select.Suspend();
		::vs.Initialize(param);
	});
}

function BeginStory()
{
	local param = ::story.InitializeParam();
	::replay.GetUserData(param, param.param_list);
	::sound.StopBGM(500);
	::loop.Fade(function ()
	{
		::menu.replay_select.Suspend();
		::story.Initialize(param);
	});
}

function CreateFileList( _dir )
{
	this.current_dir = _dir;
	this.file = [];
	this.dir = [];
	this.current_dir_name = "replay/";

	foreach( v in this.state_stack )
	{
		this.current_dir_name += v.dir_name + "/";
	}

	local t = this.read_list.len();

	foreach( i, v in _dir )
	{
		if (v.is_directory)
		{
			this.dir.append(v);
		}
		else
		{
			v.filename <- this.current_dir_name + v.name;

			if (!("loading" in v))
			{
				v.loading <- 2;
				this.read_list.append(v);
			}

			this.file.append(v);
		}
	}

	this.UpdateFileList();

	if (this.read_list.len() && t == 0)
	{
		local f = this.read_list[0];
		::manbow.InputRecorder.LoadHeaderBackground(f.filename, ::GetReplayVersion(), f, this.ReadHeader);
	}
}

function Sort( mode, rev )
{
	if (this.read_list.len() > 0)
	{
		return;
	}

	local compare;

	if (mode == 1)
	{
		compare = function ( a, b )
		{
			if (a.header.year < b.header.year)
			{
				return -1;
			}

			if (a.header.year > b.header.year)
			{
				return 1;
			}

			if (a.header.month < b.header.month)
			{
				return -1;
			}

			if (a.header.month > b.header.month)
			{
				return 1;
			}

			if (a.header.day < b.header.day)
			{
				return -1;
			}

			if (a.header.day > b.header.day)
			{
				return 1;
			}

			if (a.header.hour < b.header.hour)
			{
				return -1;
			}

			if (a.header.hour > b.header.hour)
			{
				return 1;
			}

			if (a.header.min < b.header.min)
			{
				return -1;
			}

			if (a.header.min > b.header.min)
			{
				return 1;
			}

			if (a.header.sec < b.header.sec)
			{
				return -1;
			}

			if (a.header.sec > b.header.sec)
			{
				return 1;
			}

			return 0;
		};
	}
	else
	{
		compare = function ( a, b )
		{
			if (a.name < b.name)
			{
				return -1;
			}

			if (a.name > b.name)
			{
				return 1;
			}

			return 0;
		};
		  // [023]  OP_JMP            0      0    0    0
	}

	this.file.sort(compare);

	if (rev)
	{
		this.file.reverse();
	}

	this.UpdateFileList();
}

function UpdateFileList()
{
	this.all = clone this.dir;
	this.all.extend(this.file);
	this.current_file = null;
	this.page = [];
	local cur_page;

	for( local i = 0; i < this.all.len(); i = ++i )
	{
		local index = i % this.page_size;

		if (index == 0)
		{
			cur_page = [];
			this.page.push(cur_page);
		}

		cur_page.push(this.all[i]);
	}

	this.cursor_page.SetItemNum(this.page.len() == 0 ? 1 : this.page.len());
	this.cursor.SetItemNum(this.page.len() == 0 ? 1 : this.page[this.cursor_page.val].len());
	this.view.CreatePage(this.all);
}

function ReadHeader( result )
{
	this.header <- result;

	if (this.view)
	{
		::menu.replay_select.view.SetFileHeader(this.view, this.header);
	}

	this.loading = 0;

	for( local env = ::menu.replay_select; env.read_list.len();  )
	{
		local t = env.read_list[0];
		env.read_list.remove(0);

		if (t.loading == 2)
		{
			t.loading = 1;
			::manbow.InputRecorder.LoadHeaderBackground(t.filename, ::GetReplayVersion(), t, env.ReadHeader);
			break;
		}

		if (t.loading == 1)
		{
			break;
		}
	}
}

function RenameFile( index, new_name )
{
	if (this.all[index].is_directory)
	{
		return;
	}

	local t = this.all[index];
}

function DeleteFile( _file )
{
	if (_file.is_directory)
	{
		return;
	}

	local filename = _file.filename;

	try
	{
		this.remove(filename);
	}
	catch( e )
	{
		return;
	}

	for( local file_index = 0; file_index < this.file.len(); file_index = ++file_index )
	{
		if (this.file[file_index] == _file)
		{
			this.file.remove(file_index);
			break;
		}
	}

	for( local file_index = 0; file_index < this.current_dir.len(); file_index = ++file_index )
	{
		if (this.current_dir[file_index] == _file)
		{
			this.current_dir.remove(file_index);
			break;
		}
	}

	for( local file_index = 0; file_index < this.read_list.len(); file_index = ++file_index )
	{
		if (this.read_list[file_index] == _file)
		{
			this.read_list.remove(file_index);
			break;
		}
	}

	this.UpdateFileList();
}

