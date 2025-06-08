function InitializeUser()
{
	local m = [
		this.team[0].master,
		this.team[1].master
	];
	local s = [
		this.team[0].slave,
		this.team[1].slave
	];
	local s2 = [
		this.team[0].slave_sub,
		this.team[1].slave_sub
	];

	for( local i = 0; i < 2; i = ++i )
	{
		local target = m[1 - i];
		this.team[i].target = target.weakref();
		m[i].target = target.weakref();
		m[i].SetTeam_Player(i + 1);
		m[i].SetInput_Player(this.team[i].input);
		m[i].centerY = this.start_y[i];
		m[i].Init();
		m[i].Set_SpellCardData(m[i].spellcard.id);
		m[i].team_update = m[i].Team_Update_Master;
		m[i].command_change = m[i].Input_Master;

		if (s[i])
		{
			s[i].target = target.weakref();
			s[i].SetTeam_Player(i + 1);
			s[i].SetInput_Player(this.team[i].input);
			s[i].centerY = this.start_y[i];
			s[i].Init();
			s[i].Set_SlaveCardData(s[i].spellcard.id);
			s[i].Team_Bench_In.call(this.team[i].slave);
			s[i].team_update = function ()
			{
			};
			s[i].command_change = s[i].Input_Slave;
		}

		if (s2[i])
		{
			s2[i].target = target.weakref();
			s2[i].SetTeam_Player(i + 1);
			s2[i].SetInput_Player(this.team[i].input);
			s2[i].centerY = this.start_y[i];
			s2[i].Init();
			s2[i].Set_SlaveCardData(s2[i].spellcard.id);
			s2[i].Team_Bench_In.call(this.team[i].slave_sub);
			s2[i].team_update = function ()
			{
			};
			s2[i].command_change = s2[i].Input_Slave;
		}
	}
}

function UpdateUser()
{
}

function TerminateUser()
{
}

