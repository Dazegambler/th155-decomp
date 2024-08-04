function Master_Spell_1()
{
	this.team.slave.Slave_Sinmyoumaru_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
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
	this.SetMotion(4930, 0);
	this.flag5 = {};
	this.flag5.shotCount <- 240;
	this.flag5.shotNum <- 4;
	this.flag5.shotRot <- 60 * 0,01745329.0;
	this.flag5.shotRotStart <- -1,57079601.0;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 7,50000000.0;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.AjustCenterStop();
	this.count = 0;
	this.func = [
		function ( r_ )
		{
			this.PlaySE(3430);
			::camera.Shake(5,00000000.0);
			local pos_ = this.Vector3();
			pos_.x = 80;
			pos_.RotateByRadian(r_);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- r_ + 3,14159203.0 + this.flag5.shotRotStart + this.flag5.shotRot * i;
				this.SetShot(this.x + pos_.x, this.y + pos_.y, 1,00000000.0, this.Boss_Shot_MS1, t_);
			}
		}
	];

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 10,00000000.0;
		break;

	case 2:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 13,00000000.0;
		break;

	case 3:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 15,00000000.0;
		break;

	case 4:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 17,00000000.0;
		break;
	}

	this.keyAction = [
		null,
		null,
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);

		if (this.count >= this.flag5.charge)
		{
			this.count = 0;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(this.motion, 2);
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);

			if (r_ < 0,00000000.0)
			{
				r_ = -0,78539813.0;
			}
			else
			{
				r_ = 0,78539813.0;
			}

			this.SetSpeed_Vec(2,00000000.0, r_, this.direction);
			this.subState = function ()
			{
				if (this.va.Length() < this.flag5.moveV)
				{
					if (this.AddSpeed_Vec(0,50000000.0, null, this.flag5.moveV, this.direction))
					{
						this.subState = function ()
						{
						};
					}
				}
				else
				{
					this.subState = function ()
					{
					};
				}
			};
			this.stateLabel = function ()
			{
				if (this.count >= this.flag5.shotCount)
				{
					this.M1_Change_Slave(null);
					return;
				}

				if (this.count == this.flag5.shotCount - 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				this.subState();

				if (this.ground || this.va.y < 0,00000000.0 && this.y < ::battle.scroll_top + 50)
				{
					this.SetSpeed_XY(this.va.x, -this.va.y);
					this.HitReset();
					this.func[0].call(this, this.va.y < 0 ? 1,57079601.0 : -1,57079601.0);
				}

				if (this.wall)
				{
					this.SetSpeed_XY(-this.va.x, this.va.y);
					this.HitReset();
					this.func[0].call(this, this.va.x < 0 ? 0 : 3,14159203.0);
				}
			};
		}
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Sinmyoumaru(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_1B()
{
	this.team.slave.Slave_Sinmyoumaru_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
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

					this.Master_Spell_1B_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_1B_ChangeAttack( t )
{
	this.LabelClear();
	this.SetMotion(4930, 2);
	this.flag5 = {};
	this.flag5.shotCount <- 240;
	this.flag5.shotNum <- 4;
	this.flag5.shotRot <- 60 * 0,01745329.0;
	this.flag5.shotRotStart <- -1,57079601.0;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 7,50000000.0;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.AjustCenterStop();
	this.count = 0;
	this.func = [
		function ( r_ )
		{
			this.PlaySE(3430);
			::camera.Shake(5,00000000.0);
			local pos_ = this.Vector3();
			pos_.x = 80;
			pos_.RotateByRadian(r_);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- r_ + 3,14159203.0 + this.flag5.shotRotStart + this.flag5.shotRot * i;
				this.SetShot(this.x + pos_.x, this.y + pos_.y, 1,00000000.0, this.Boss_Shot_MS1B, t_);
			}
		}
	];

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 10,00000000.0;
		break;

	case 2:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 13,00000000.0;
		break;

	case 3:
	case 4:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 17,00000000.0;
		break;
	}

	this.count = 0;
	this.SetSpeed_Vec(2,00000000.0, t, 1,00000000.0);
	this.subState = function ()
	{
		if (this.va.Length() < this.flag5.moveV)
		{
			if (this.AddSpeed_Vec(0,50000000.0, null, this.flag5.moveV, this.direction))
			{
				this.subState = function ()
				{
				};
			}
		}
		else
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.count >= this.flag5.shotCount)
		{
			local r_ = this.atan2(this.va.y, this.va.x);
			this.M1B_Change_Slave(r_);
			return;
		}

		if (this.count == this.flag5.shotCount - 60)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		this.subState();

		if (this.ground || this.va.y < 0,00000000.0 && this.y < ::battle.scroll_top + 50)
		{
			this.SetSpeed_XY(this.va.x, -this.va.y);
			this.HitReset();
			this.func[0].call(this, this.va.y < 0 ? 1,57079601.0 : -1,57079601.0);
		}

		if (this.wall)
		{
			this.SetSpeed_XY(-this.va.x, this.va.y);
			this.HitReset();
			this.func[0].call(this, this.va.x < 0 ? 0 : 3,14159203.0);
		}
	};
}

function Master_Spell_1B_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4930, 0);
	this.flag5 = {};
	this.flag5.shotCount <- 240;
	this.flag5.shotNum <- 4;
	this.flag5.shotRot <- 60 * 0,01745329.0;
	this.flag5.shotRotStart <- -1,57079601.0;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 7,50000000.0;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.AjustCenterStop();
	this.count = 0;
	this.func = [
		function ( r_ )
		{
			this.PlaySE(3430);
			::camera.Shake(5,00000000.0);
			local pos_ = this.Vector3();
			pos_.x = 80;
			pos_.RotateByRadian(r_);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- r_ + 3,14159203.0 + this.flag5.shotRotStart + this.flag5.shotRot * i;
				this.SetShot(this.x + pos_.x, this.y + pos_.y, 1,00000000.0, this.Boss_Shot_MS1B, t_);
			}
		}
	];

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 10,00000000.0;
		break;

	case 2:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 13,00000000.0;
		break;

	case 3:
	case 4:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 17,00000000.0;
		break;
	}

	this.keyAction = [
		null,
		null,
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);

		if (this.count >= this.flag5.charge)
		{
			this.count = 0;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(this.motion, 2);
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);

			if (r_ < 0,00000000.0)
			{
				r_ = -0,78539813.0;
			}
			else
			{
				r_ = 0,78539813.0;
			}

			this.SetSpeed_Vec(2,00000000.0, r_, this.direction);
			this.subState = function ()
			{
				if (this.va.Length() < this.flag5.moveV)
				{
					if (this.AddSpeed_Vec(0,50000000.0, null, this.flag5.moveV, this.direction))
					{
						this.subState = function ()
						{
						};
					}
				}
				else
				{
					this.subState = function ()
					{
					};
				}
			};
			this.stateLabel = function ()
			{
				if (this.count >= this.flag5.shotCount)
				{
					local r_ = this.atan2(this.va.y, this.va.x);
					this.M1B_Change_Slave(r_);
					return;
				}

				if (this.count == this.flag5.shotCount - 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				this.subState();

				if (this.ground || this.va.y < 0,00000000.0 && this.y < ::battle.scroll_top + 50)
				{
					this.SetSpeed_XY(this.va.x, -this.va.y);
					this.HitReset();
					this.func[0].call(this, this.va.y < 0 ? 1,57079601.0 : -1,57079601.0);
				}

				if (this.wall)
				{
					this.SetSpeed_XY(-this.va.x, this.va.y);
					this.HitReset();
					this.func[0].call(this, this.va.x < 0 ? 0 : 3,14159203.0);
				}
			};
		}
	};
}

function M1B_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Sinmyoumaru(t);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_1C()
{
	this.team.slave.Slave_Sinmyoumaru_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
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

					this.Master_Spell_1C_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_1C_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4930, 0);
	this.SetSpeed_XY(-9,00000000.0 * this.direction, 0,00000000.0);
	this.flag5 = {};
	this.flag5.shotCount <- 240;
	this.flag5.shotNum <- 4;
	this.flag5.shotRot <- 60 * 0,01745329.0;
	this.flag5.shotRotStart <- -1,57079601.0;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 7,50000000.0;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.AjustCenterStop();
	this.count = 0;
	this.func = [
		function ( r_ )
		{
			this.PlaySE(3430);
			::camera.Shake(5,00000000.0);
			local pos_ = this.Vector3();
			pos_.x = 80;
			pos_.RotateByRadian(r_);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- r_ + 3,14159203.0 + this.flag5.shotRotStart + this.flag5.shotRot * i;
				this.SetShot(this.x + pos_.x, this.y + pos_.y, 1,00000000.0, this.Boss_Shot_MS1C, t_);
			}
		}
	];

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 10,00000000.0;
		break;

	case 2:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 13,00000000.0;
		break;

	case 3:
	case 4:
		this.flag5.shotNum <- 10;
		this.flag5.shotRot <- 20 * 0,01745329.0;
		this.flag5.moveV = 17,00000000.0;
		break;
	}

	this.keyAction = [
		null,
		null,
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);

		if (this.count >= this.flag5.charge)
		{
			this.count = 0;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(this.motion, 2);
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);

			if (r_ < 0,00000000.0)
			{
				r_ = -0,78539813.0;
			}
			else
			{
				r_ = 0,78539813.0;
			}

			this.SetSpeed_Vec(2,00000000.0, r_, this.direction);
			this.subState = function ()
			{
				if (this.va.Length() < this.flag5.moveV)
				{
					if (this.AddSpeed_Vec(0,50000000.0, null, this.flag5.moveV, this.direction))
					{
						this.subState = function ()
						{
						};
					}
				}
				else
				{
					this.subState = function ()
					{
					};
				}
			};
			this.stateLabel = function ()
			{
				if (this.count >= this.flag5.shotCount)
				{
					this.M1C_Change_Slave(null);
					return;
				}

				if (this.count == this.flag5.shotCount - 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				this.subState();

				if (this.ground || this.va.y < 0,00000000.0 && this.y < ::battle.scroll_top + 50)
				{
					this.SetSpeed_XY(this.va.x, -this.va.y);
					this.HitReset();
					this.func[0].call(this, this.va.y < 0 ? 1,57079601.0 : -1,57079601.0);
				}

				if (this.wall)
				{
					this.SetSpeed_XY(-this.va.x, this.va.y);
					this.HitReset();
					this.func[0].call(this, this.va.x < 0 ? 0 : 3,14159203.0);
				}
			};
		}
	};
}

function M1C_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Sinmyoumaru(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Udonge_1()
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

function Slave_Attack_Udonge( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 60;
	this.flag5.shotNum <- 6;
	this.flag5.shotRot <- 1,04719746.0;
	this.flag5.wait <- 240;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
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
		this.flag5.shotCycle = 40;
		this.flag5.shotNum = 8;
		this.flag5.shotRot = 0,78539813.0;
		break;

	case 2:
		this.flag5.shotCycle = 25;
		this.flag5.shotNum = 10;
		this.flag5.shotRot = 36 * 0,01745329.0;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 15;
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0,52359873.0;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.master.shot_actor.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,02500000.0, null);

				if (this.flag4 == null && this.count % this.flag5.shotCycle == 1 && this.count <= 90)
				{
					this.PlaySE(3430);

					for( local i = 0; i < this.flag5.shotNum; i++ )
					{
						local t_ = {};
						t_.rot <- i * this.flag5.shotRot;
						t_.v <- 6,00000000.0 - this.rand() % 15 * 0,10000000.0;
						this.SetShot(this.point0_x, this.point0_y, 1,00000000.0, this.Boss_Shot_SL1, t_);
					}
				}

				if (this.count == this.flag5.wait - 90)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == this.flag5.wait)
				{
					this.Change_Master_Udonge(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Udonge( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Attack_B(null);
}

function Slave_Tenshi_1()
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

function Slave_Tenshi_2()
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

function Slave_Attack_Tenshi( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 60;
	this.flag5.shotNum <- 6;
	this.flag5.shotRot <- 1,04719746.0;
	this.flag5.wait <- 300;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
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
		this.flag5.shotCycle = 40;
		this.flag5.shotNum = 8;
		this.flag5.shotRot = 0,78539813.0;
		break;

	case 2:
		this.flag5.shotCycle = 25;
		this.flag5.shotNum = 10;
		this.flag5.shotRot = 36 * 0,01745329.0;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 10;
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0,52359873.0;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.master.shot_actor.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.PlaySE(3475);
			this.flag5.shotRot = this.rand() % 360 * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,02500000.0, null);

				if (this.owner.com_difficulty == 4 && this.count <= 90)
				{
					if (this.count % 10 == 1)
					{
						this.PlaySE(3430);
					}

					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					t_.v <- 6,00000000.0 - this.rand() % 15 * 0,10000000.0;
					this.SetShot(this.point0_x, this.point0_y, 1,00000000.0, this.Boss_Shot_SL1, t_);
					this.flag5.shotRot -= 0,13962634.0;
				}

				if (this.count == this.flag5.wait - 90)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == this.flag5.wait)
				{
					this.Change_Master_Tenshi(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Tenshi( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Move();
}

function Slave_Attack2_Tenshi( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 90;
	this.flag5.wait <- 240;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
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
		this.flag5.shotCycle = 60;
		break;

	case 2:
		this.flag5.shotCycle = 60;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 40;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.master.shot_actor.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.stateLabel = function ()
			{
				if (this.count <= this.flag5.wait && this.count % this.flag5.shotCycle == 1)
				{
					this.team.master.SetShot(this.target.x, ::battle.scroll_top - 256, this.direction, this.team.master.Shot2_Big_Kaname, {});
				}

				if (this.com_difficulty == 4 && this.count <= this.flag5.wait && this.count % this.flag5.shotCycle == 11)
				{
					this.team.master.SetShot(this.target.x, ::battle.scroll_top - 256, this.direction, this.team.master.Shot2_Big_Kaname, {});
				}

				if (this.count == this.flag5.wait)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == this.flag5.wait + 90)
				{
					this.Change_Master2_Tenshi(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master2_Tenshi( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_2_Move();
}

function Slave_Tenshi_3()
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

function Slave_Attack3_Tenshi( t )
{
	this.LabelClear();
	this.SetMotion(4940, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 90;
	this.flag5.wait <- 240;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
	this.direction = this.team.master.direction;
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
		this.flag5.shotCycle = 60;
		break;

	case 2:
		this.flag5.shotCycle = 60;
		break;

	case 3:
		this.flag5.shotCycle = 40;
		break;

	case 4:
		this.flag5.shotCycle = 40;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 210)
				{
					this.Change_Master3_Tenshi(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master3_Tenshi( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_3_Move();
}

