function Master_Spell_1()
{
	this.team.slave.Slave_Kokoro_1();
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
	this.Master_Spell_1_Attack(null);
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4920, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCount <- 0;
	this.flag5.shotNum <- 2;
	this.flag5.shotRange <- 3;
	this.flag5.shotRotDist <- 3.14159203;
	this.flag5.addRot <- 0.00000000;
	this.flag5.moveV <- 0;
	this.flag5.moveV_Max <- 2.00000000;
	this.flag5.mask <- [];

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 4;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 2.50000000;
		break;

	case 2:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 6;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 3.25000000;
		break;

	case 3:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 8;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 4.00000000;
		break;

	case 4:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 8;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 4.00000000;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[1] = function ()
	{
		if (this.count == 45)
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.count = 0;
			this.PlaySE(2902);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- -1.57079601 + this.flag5.shotRotDist * i;
				t_.range <- this.flag5.shotRange;
				t_.type <- i;
				this.flag5.mask.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS1_Core, t_).weakref());
			}

			this.subState[1] = function ()
			{
				if (this.count == 90)
				{
					this.count = 0;
					this.PlaySE(2955);

					foreach( a in this.flag5.mask )
					{
						if (a)
						{
							a.func[1].call(a);
						}
					}

					this.subState[1] = function ()
					{
						this.flag5.moveV += 0.02500000;

						if (this.flag5.moveV > this.flag5.moveV_Max)
						{
							this.flag5.moveV = this.flag5.moveV_Max;
						}

						this.va.x = this.target.x - this.x;
						this.va.y = this.target.y - this.y;

						if (this.va.Length() <= 2.00000000)
						{
							this.SetSpeed_XY(0.00000000, 0.00000000);
						}
						else
						{
							this.va.SetLength(this.flag5.moveV);
							this.ConvertTotalSpeed();
						}

						if (this.count == 360)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == 450)
						{
							if (this.flag4)
							{
								this.flag4.func();
							}

							this.flag4 = null;
							this.M1_Change_Slave(null);
							return;
						}
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Kokoro(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_D1()
{
	this.team.slave.Slave_Dream_1();
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

					this.Master_Spell_D1_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_D1_Start()
{
	this.LabelClear();
	this.direction = this.x < 640 ? 1.00000000 : -1.00000000;
	this.SetSpeed_XY(-8.00000000 * this.direction, -6.00000000);
	this.SetMotion(4992, 0);
	this.count = 0;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCount <- 0;
	this.flag5.shotNum <- 2;
	this.flag5.shotRange <- 3;
	this.flag5.shotRotDist <- 3.14159203;
	this.flag5.addRot <- 6.28318548;
	this.flag5.moveV <- 0;
	this.flag5.moveV_Max <- 6.00000000;
	this.flag5.movePos <- this.Vector3();
	this.flag5.waitPos <- this.Vector3();
	this.flag5.waitPos.x = 640.00000000;
	this.flag5.waitPos.y = this.centerY - 80;
	this.flag5.movePos.x = (this.x - this.flag5.waitPos.x) * this.direction;
	this.flag5.movePos.y = this.y - this.flag5.waitPos.y;
	this.flag5.mask <- [];

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 4;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 2.50000000;
		break;

	case 2:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 6;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 3.25000000;
		break;

	case 3:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 8;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 4.00000000;
		break;

	case 4:
		this.flag5.shotNum = 3;
		this.flag5.shotRange = 10;
		this.flag5.shotRotDist = 2.09439468;
		this.flag5.moveV_Max = 4.00000000;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[0] = function ()
	{
		if (this.Vec_Brake(0.25000000))
		{
			this.count = 0;
			this.SetMotion(4991, 0);
			this.subState[0] = function ()
			{
				if (this.count >= 90)
				{
					this.Master_Spell_D1_Attack(null);
					return;
				}

				this.flag5.moveV += 0.30000001;

				if (this.flag5.moveV > 12.50000000)
				{
					this.flag5.moveV = 12.50000000;
				}

				this.SetSpeed_XY((this.flag5.waitPos.x - this.x) * 0.10000000, (this.flag5.waitPos.y - this.y) * 0.10000000);

				if (this.keyTake == 1 && this.va.Length() <= 3.00000000)
				{
					this.SetMotion(4991, 2);
				}

				if (this.va.Length() > this.flag5.moveV)
				{
					this.va.SetLength(this.flag5.moveV);
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_D1_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4920, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCount <- 0;
	this.flag5.shotNum <- 3;
	this.flag5.shotRange <- 4;
	this.flag5.shotRotDist <- 2.09439468;
	this.flag5.addRot <- 0.00000000;
	this.flag5.moveV <- 0;
	this.flag5.moveV_Max <- 1.75000000;
	this.flag5.movePos <- this.Vector3();
	this.flag5.waitPos <- this.Vector3();
	this.flag5.mask <- [];
	this.flag5.wait <- this.rand() % 45;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotRange = 5;
		this.flag5.moveV_Max = 2.50000000;
		break;

	case 2:
		this.flag5.shotRange = 6;
		this.flag5.moveV_Max = 3.09999990;
		break;

	case 3:
		this.flag5.shotRange = 8;
		this.flag5.moveV_Max = 3.75000000;
		break;

	case 4:
		this.flag5.shotRange = 10;
		this.flag5.moveV_Max = 3.75000000;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.func = [
		function ()
		{
			this.flag5.movePos.x = 125 - this.rand() % 250;
			this.flag5.movePos.y = 150 - this.rand() % 301;
			this.flag5.moveV = 0;
			this.subState[0] = function ()
			{
				this.flag5.moveV += 0.15000001;

				if (this.flag5.moveV > this.flag5.moveV_Max)
				{
					this.flag5.moveV = this.flag5.moveV_Max;
				}

				this.va.x = (this.target.x + this.flag5.movePos.x - this.x) * 0.10000000;
				this.va.y = (this.target.y + this.flag5.movePos.y - this.y) * 0.10000000;

				if (this.va.Length() > this.flag5.moveV)
				{
					this.va.SetLength(this.flag5.moveV);
				}
			};
		},
		function ()
		{
			this.flag5.movePos.x = 0;
			this.flag5.movePos.y = -100;
			this.flag5.moveV = 0;
			this.subState[0] = function ()
			{
				this.flag5.moveV += 0.02500000;

				if (this.flag5.moveV > 1.00000000)
				{
					this.flag5.moveV = 1.00000000;
				}

				this.va.x = (this.target.x + this.flag5.movePos.x - this.x) * 0.10000000;
				this.va.y = (this.target.y + this.flag5.movePos.y - this.y) * 0.10000000;

				if (this.va.Length() > this.flag5.moveV)
				{
					this.va.SetLength(this.flag5.moveV);
				}
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.count = 0;
			this.PlaySE(2902);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- -1.57079601 + this.flag5.shotRotDist * i;
				t_.range <- this.flag5.shotRange;
				t_.type <- i;
				this.flag5.mask.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_DS1_Core, t_).weakref());
			}

			this.subState[1] = function ()
			{
				if (this.count == 40)
				{
					this.count = 0;
					this.PlaySE(2955);

					foreach( a in this.flag5.mask )
					{
						if (a)
						{
							a.func[1].call(a);
						}
					}

					this.func[0].call(this);
					this.subState[1] = function ()
					{
						if (this.count == 130 || this.count == 220)
						{
							this.func[0].call(this);
						}

						if (this.count == 310)
						{
							this.func[1].call(this);
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();

							foreach( a in this.flag5.mask )
							{
								if (a)
								{
									a.func[3].call(a);
								}
							}
						}

						if (this.count == 480 + this.flag5.wait)
						{
							if (this.flag4)
							{
								this.flag4.func();
							}

							this.flag4 = null;

							foreach( a in this.flag5.mask )
							{
								if (a)
								{
									a.func[2].call(a);
								}
							}

							this.D1_Change_Slave(null);
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function D1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.Master_Spell_D1_Attack(t);
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Slave_Nitori_1()
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

function Slave_Attack_Nitori( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 3;
	this.flag5.shotNum <- 8;
	this.flag5.wait <- 150;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0.00000000;

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- i * 1.04719746;
		t_.v <- 24.00000000;
		this.SetShot(this.x, this.y, 1.00000000, this.Boss_Shot_SL1, t_);
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
			t_.rot <- 0.52359873 + i * 1.04719746;
			t_.v <- 36.00000000;
			this.SetShot(this.x, this.y, 1.00000000, this.Boss_Shot_SL1, t_);
		}

		break;

	case 3:
	case 4:
		this.flag5.wait = 60;

		for( local i = 0; i < 6; i++ )
		{
			local t_ = {};
			t_.rot <- 0.52359873 + i * 1.04719746;
			t_.v <- 36.00000000;
			this.SetShot(this.x, this.y, 1.00000000, this.Boss_Shot_SL1, t_);
		}

		for( local i = 0; i < 6; i++ )
		{
			local t_ = {};
			t_.rot <- i * 1.04719746;
			t_.v <- 48.00000000;
			this.SetShot(this.x, this.y, 1.00000000, this.Boss_Shot_SL1, t_);
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
				this.va.x = (this.flag5.pos.x - this.x) * 0.20000000;
				this.va.y = (this.flag5.pos.y - this.y) * 0.20000000;
				this.flag5.v += 0.89999998;
				local r_ = this.va.Length();

				if (r_ > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}

				this.ConvertTotalSpeed();

				if (r_ <= 1.00000000)
				{
					this.shot_actor.Foreach(function ()
					{
						this.func[2].call(this);
					});
					this.SetMotion(4910, 2);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.count = 0;
					this.PlaySE(2987);
					::camera.Shake(3.00000000);
					this.stateLabel = function ()
					{
						if (this.count == this.flag5.wait - 45)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
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

