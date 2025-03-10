function Master_Spell_1()
{
	this.team.slave.Slave_Nitori_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.resist_baria = true;
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
	this.SetMotion(4940, 0);
	this.flag5 = {};
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 4;
	this.flag5.charge <- 120;
	this.flag5.vec <- this.Vector3();
	this.flag4 = null;
	this.SetSpeed_XY(0.00000000, 0.00000000);
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
		this.flag5.moveV = 6;
		this.flag5.charge = 90;
		break;

	case 2:
		this.flag5.moveV = 8;
		this.flag5.charge = 60;
		break;

	case 3:
	case 4:
		this.flag5.moveV = 10;
		this.flag5.charge = 45;
		break;
	}

	this.subState = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % 16 == 1)
				{
					this.PlaySE(2264);
				}

				this.HitCycleUpdate(16);

				if (this.count == this.flag5.charge)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.flag5.vec.x = this.target.x - this.x;
					this.flag5.vec.y = this.target.y - 25 - this.y;
					this.flag5.vec.Normalize();
					this.SetSpeed_XY(this.flag5.vec.x, this.flag5.vec.y);
					this.subState = function ()
					{
						this.AddSpeed_Vec(0.50000000, null, this.flag5.moveV, this.direction);
					};
				}

				if (this.va.y < 0.00000000 && this.y < ::battle.scroll_top || this.va.y > 0.00000000 && this.ground)
				{
					this.SetSpeed_XY(this.va.x, this.va.y * -0.66000003);
					this.flag5.vec.y *= -0.66000003;
				}

				if (this.count == 900 / this.flag5.moveV - 90)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count >= 900 / this.flag5.moveV)
				{
					this.M1_Change_Slave(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Master_Spell_1_Attack( t )
{
	if (this.com_flag1 >= 2)
	{
		this.Master_Spell_1_Stop(null);
		return;
	}

	this.LabelClear();
	this.GetFront();
	this.SetMotion(4940, 1);
	this.com_flag1++;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 4;
	this.flag5.charge <- 180;
	this.flag5.vec <- this.Vector3();
	this.SetSpeed_XY(0.00000000, 0.00000000);
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
		this.flag5.moveV = 6;
		this.flag5.charge = 150;
		break;

	case 2:
		this.flag5.moveV = 8;
		this.flag5.charge = 120;
		break;

	case 3:
	case 4:
		this.flag5.moveV = 10;
		this.flag5.charge = 90;
		break;
	}

	this.count = 0;
	this.flag5.vec.x = this.target.x - this.x;
	this.flag5.vec.y = this.target.y - 25 - this.y;
	this.flag5.vec.Normalize();
	this.SetSpeed_XY(this.flag5.vec.x * this.flag5.moveV, this.flag5.vec.y * this.flag5.moveV);
	this.stateLabel = function ()
	{
		if (this.count % 16 == 1)
		{
			this.PlaySE(2264);
		}

		this.HitCycleUpdate(16);
		this.AddSpeed_Vec(0.25000000, null, this.flag5.moveV, this.direction);

		if (this.va.y < 0.00000000 && this.y < ::battle.scroll_top || this.va.y > 0.00000000 && this.ground)
		{
			this.SetSpeed_XY(this.va.x, this.va.y * -0.66000003);
			this.flag5.vec.y *= -0.66000003;
		}

		if (this.count == 900 / this.flag5.moveV - 60)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count >= 900 / this.flag5.moveV)
		{
			this.M1_Change_Slave(null);
			return;
		}
	};
}

function Master_Spell_1_Stop( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4940, 2);
	this.com_flag1 = 0;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.moveCount <- 240;
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
		this.flag5.moveCount = 150;
		break;

	case 2:
		this.flag5.moveCount = 120;
		break;

	case 3:
	case 4:
		this.flag5.moveCount = 120;
		break;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == this.flag5.moveCount - 60)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count >= this.flag5.moveCount)
		{
			this.M1_Change_Slave(null);
			return;
		}
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Nitori(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Ichirin_1B()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Ichirin1B( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4941, 0);
	this.com_flag1++;
	this.flag3 = 0;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 4;
	this.flag5.charge <- 60;
	this.flag5.vec <- this.Vector3();
	local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
	r_ = this.Math_MinMax(r_, -0.52359873, 0.52359873);
	this.SetSpeed_Vec(-12.50000000, r_, this.direction);
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.centerStop = -2;
	this.AjustCenterStop();

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.moveV = 6;
		this.flag5.charge = 60;
		break;

	case 2:
		this.flag5.moveV = 8;
		this.flag5.charge = 60;
		break;

	case 3:
	case 4:
		this.flag5.moveV = 10;
		this.flag5.charge = 60;
		break;
	}

	this.func = [
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(4941, 1);
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			r_ = this.Math_MinMax(r_, -0.26179937, 0.26179937);
			this.SetSpeed_Vec(1.00000000, r_, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 16 == 1)
				{
					this.PlaySE(2264);
				}

				this.HitCycleUpdate(16);
				this.AddSpeed_Vec(0.50000000, null, this.flag5.moveV, this.direction);

				if (this.va.y < 0.00000000 && this.y < ::battle.scroll_top || this.va.y > 0.00000000 && this.ground)
				{
					this.SetSpeed_XY(this.va.x, this.va.y * -0.66000003);
					this.flag5.vec.y *= -0.66000003;
				}

				if (this.count >= 1050 / this.flag5.moveV)
				{
					if (this.com_difficulty == 4 && this.flag3 == 0)
					{
						this.flag3++;
						this.stateLabel = function ()
						{
							if (this.Vec_Brake(0.50000000))
							{
								this.GetFront();
								this.func[0].call(this);
							}
						};
					}
					else
					{
						this.func[1].call(this);
						return;
					}
				}
			};
		},
		function ()
		{
			this.SetMotion(4941, 3);
			this.count = 0;
			this.AjustCenterStop();
			this.subState = function ()
			{
				if (this.Vec_Brake(0.25000000, 1.50000000))
				{
					this.subState = function ()
					{
						this.CenterUpdate(0.10000000, 2.00000000);

						if (this.centerStop == 0)
						{
							this.VX_Brake(0.25000000);
						}
					};
				}
			};
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count >= 135)
				{
					this.Change_Master_Ichirin(null);
					return;
				}
			};
		}
	];
	this.count = 0;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.75000000, 0.50000000);

		if (this.count >= this.flag5.charge)
		{
			this.func[0].call(this);
		}
	};
}

function Change_Master_Ichirin( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1B_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

