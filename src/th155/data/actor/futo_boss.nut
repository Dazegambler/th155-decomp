function Master_Spell_1()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					this.Master_Spell_1_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_1_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4992, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 400 * this.direction;
	this.flag5.pos.y = 240;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 10,00000000.0)
		{
			this.flag5.moveV = 10,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,25000000.0))
				{
					this.Master_Spell_1_Dream_Attack();
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(-this.direction);
		}
	};
}

function Slave_Ichirin_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Ichirin( t )
{
	this.LabelClear();
	this.SetMotion(4930, 1);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 3;
	this.flag5.shotNum <- 8;
	this.flag5.wait <- 150;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.wait = 90;
		break;

	case 2:
		this.flag5.wait = 30;
		break;

	case 3:
		this.flag5.wait = 30;
		break;
	}

	this.func = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VY_Brake(0,75000000.0);

				if (this.count == 90)
				{
					this.flag2.func[0].call(this.flag2);
					this.S_Mamizou_2_Change_Master(null);
					return;
				}
			};
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.team.master.shot_actor.Foreach(function ()
			{
				this.team.slave.SetShot(this.x, this.y, this.direction, this.team.slave.Boss_Shot_SL1, {});
				this.func[0].call(this);
			});
			this.count = 0;
			this.PlaySE(1965);
			this.SetSpeed_XY(-12,50000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0, -1,00000000.0 * this.direction);
				this.CenterUpdate(0,05000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,05000000.0);
				this.CenterUpdate(0,05000000.0, 3,00000000.0);

				if (this.count >= this.flag5.wait)
				{
					this.Slave_Move(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Slave_Move( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0,00000000.0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.flag1.x = ::battle.corner_right - 400;
		this.flag1.y = this.centerY - 150 + this.rand() % 301;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 400;
		this.flag1.y = this.centerY - 150 + this.rand() % 301;
	}

	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0,40000001.0;

		if (this.flag2 >= 12,50000000.0)
		{
			this.flag2 = 12,50000000.0;
		}

		this.SetSpeed_XY((this.flag1.x - this.x) * 0,10000000.0, (this.flag1.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ <= 2,00000000.0)
		{
			this.Change_Master_Ichirin(null);
			return;
		}
	};
}

function Change_Master_Ichirin( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

