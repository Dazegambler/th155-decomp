function Master_Spell_1()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
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
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.flag5.moveV += 0.25000000;

		if (this.flag5.moveV > 10.00000000)
		{
			this.flag5.moveV = 10.00000000;
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

				if (this.Vec_Brake(0.25000000))
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

function Slave_Yukari_1()
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

function Slave_Attack_Yukari( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 3;
	this.flag5.shotNum <- 6;
	this.flag5.shotRot <- 0.00000000;
	this.flag5.shotRotAdd <- 1.04719746;
	this.flag5.wait <- 150;
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
	case 1:
		this.flag5.shotNum = 8;
		this.flag5.shotRotAdd = 0.78539813;
		break;

	case 2:
		this.flag5.shotNum = 10;
		this.flag5.shotRotAdd = 36 * 0.01745329;
		break;

	case 3:
		this.flag5.shotNum = 12;
		this.flag5.shotRotAdd = 0.52359873;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(1155);
			this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.SpellShot_A_Bou, {});
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag5.shotNum > 0 && this.count % this.flag5.shotCycle == 1)
				{
					this.PlaySE(1156);
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					this.flag5.shotRot += this.flag5.shotRotAdd;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_SL1, t_);
					this.flag5.shotNum--;

					if (this.flag5.shotNum <= 0)
					{
						this.count = 0;
						this.stateLabel = function ()
						{
							if (this.count >= 180)
							{
								this.Change_Master_Yukari(null);
								return;
							}
						};
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Yukari( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1B_Move();
}

function Slave_Attack_Yukari2( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4921, 0);
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;
	this.flag1 = 0.00000000;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotNum <- 2;
	this.flag5.shotWay <- 3.14159203;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 0.26179937;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 120;
		break;

	case 2:
		this.flag5.shotNum = 3;
		this.flag5.shotWay = 2.09439468;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 180;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotWay = 1.57079601;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 240;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local pos_ = this.Vector3();
			pos_.x = 100.00000000;
			pos_.RotateByRadian(this.flag5.shotRot);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.shotRot;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_SL2, t_);
				pos_.RotateByRadian(this.flag5.shotWay);
				this.flag5.shotRot += this.flag5.shotWay;
			}

			this.flag5.shotRot += this.flag5.shotRotSpeed;
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0.50000000;

		if (this.flag1 > 10.00000000)
		{
			this.flag1 = 10.00000000;
		}

		this.va.x = (640 - this.x) * 0.10000000;
		this.va.y = (200 - this.y) * 0.10000000;

		if (this.va.Length() >= this.flag1)
		{
			this.va.SetLength(this.flag1);
		}

		this.ConvertTotalSpeed();

		if (this.count % this.flag5.shotCycle == 1)
		{
			this.func[0].call(this);
		}

		if (this.count == this.flag5.shotCount)
		{
			this.Set_BossSpellBariaRate(1);
		}

		if (this.count == this.flag5.shotCount)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count == this.flag5.shotCount + 90)
		{
			this.Change_Master2_Yukari(null);
			return;
		}
	};
}

function Change_Master2_Yukari( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_2B_FastAttack(null);
}

