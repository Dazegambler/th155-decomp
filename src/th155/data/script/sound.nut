this.volume_base <- 1,00000000.0;
this.se <- {};
this.se_base <- {};
this.se_cache <- null;
this.se.volume_base <- 0,40000001.0;
this.bgm <- {};
this.bgm.playing <- null;
this.bgm.play_next <- null;
this.bgm.volume_base <- 0,30000001.0;
this.volume_master <- this.manbow.VolumeController();
this.volume_se <- this.manbow.VolumeController();
this.volume_se_stage <- this.manbow.VolumeController();
this.volume_bgm <- this.manbow.VolumeController();
this.volume_master.Add(this.volume_se);
this.volume_master.Add(this.volume_bgm);
this.volume_se.Add(this.volume_se_stage);
this.volume_se.SetVolume(this.se.volume_base);
this.volume_bgm.SetVolume(this.bgm.volume_base);
this.current_bgm_index <- -1;
function SetVolumeMaster( volume )
{
	this.volume_base = volume > 0 ? (volume < 1 ? volume : 1) : 0;
	this.volume_master.SetVolume(this.volume_base);
}

function SetVolumeBGM( volume )
{
	this.bgm.volume_base = volume > 0 ? (volume < 1 ? volume : 1) : 0;
	this.volume_bgm.SetVolume(this.bgm.volume_base);
}

function SetVolumeSE( volume )
{
	this.se.volume_base = volume > 0 ? (volume < 1 ? volume : 1) : 0;
	this.volume_se.SetVolume(this.se.volume_base);
}

function SetVolumeStageSE( volume )
{
	this.volume_se_stage.SetVolume(volume);
}

class this.SE 
{
	buffer = null;
	active = false;
	function Play()
	{
		this.buffer.Play(true);
	}

}

function LoadSE( filename )
{
	local csv_table = {};

	if (!this.manbow.LoadCSVtoTable(filename, csv_table))
	{
		return false;
	}

	foreach( key, val in csv_table )
	{
		local s = this.manbow.SoundPlayer();

		if (s.Open(val.path))
		{
			local data = this.SE();
			data.buffer = s;
			s.SetVolume(val.volume);
			this.volume_se.Add(s);
			this.se[key] <- data;

			if (val.name.len())
			{
				this.se[val.name] <- data;
			}
		}
	}

	local null_se = {};
	null_se.Play <- function ()
	{
	};
	this.se[0] <- null_se;
	return true;
}

function ResetSE()
{
	this.se = clone this.se_base;
}

function CacheSE( keep )
{
	this.se_cache = keep ? this.se : null;
}

::PlaySE <- function ( n )
{
	if (n in ::sound.se)
	{
		::sound.se[n].Play();
	}
	else
	{
	}
};
function PlaySE( n )
{
	if (n in this.se)
	{
		this.se[n].Play();
	}
	else
	{
	}
}

class this.BGM 
{
	filename = null;
	leaf = null;
	volume = 0;
	page = 0;
	track_no = 0;
	title = "";
	author = "";
	comment = "";
	hidden = 0;
	function Play()
	{
		this.buffer.Play(this.cue);
	}

}

function LoadBGM( filename )
{
	local csv_table = {};

	if (!::manbow.LoadCSVtoTable(filename, csv_table))
	{
		return false;
	}

	this.bgm.data <- {};

	foreach( key, val in csv_table )
	{
		local t = this.BGM();
		t.filename = val.path;
		t.leaf = val.path.slice("data/bgm/".len(), val.path.len() - 4);
		t.volume = val.volume / 100,00000000.0;
		t.track_no = val.track_no;
		t.page = val.line;
		t.title = val.title;
		t.author = val.author;
		t.comment = val.comment;
		t.hidden = val.hidden;
		this.bgm.data[key] <- t;
	}

	return true;
}

::PlayBGM <- function ( index, loop_flag = true )
{
	::sound.PlayBGM(index, loop_flag);
};
function PlayBGM( index, loop_flag = true )
{
	if (this.bgm.play_next)
	{
		local data = this.bgm.data[this.current_bgm_index];
		local player = this.bgm.play_next;
		this.bgm.play_next = null;
		player.SetVolume(data.volume);
		this.bgm.playing <- player;
		this.volume_bgm.Add(this.bgm.playing);
		player.Play();
		return;
	}

	if (this.current_bgm_index == index)
	{
		return;
	}

	if (index in this.bgm.data)
	{
		local data = this.bgm.data[index];

		if ("savedata" in this.getroottable())
		{
			if (!(index in ::savedata.bgm))
			{
				::savedata.bgm[index] <- true;

				if (data.track_no >= 0)
				{
					::savedata.Save();
				}
			}
		}

		local player = ::manbow.StreamingSoundPlayer();

		if (player.Open(data.filename, loop_flag))
		{
			player.SetVolume(data.volume);
			this.current_bgm_index = index;
			this.bgm.playing <- player;
			this.volume_bgm.Add(this.bgm.playing);
			player.Play();
			return;
		}
	}
}

function StopBGM( _time )
{
	if (this.bgm.playing)
	{
		if (_time > 0)
		{
			this.bgm.playing.FadeBackground(_time, 1,00000000.0);
		}
		else if (_time < 0)
		{
			this.bgm.playing.StopBackground();
		}

		this.bgm.playing = null;
	}

	this.bgm.play_next = null;
	this.current_bgm_index = -1;
}

function PauseBGM( enable )
{
	if (this.bgm.playing)
	{
		if (enable)
		{
			this.bgm.playing.Stop();
		}
		else
		{
			this.bgm.playing.Play();
		}
	}
}

function PreLoadBGM( index, loop_flag = true )
{
	if (this.current_bgm_index == index)
	{
		return;
	}

	if (index in this.bgm.data)
	{
		this.current_bgm_index = index;
		local data = this.bgm.data[index];

		if ("savedata" in this.getroottable())
		{
			if (!(index in ::savedata.bgm))
			{
				::savedata.bgm[index] <- true;

				if (data.track_no >= 0)
				{
					::savedata.Save();
				}
			}
		}

		local player = ::manbow.StreamingSoundPlayer();

		if (player.Open(this.bgm.data[index].filename, loop_flag))
		{
			this.bgm.play_next <- player;
			return;
		}
	}
}

function GetCurrentBGMData()
{
	if (this.current_bgm_index in this.bgm.data)
	{
		return this.bgm.data[this.current_bgm_index];
	}
	else
	{
		return null;
	}
}

function GetCurrentBGMPosition()
{
	if (this.bgm.playing)
	{
		return this.bgm.playing.GetPos();
	}
	else
	{
		return 0;
	}
}

this.LoadSE("data/se/se.csv");
this.se_base = clone this.se;
this.LoadBGM("data/bgm/bgm.csv");
