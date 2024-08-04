function Update_Normal()
{
	if (!this.MainLoopFirst())
	{
		if (this.IsDamage())
		{
			if (this.stateLabel)
			{
				this.stateLabel();
			}

			return true;
		}
		else
		{
			return false;
		}
	}

	if (::battle.state == 8)
	{
		if (this.boss_cpu)
		{
			this.boss_cpu();
		}
		else if (this.cpuState)
		{
			this.cpuState();
		}
	}

	this.MainLoop();
	return true;
}

function Update_Input()
{
}

function PlayerhitAction_Boss( t_ )
{
	this.KnockBackSetValue(t_);

	if (this.event_getDamage)
	{
		if (this.event_getDamage(t_))
		{
			this.event_getDamage = null;
		}
	}

	if (this.team.life <= 0 && this.enableKO && t_.atkType != 0)
	{
		this.team.master.shot_actor.Foreach(function ()
		{
			this.func[0].call(this);
		});

		if (this.team.slave)
		{
			this.team.slave.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
		}

		this.BuffReset();
		this.enableStandUp = false;

		if (this.event_defeat)
		{
			this.event_defeat();
		}

		if (this.koExp)
		{
			this.DamageFinish(t_);
			return;
		}
	}
}

function BossCall_Init()
{
	if (!this.Cancel_Check(10))
	{
		return false;
	}

	this.LabelClear();
	this.invin = 6;
	this.invinObject = 6;
	this.invinGrab = 6;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	::battle.enableTimeCount = false;
	this.SetFreeObject(this.x, this.y, 1,00000000.0, this.Boss_SetLife_Actor, {});
	this.CallBossCard(0, ::battle.boss_spell[0].master_name);
	this.SetFreeObject(640 - 640, 720, -1,00000000.0, this.SpellUseFace, {});

	if (this.boss_spell_func)
	{
		this.boss_spell_func();
	}

	return true;
}

function BossForceCall_Init()
{
	::battle.enableTimeCount = false;
	this.SetFreeObject(this.x, this.y, 1,00000000.0, this.Boss_SetLife_Actor, {});
	this.CallBossCard(0, ::battle.boss_spell[0].master_name);
	this.SetFreeObject(640 - 640, 720, -1,00000000.0, this.SpellUseFace, {});

	if (this.boss_spell_func)
	{
		this.boss_spell_func();
	}

	return true;
}

function TeamSkillChain_Input( input_ )
{
	return false;
}

