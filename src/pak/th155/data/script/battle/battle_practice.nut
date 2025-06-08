this.time = -1;
this.life_max <- [
	10000,
	10000
];
this.mp_max <- [
	10000,
	10000
];
this.op_max <- [
	10000,
	10000
];
this.sp_max <- [
	10000,
	10000
];
this.guard <- [
	5,
	5
];
this.PlayerTeamData.SetDamage <- function ( damage, disable_ko )
{
	this.SetDamageBase(damage, disable_ko);

	if (this.life <= 0)
	{
		this.life = 1;

		if (this.regain_life < this.life)
		{
			this.regain_life = this.life;
		}
	}
};
this.GuardCrash_Check = this.GuardCrash_Check_VS;
function Apply()
{
	local param = ::config.practice;

	for( local i = 0; i < 2; i = ++i )
	{
		this.life_max[i] = ::practice.life[param.life[i]];
		this.mp_max[i] = ::practice.mp[param.mp[i]];
		this.op_max[i] = ::practice.op[param.op[i]];
		this.sp_max[i] = ::practice.sp[param.sp[i]];
		this.guard[i] = ::practice.guard[param.guard[i]];
	}
}

function Pause()
{
	::sound.PlaySE(111);
	::menu.practice.Initialize();
}

function Begin()
{
	this.Round_Begin();
}

function Round_Begin()
{
	this.demoCount = 0;
	this.endWinDemo = [
		false,
		false
	];
	this.endLoseDemo = [
		false,
		false
	];
	this.skipDemo = [
		false,
		false
	];
	this.enable_contact_test = false;
	this.gauge.Show(true);
	::camera.Reset();
	::camera.SetTarget(640, 340, 2.00000000, true);
	::sound.PlayBGM(null);
	::graphics.FadeIn(60);
	this.team[0].mp = 1000;
	this.team[1].mp = 1000;
	this.team[0].op = 2000;
	this.team[1].op = 2000;
	this.state = 8;
	this.battleUpdate = this.Game_BattleUpdate;
	this.enable_contact_test = true;
	this.time = -1;
	::camera.SetTarget(640, 340, 2.00000000, true);
	::camera.SetMode_Battle();
	this.Apply();
}

function Game_BattleUpdate()
{
	if (this.team[0].life <= 0)
	{
		this.team[0].life = 1;
	}

	if (this.team[1].life <= 0)
	{
		this.team[1].life = 1;
	}

	if (this.team[0].current.IsFree() && this.team[1].current.IsFree())
	{
		for( local i = 0; i < 2; i = ++i )
		{
			if (this.life_max[i] >= 0)
			{
				this.team[i].life = this.life_max[i];
				this.team[i].regain_life = this.life_max[i];
			}

			if (this.mp_max[i] >= 0)
			{
				this.team[i].mp = this.mp_max[i];
				this.team[i].mp_stop = 0;
			}

			if (this.op_max[i] >= 0)
			{
				if (this.team[i].current == this.team[i].master)
				{
					this.team[i].op = this.op_max[i];
					this.team[i].op_stop = 0;
				}
			}

			if (this.sp_max[i] >= 0)
			{
				if (this.team[i].spell_active == false)
				{
					switch(this.sp_max[i])
					{
					case 0:
						this.team[i].sp = 0;
						break;

					case 1:
						this.team[i].sp = this.team[i].sp_max;
						break;

					case 2:
						this.team[i].sp = this.team[i].sp_max2;
						break;
					}

					this.team[i].sp_stop = 0;
					this.team[i].sp2_enable = true;
				}
			}
		}
	}
}

function PracticeRestart()
{
	this.group_player.Clear(-1 & ~15);
	this.group_effect.Clear(-1);
	this.team[0].ResetRound();
	this.team[1].ResetRound();

	if (this.team[0].master.resetPracticeFunc)
	{
		this.team[0].master.resetPracticeFunc();
	}

	if (this.team[0].slave.resetPracticeFunc)
	{
		this.team[0].slave.resetPracticeFunc();
	}

	if (this.team[1].master.resetPracticeFunc)
	{
		this.team[1].master.resetPracticeFunc();
	}

	if (this.team[1].slave.resetPracticeFunc)
	{
		this.team[1].slave.resetPracticeFunc();
	}

	if (::config.practice.position[0] > 0)
	{
		this.team[0].master.Warp(1280 * (::config.practice.position[0] - 1) / 20, this.team[0].master.centerY);
		this.team[0].slave.Warp(1280 * (::config.practice.position[0] - 1) / 20, this.team[0].slave.centerY);
	}

	if (::config.practice.position[1] > 0)
	{
		this.team[1].master.Warp(1280 * (::config.practice.position[1] - 1) / 20, this.team[1].master.centerY);
		this.team[1].slave.Warp(1280 * (::config.practice.position[1] - 1) / 20, this.team[1].slave.centerY);
	}

	if (this.team[0].master.x <= this.team[1].master.x)
	{
		this.team[0].master.direction = 1.00000000;
		this.team[0].slave.direction = 1.00000000;
		this.team[1].master.direction = -1.00000000;
		this.team[1].slave.direction = -1.00000000;
	}
	else
	{
		this.team[0].master.direction = -1.00000000;
		this.team[0].slave.direction = -1.00000000;
		this.team[1].master.direction = 1.00000000;
		this.team[1].slave.direction = 1.00000000;
	}

	this.team[0].current.autoGuard = false;
	this.team[1].current.autoGuard = false;
	this.team[0].time_stop_count = 0;
	this.team[1].time_stop_count = 0;
	this.time_stop_count = 0;
	this.slow_count = 0;
	this.demoCount = 0;
	this.enable_contact_test = true;
	this.gauge.Show(true);
	::camera.Reset();
	::camera.SetTarget(640, 340, 2.00000000, true);
	::camera.SetMode_Battle();
	this.team[0].current.SetSpellBackReset();
	this.team[1].current.SetSpellBackReset();
	this.team[0].current.command.ResetAllReserve();
	this.team[0].current.command.Clear();
	this.team[1].current.command.ResetAllReserve();
	this.team[1].current.command.Clear();
}

function PracticeRestart_Wait()
{
	this.demoCount++;

	if (this.demoCount >= 10)
	{
		this.state = 8;
		this.battleUpdate = this.Game_BattleUpdate;
		return;
	}
}

