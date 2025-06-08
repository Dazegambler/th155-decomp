this.win_rate <- {};

foreach( v in ::character_name )
{
	local src = ::manbow.LoadCSV("data/win/rate/" + v + ".csv");

	if (src == null)
	{
		continue;
	}

	local data = [];

	foreach( t in src )
	{
		local d = {};

		if (t[0].len() == 0)
		{
			continue;
		}

		d.target <- t[0];
		local cond = [];

		for( local i = 0; i < 3; i++ )
		{
			cond.push(t[i + 1] in ::character_id ? 1 << ::character_id[t[i + 1]] : -1);
		}

		d.cond <- cond;
		local rate = [];
		local cur = 0;

		for( local i = 0; i < 10; i++ )
		{
			rate.push(t[i + 4].tointeger() + cur);
			cur = rate.top();
		}

		d.rate <- rate;
		data.push(d);
	}

	this.win_rate[v] <- data;
}

function GenerateResultMessage( master_name_win, slave_name_win, master_name_lose, slave_name_lose, reverse )
{
	local target = this.GetResultMessageTarget(master_name_win, slave_name_win, master_name_lose, slave_name_lose);
	local data = {};

	if (!::manbow.LoadCSVtoTable("data/win/message/" + master_name_win + ".csv", data))
	{
		return false;
	}

	if (!(target in data))
	{
		return false;
	}

	local src = data[target];
	local c = [];
	c.push([
		":start"
	]);
	local func_image_def = function ( src_name, _name, _face, side )
	{
		if (src[_name] == "null")
		{
			return;
		}

		local n = src[_name] == "default" ? src_name : src[_name];
		local group = side ? "loser" : "winner";
		c.push([
			"",
			"LoadImageDef",
			_name,
			"data/event/pic/" + n + (side ? "/face_r.pat" : "/face.pat")
		]);
		c.push([
			"",
			"DefineObject",
			_name,
			_name,
			group,
			240 + side * 800,
			0,
			side ? "true" : "false"
		]);
		c.push([
			"",
			"ImageDef",
			_name,
			_face,
			0,
			0
		]);
		c.push([
			"",
			"Show",
			_name
		]);
		c.push([
			"",
			"SetFocus",
			_name
		]);
	};
	func_image_def(slave_name_win, "win_back", src.wb_default, reverse ? 1 : 0);
	func_image_def(master_name_win, "win_front", src.wf_default, reverse ? 1 : 0);
	c.push([
		"",
		"Sleep",
		15
	]);
	func_image_def(slave_name_lose, "lose_back", src.lb_default, reverse ? 0 : 1);
	func_image_def(master_name_lose, "lose_front", src.lf_default, reverse ? 0 : 1);
	c.push([
		"",
		"Sleep",
		45
	]);
	local last_target = "";

	for( local i = 0; i < 3; i = ++i )
	{
		if (src["message" + i].len() == 0)
		{
		}
		else
		{
			if (src["face" + i].len() > 0)
			{
				if (src["name" + i].len() == 0)
				{
					c.push([
						"",
						"ImageDef",
						last_target,
						src["face" + i],
						0,
						0
					]);
				}
				else
				{
					c.push([
						"",
						"ImageDef",
						src["name" + i],
						src["face" + i],
						0,
						0
					]);
				}
			}

			if (src["name" + i].len() > 0)
			{
				last_target = src["name" + i];
				c.push([
					"",
					"SetFocus",
					last_target
				]);
			}

			c.push([
				src["message" + i],
				src["balloon" + i],
				0,
				0
			]);

			if (::config.lang == 1)
			{
				c.top().extend([
					src["message_en" + i]
				]);
			}
		}
	}

	c.push([
		"",
		"Function",
		"::battle.BeginResultEnd()"
	]);
	this.command_line = c;
	return true;
}

function GetResultMessageTarget( master_name_win, slave_name_win, master_name_lose, slave_name_lose )
{
	local t = this.win_rate[master_name_win];
	local cond0 = 1 << ::character_id[master_name_lose];
	local cond1 = 1 << ::character_id[slave_name_lose];
	local cond2 = 1 << ::character_id[slave_name_win];
	local t2 = t[0];

	foreach( v in t )
	{
		if (v.cond[0] & cond0 && v.cond[1] & cond1 && v.cond[2] & cond2)
		{
			t2 = v;
			break;
		}
	}

	local r = this.rand() % 100;
	local result = 0;

	foreach( i, v in t2.rate )
	{
		if (r < v)
		{
			result = i;
			break;
		}
	}

	return result < 5 ? "common" + (1 + result) : master_name_lose + (result + 1 - 5);
}

