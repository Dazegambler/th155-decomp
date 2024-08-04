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

function Slave_Nitori_1()
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

function Slave_Attack_Nitori( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 3;
	this.flag5.shotNum <- 8;
	this.flag5.wait <- 150;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- i * 1,04719746.0;
		t_.v <- 24,00000000.0;
		this.SetShot(this.x, this.y, 1,00000000.0, this.Boss_Shot_SL1, t_);
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.wait = 90;
		break;

	case 2:
		this.flag5.wait = 60;

		for( local i = 0; i < 6; i++ )
		{
			local t_ = {};
			t_.rot <- 0,52359873.0 + i * 1,04719746.0;
			t_.v <- 36,00000000.0;
			this.SetShot(this.x, this.y, 1,00000000.0, this.Boss_Shot_SL1, t_);
		}

		break;

	case 3:
		this.flag5.wait = 60;

		for( local i = 0; i < 6; i++ )
		{
			local t_ = {};
			t_.rot <- 0,52359873.0 + i * 1,04719746.0;
			t_.v <- 36,00000000.0;
			this.SetShot(this.x, this.y, 1,00000000.0, this.Boss_Shot_SL1, t_);
		}

		for( local i = 0; i < 6; i++ )
		{
			local t_ = {};
			t_.rot <- i * 1,04719746.0;
			t_.v <- 48,00000000.0;
			this.SetShot(this.x, this.y, 1,00000000.0, this.Boss_Shot_SL1, t_);
		}

		break;
	}

	this.keyAction = [
		function ()
		{
			this.flag5.pos.x = this.target.x;
			this.flag5.pos.y = this.target.y - 25;
			this.count = 0;
			this.shot_actor.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.stateLabel = function ()
			{
				this.va.x = (this.flag5.pos.x - this.x) * 0,20000000.0;
				this.va.y = (this.flag5.pos.y - this.y) * 0,20000000.0;
				this.flag5.v += 0,89999998.0;
				local r_ = this.va.Length();

				if (r_ > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}

				this.ConvertTotalSpeed();

				if (r_ <= 1,00000000.0)
				{
					this.shot_actor.Foreach(function ()
					{
						this.func[2].call(this);
					});
					this.SetMotion(4910, 2);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.count = 0;
					this.PlaySE(2987);
					::camera.Shake(3,00000000.0);
					this.stateLabel = function ()
					{
						if (this.count == this.flag5.wait - 45)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == this.flag5.wait)
						{
							this.Change_Master_Nitori(null);
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Nitori( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Attack(null);
}

