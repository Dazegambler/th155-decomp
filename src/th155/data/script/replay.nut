this.recorder <- null;
this.disable_save <- false;
this.func_callback <- null;
this.game_mode <- 0;
this.slot_offset <- 0;
this.NONE <- 0;
this.RECORD <- 1;
this.PLAY <- 2;
this.state <- this.NONE;
function GetState()
{
	return this.state;
}

function Create( _mode )
{
	this.game_mode = _mode;

	if (::network.IsActive())
	{
		this.recorder = ::network.inst.recorder;
	}
	else
	{
		this.recorder = ::manbow.InputRecorder();
	}

	this.recorder.userdata = {};
	this.recorder.userdata.game_mode <- this.game_mode;
	this.disable_save = false;
	this.state = this.RECORD;
}

function Reset()
{
	this.recorder = null;
	this.disable_save = false;
	this.state = this.NONE;
}

function Watch()
{
	this.recorder = ::network.inst.recorder;
	this.state = this.PLAY;
}

function Load( filename )
{
	this.recorder = ::manbow.InputRecorder();

	if (!this.recorder.Load(filename, ::GetReplayVersion()))
	{
		this.state = this.NONE;
		return false;
	}

	this.state = this.PLAY;
	return true;
}

function Save( filename = null )
{
	if (this.disable_save)
	{
		return;
	}

	if (this.state != this.RECORD)
	{
		return;
	}

	local name = filename;
	local _year = "";
	local _month = "";
	local _day = "";
	local _hour = "";
	local _min = "";
	local _sec = "";
	function __replace( str, str2, begin, end )
	{
		return str.slice(0, begin) + str2 + str.slice(end);
	}

	function _replace( str1, str2, str3 )
	{
		local begin = str1.find(str2);

		while (begin != null)
		{
			str1 = this.__replace(str1, str3, begin, begin + str2.len());
			begin = str1.find(str2);
		}

		return str1;
	}


	if (filename == null)
	{
		_year = _year + this.date().year % 100;

		if (this.date().month + 1 < 10)
		{
			_month = "0";
		}

		_month = _month + (this.date().month + 1);

		if (this.date().day < 10)
		{
			_day = "0";
		}

		_day = _day + this.date().day;

		if (this.date().hour < 10)
		{
			_hour = "0";
		}

		_hour = _hour + this.date().hour;

		if (this.date().min < 10)
		{
			_min = "0";
		}

		_min = _min + this.date().min;

		if (this.date().sec < 10)
		{
			_sec = "0";
		}

		_sec = _sec + this.date().sec;
		name = "%yymmdd/replay_%hhmmss";
		name = this._replace(name, "%ver", ::GetVersionString());
		name = this._replace(name, "%yymmdd", _year + _month + _day);
		name = this._replace(name, "%mmdd", _month + _day);
		name = this._replace(name, "%hhmmss", _hour + _min + _sec);
		name = this._replace(name, "%hhmm", _hour + _min);
		name = this._replace(name, "%year", _year);
		name = this._replace(name, "%month", _month);
		name = this._replace(name, "%day", _day);
		name = this._replace(name, "%hour", _hour);
		name = this._replace(name, "%min", _min);
		name = this._replace(name, "%sec", _sec);
	}

	local dir_tree = this.split(name, "/\\");
	local dir = "replay";

	for( local i = 0; i < dir_tree.len() - 1; i = ++i )
	{
		dir = dir + "/" + dir_tree[i];
		::manbow.CreateDirectory(dir);
	}

	local reader = ::manbow.FileReader();
	local name_temp = "replay/" + name + ".rep";

	if (reader.Open(name_temp))
	{
		local i = 1;

		for( i = 1; i < 100; i++ )
		{
			name_temp = "replay/" + name + "_" + i + ".rep";

			if (!reader.Open(name_temp))
			{
				name = name + "_" + i;
				break;
			}
		}

		if (i == 100)
		{
			return false;
		}
	}

	local name_full = "replay/" + name + ".rep";
	this.recorder.userdata.year <- this.date().year;
	this.recorder.userdata.month <- this.date().month + 1;
	this.recorder.userdata.day <- this.date().day;
	this.recorder.userdata.hour <- this.date().hour;
	this.recorder.userdata.min <- this.date().min;
	this.recorder.userdata.sec <- this.date().sec;
	this.recorder.userdata.fav <- false;
	this.recorder.Save(name_full, ::GetReplayVersion());
	return true;
}

function LoadHeader( filename )
{
	local r = ::manbow.InputRecorder();
	local header = {};

	if (!r.LoadHeader(filename, ::GetReplayVersion(), header))
	{
		return null;
	}

	return header;
}

function EnumFile( dirname, _array )
{
	local r = ::manbow.InputRecorder();
	r.EnumFile(dirname, null, ::GetReplayVersion(), _array);
}

function SetUserData( _obj, _param_list = null )
{
	if (this.recorder == null)
	{
		return;
	}

	if (_param_list)
	{
		foreach( key in _param_list )
		{
			this.recorder.userdata[key] <- _obj[key];
		}
	}
	else
	{
		foreach( key, val in _obj )
		{
			this.recorder.userdata[key] <- val;
		}
	}
}

function GetUserData( _obj, _param_list = null )
{
	if (this.recorder == null)
	{
		return;
	}

	if (_param_list)
	{
		foreach( key in _param_list )
		{
			_obj[key] = this.recorder.userdata[key];
		}
	}
	else if (typeof _obj == "instance")
	{
		local c = _obj.getclass();

		foreach( key, val in this.recorder.userdata )
		{
			if (key in c)
			{
				_obj[key] = val;
			}
		}
	}
	else if (typeof _obj == "table")
	{
		foreach( key, val in this.recorder.userdata )
		{
			_obj[key] <- val;
		}
	}
}

function GetGameMode()
{
	return this.recorder ? this.recorder.userdata.game_mode : null;
}

function SetDevice( device_array, device_offset )
{
	switch(this.state)
	{
	case 1:
		this.Record(device_array, device_offset);
		break;

	case 2:
		this.Play(device_array, device_offset);
		break;
	}
}

function Record( device_array, device_offset )
{
	if (this.recorder == null)
	{
		return;
	}

	for( local i = 0; i < device_array.len(); i = ++i )
	{
		this.recorder.SetDevice(device_offset + i, device_array[i]);
		this.recorder.BeginRecord(device_offset + i);
	}

	this.slot_offset = device_offset;
}

function Play( device_array, device_offset )
{
	if (this.recorder == null)
	{
		return;
	}

	for( local i = 0; i < device_array.len(); i = ++i )
	{
		this.recorder.SetDevice(device_offset + i, device_array[i]);
		this.recorder.BeginPlay(device_offset + i);
	}

	this.slot_offset = device_offset;
}

function IsFinished()
{
	return this.recorder.IsFinished(this.slot_offset);
}

function Confirm( _func_callback )
{
	if (this.disable_save)
	{
		if (_func_callback)
		{
			_func_callback();
		}

		return;
	}

	if (this.recorder == null)
	{
		if (_func_callback)
		{
			_func_callback();
		}

		return;
	}

	switch(::config.replay.save_mode)
	{
	case 0:
		this.Save();

		if (_func_callback)
		{
			_func_callback();
		}

		break;

	case 1:
		if (_func_callback)
		{
			_func_callback();
		}

		break;

	case 2:
		local message = "リプレイを表x2588存し�\x2584すか？";
		this.func_callback = _func_callback;
		::Dialog(1, message, function ( t )
		{
			if (t == null)
			{
				return;
			}

			if (t)
			{
				this.Save();
			}

			if (this.func_callback)
			{
				this.func_callback();
			}
		}.bindenv(this), 1);
		break;
	}
}

