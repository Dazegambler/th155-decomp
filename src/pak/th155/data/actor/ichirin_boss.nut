function Master_Spell_1()
{
	this.team.slave.Slave_Ichirin_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
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
					if (this.team.shield == null)
					{
						this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
					}

					this.Master_Spell_1_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4992, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 25;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 90;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 0;
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);
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
		this.flag5.shotCycle = 17;
		this.flag5.shotRot = 120;
		break;

	case 2:
		this.flag5.shotCycle = 11;
		this.flag5.shotRot = 150;
		break;

	case 3:
		this.flag5.shotCycle = 7;
		this.flag5.shotRot = 180;
		break;
	}

	this.count = -20;
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 1.00000000);

		if (this.count < 0)
		{
			this.AddSpeed_XY(-0.50000000 * this.direction, 0.00000000, -6.00000000 * this.direction, null);
		}
		else
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.SetMotion(4910, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000, -0.50000000 * this.direction);
				this.CenterUpdate(0.10000000, 1.00000000);

				if (this.count >= this.flag5.charge)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.SetMotion(this.motion, 2);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(-0.05000000 * this.direction, 0.00000000, -3.00000000 * this.direction, null);

						if (this.count % 15 == 1)
						{
							this.PlaySE(1553);
						}

						if (this.count % this.flag5.shotCycle == 1)
						{
							this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS1, {});
						}

						if (this.count == 90)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == 210)
						{
							this.M1_Change_Slave(null);
						}
					};
				}
			};
		}
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Ichirin(null);
	this.Set_BossSpellBariaRate(10);
}

