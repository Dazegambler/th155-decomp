function UpdateMain()
{
	foreach( v in this.team )
	{
		v.Update();
	}

	::camera.Update();
	local mask;

	if (this.time_stop_count > 0)
	{
		this.time_stop_count--;
		mask = this.team[0].time_stop_mask & this.team[1].time_stop_mask;
		this.is_time_stop = true;
	}
	else if (this.team[0].time_stop_count > 0)
	{
		this.team[0].time_stop_count--;
		mask = this.team[0].time_stop_mask;
		this.is_time_stop = true;
	}
	else if (this.team[1].time_stop_count > 0)
	{
		this.team[1].time_stop_count--;
		mask = this.team[1].time_stop_mask;
		this.is_time_stop = true;
	}
	else if (this.slow_count)
	{
		this.slow_count--;

		if (this.slow_count & 1)
		{
			mask = this.team[0].time_stop_mask | this.team[1].time_stop_mask;
			this.is_time_stop = true;
		}
		else
		{
			mask = 65535;
			::stage.Update();
			this.is_time_stop = false;
		}
	}
	else
	{
		mask = 65535;
		::stage.Update();
		this.is_time_stop = false;
	}

	this.group_player.SetUpdateMask(mask);
	::effect.AddUpdateMask(mask);
	this.group_player.Update();
	this.group_effect.Update();
	this.ContactTest();

	if (this.battleUpdate)
	{
		this.battleUpdate();
	}

	this.UpdateUser();
	this.gauge.Update();

	foreach( v in this.task )
	{
		v.Update();
	}

	if (!::graphics.IsFading() && (this.team[0].input.b10 == 1 || this.team[1].input.b10 == 1))
	{
		this.team[0].input.Lock();
		this.team[1].input.Lock();
		this.Pause();
	}

	this.count++;
}

this.Update <- this.UpdateMain;
