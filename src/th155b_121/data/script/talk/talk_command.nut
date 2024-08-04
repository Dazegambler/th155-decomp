function Message( arg )
{
	local st = arg[0];
	local end_char = st.slice(-1);
	local ret = false;

	if (end_char[0] == 92 || end_char[0] == 64)
	{
		this.WaitInput(null);
		st = st.slice(0, -1);
		ret = true;
	}
	else if (end_char[0] == 43)
	{
		st = st.slice(0, -1);
	}

	if (arg.len() <= 3)
	{
		if (this.message == null)
		{
			this.message = this.Text();
			this.message.Set(st);
		}
		else if (this.message_flush)
		{
			this.message.Hide();
			this.message = this.Text();
			this.message.Set(st);
		}
		else
		{
			this.message.Add(st);
		}

		if (::config.lang == 1 && arg.len() > 1)
		{
			this.message.SetSubtitle(arg[1], arg.len() == 3 ? arg[2] : null);
		}

		this.message.Show();
		this.message_flush = end_char[0] != 64 && end_char[0] != 43;
		return ret;
	}

	if (this.current_obj)
	{
		local balloon = this.current_obj.balloon ? this.current_obj.balloon : this.Balloon();

		if (arg.len() >= 2)
		{
			balloon.Create(st, arg[1], this.current_obj);
		}
		else
		{
			balloon.Create(st, this.default_balloon, this.current_obj);
		}

		if (::config.lang == 1 && arg.len() >= 5)
		{
			balloon.SetSubtitle(arg[4]);
		}
	}

	return ret;
}

function DefineObject( arg )
{
	local c = this.CharacterImage();
	c.Create(this.take_data[arg[3]]);
	c.group = arg[4] != "" ? arg[4] : "default";
	c.x = arg[5].tofloat();
	c.y = arg[6].tofloat();

	if (arg[7] == "true")
	{
		c.direction = -1;
	}

	this.object_list[arg[2]] <- c;
	return false;
}

function SetDefaultBalloon( arg )
{
	if (arg[2] in this.Balloon.balloon_src)
	{
		this.default_balloon = arg[2];
	}

	return false;
}

function ImageFile( arg )
{
	local label = arg[2];
	local filename = arg[3];
	local image = this.Image();
	image.Create(filename);

	if (arg.len() >= 5)
	{
		image.SetPosition(arg[4].tofloat(), arg[5].tofloat());
	}

	if (arg.len() >= 7)
	{
		local t = arg[6].tointeger();

		if (label in this.object_list)
		{
			this.object_list[label].Hide(t);
		}

		this.object_list[label] <- image;
		image.Show(t);
	}
	else
	{
		if (label in this.object_list)
		{
			this.object_list[label].Hide();
		}

		this.object_list[label] <- image;
		image.Show();
	}

	return false;
}

function ImageFileLocal( arg )
{
	if (::config.lang == 1)
	{
		local s = arg[3];
		arg[3] = s.slice(0, s.len() - 4) + "_en" + s.slice(-4);
	}

	this.ImageFile(arg);
}

function ImageDef( arg )
{
	this.object_list[arg[2]].Set(arg[3]);
	return false;
}

function SetFocus( arg )
{
	this.current_obj = this.object_list[arg[2]];
	this.current_obj.Show();

	if (this.current_obj.group in this.group)
	{
		local prev = this.group[this.current_obj.group];

		if (this.current_obj != prev)
		{
			prev.Deactivate();
		}
	}

	this.group[this.current_obj.group] <- this.current_obj;
	this.current_obj.Activate();
	return false;
}

function Sleep( arg )
{
	local f = function ( count )
	{
		for( local i = 0; i < count; i = ++i )
		{
			this.suspend();
		}
	};
	local t = ::newthread(f);
	t.call(arg[2].tointeger());

	if (t.getstatus() != "idle")
	{
		this.sync_task.append(t);
	}

	return true;
}

function WaitInput( arg )
{
	local f;

	if (arg)
	{
		f = function ()
		{
			while (true)
			{
				if (::input_talk.b0 == 1 || ::input_talk.b2)
				{
					return;
				}

				this.suspend();
			}
		};
	}
	else
	{
		f = function ()
		{
			while (true)
			{
				if (::input_talk.b0 == 1)
				{
					::sound.PlaySE("talk_balloon");
					return;
				}

				if (::input_talk.b2)
				{
					return;
				}

				this.suspend();
			}
		};
	}

	local t = ::newthread(f);
	t.call();

	if (t.getstatus() != "idle")
	{
		this.sync_task.append(t);
	}

	return true;
}

function Show( arg )
{
	if (arg[2] in this.object_list)
	{
		this.object_list[arg[2]].Show();
	}

	return false;
}

function Hide( arg )
{
	if (arg[2] in this.object_list)
	{
		this.object_list[arg[2]].Hide();
	}

	if (arg[2] in this)
	{
		if (this[arg[2]])
		{
			this[arg[2]].Hide();
		}
	}

	return false;
}

function Move( arg )
{
	return false;
}

function MoveImage( arg )
{
	return false;
}

function Function( arg )
{
	try
	{
		if (arg[2].find("function main()") == null)
		{
			local f = this.compilestring(arg[2]);

			if (f)
			{
				f.call(this);
			}
		}
		else
		{
			local f = this.compilestring(arg[2]);
			local env = {};
			env.setdelegate(this);

			if (f)
			{
				f.call(env);
			}

			if ("main" in env)
			{
				local t = ::newthread(env.main.bindenv(this));
				t.call();

				if (t.getstatus() != "idle")
				{
					this.sync_task.append(t);
				}
			}
		}
	}
	catch( e )
	{
	}

	return false;
}

function Thread( arg )
{
}

function GoTo( arg )
{
	local label = ":" + arg[2];

	foreach( i, v in this.command_line )
	{
		if (v.len() && v[0] == label)
		{
			this.current_line = i;
			return false;
		}
	}

	return false;
}

function GoSub( arg )
{
	local label = ":" + arg[2];

	foreach( i, v in this.command_line )
	{
		if (v.len() && v[0] == label)
		{
			this.sub_stack.append(this.current_line);
			this.current_line = i;
			return false;
		}
	}

	return false;
}

function Return( arg )
{
	this.current_line = this.sub_stack.pop();
	return false;
}

function LoadImageDef( arg )
{
	this.take_data[arg[2]] <- ::actor.LoadAnimationData(arg[3]);
	return false;
}

function ClearImageDef( arg )
{
	return false;
}

function ClearBalloon( arg )
{
	if (!(arg[2] in this.object_list))
	{
		return;
	}

	local c = this.object_list[arg[2]];

	if (c.balloon)
	{
		if (c.balloon.tostring() in this.async_task)
		{
			delete this.async_task[c.balloon.tostring()];
		}

		c.balloon = null;
	}

	return false;
}

function LoadAnimation( arg )
{
	::actor.AddStoryEffect(arg[2]);
	return false;
}

function LoadAnimationLocal( arg )
{
	if (::config.lang == 1)
	{
		local s = arg[2];
		arg[2] = s.slice(0, s.len() - 4) + "_en" + s.slice(-4);
	}

	this.LoadAnimation(arg);
}

