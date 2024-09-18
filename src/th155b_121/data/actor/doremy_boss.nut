function Mukon_Charge( val_ )
{
}

function Master_Spell_1()
{
	this.team.slave.Slave_Doremy_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.Master_Spell_1_Start(null);
				}
			};
		}
	};
}

function Master_Spell_1_Start( t )
{
	this.com_flag2 = 0;
	local pos_ = this.Vector3();
	pos_.x = 160 + this.rand() % 160;
	pos_.y = 80 + this.rand() % 120;

	if (this.x > ::battle.scroll_right - 360)
	{
		pos_.x = -pos_.x;
	}
	else if (this.x > ::battle.scroll_left + 360 && this.rand() % 100 <= 49)
	{
		pos_.x = -pos_.x;
	}

	if (this.y > ::battle.scroll_bottom - 360)
	{
		pos_.y = -pos_.y;
	}
	else if (this.y > ::battle.scroll_top + 360 && this.rand() % 100 <= 49)
	{
		pos_.y = -pos_.y;
	}

	this.MS1_Move(pos_);
}

function MS1_Move( t )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x + t.x;
	this.flag1.y = this.y + t.y;
	this.flag2 = 0.00000000;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0.40000001;

		if (this.flag2 >= 10.00000000)
		{
			this.flag2 = 10.00000000;
		}

		this.SetSpeed_XY((this.flag1.x - this.x) * 0.10000000, (this.flag1.y - this.y) * 0.10000000);
		local v_ = this.va.Length();

		if (v_ >= this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7.00000000)
		{
			this.flag3 = 0.00000000;
		}

		if (v_ <= 2.00000000)
		{
			this.MS1_Attack(null);
			return;
		}
	};
}

function MS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.v <- this.Vector3();

	switch(this.com_difficulty)
	{
	case 1:
		break;

	case 2:
		break;

	case 3:
		break;

	case 4:
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.func = [
		function ()
		{
			if (this.flag5.v.x == 0.00000000)
			{
				this.flag5.v.x = 0.02500000;
				this.flag5.v.RotateByDegree(-150);
			}
			else if (this.flag5.v.x > 0.00000000)
			{
				this.flag5.v.x = -0.02500000;
				this.flag5.v.RotateByDegree(20 - this.rand() % 41);
			}
			else
			{
				this.flag5.v.x = 0.02500000;
				this.flag5.v.RotateByDegree(20 - this.rand() % 41);
			}

			this.subState = function ()
			{
				if (this.flag4)
				{
					this.subState = function ()
					{
						this.Vec_Brake(0.10000000);
					};
					return;
				}

				if (this.count % 90 == 89)
				{
					this.func[0].call(this);
				}

				if (this.flag5.v.y < 0 && this.y < this.centerY - 80 || this.flag5.v.y > 0 && this.y > this.centerY + 80)
				{
					this.flag5.v.y *= -1.00000000;
				}

				this.AddSpeed_XY(this.flag5.v.x, this.flag5.v.y);

				if (this.va.Length() > 1.50000000)
				{
					this.va.SetLength(1.50000000);
				}

				this.ConvertTotalSpeed();
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(4045);

			if (this.back_park == null)
			{
				this.back_park = this.SetFreeObjectStencil(640, 360, 1.00000000, this.Occult_Back, {}).weakref();
			}

			local t_ = {};
			t_.scale <- 2.50000000;
			t_.level <- 3;
			this.back_hole.append(this.SetShotStencil(this.x, this.y, this.direction, this.Boss_Shot_MS1_Hole, t_).weakref());
			this.count = 0;
			this.func[0].call(this);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 420)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 480)
				{
					this.M1_Change_Slave(null);
					return;
				}
			};
		}
	];
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Doremy(null);
	this.Set_BossSpellBariaRate(10);
}

function MS1_Attack_Fall( t )
{
	this.LabelClear();
	this.SetMotion(4911, 4);
	this.HitReset();

	switch(this.com_difficulty)
	{
	case 0:
		this.flag5 = 30;
		break;

	case 1:
		this.flag5 = 20;
		break;

	case 2:
		this.flag5 = 10;
		break;

	case 3:
	case 4:
		this.flag5 = 0;
		break;
	}

	this.count = 0;
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(-2.00000000 * this.direction, -17.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.va.y < -5.00000000 ? 0.66000003 : 0.20000000);

				if (this.va.y > 0.00000000 && this.y >= this.centerY)
				{
					this.MS1_Attack(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.count >= this.flag5)
		{
			this.GetFront();
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS1_Core, {});
			this.armor = -1;
			this.count = 0;
			this.centerStop = -2;
			this.AjustCenterStop();
			this.SetSpeed_XY(0.00000000, 5.00000000);
			this.SetMotion(4911, 0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000, 0.00000000, 20.00000000);

				if (this.y > this.centerY + 220)
				{
					::camera.Shake(8.00000000);
					this.PlaySE(4068);
					this.SetMotion(4911, 1);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	};
}

function Master_Spell_2()
{
	this.team.slave.Slave_Doremy_2();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.Master_Spell_2_Start(null);
				}
			};
		}
	};
}

function Master_Spell_2_Start( t )
{
	this.com_flag2 = 0;
	local pos_ = this.Vector3();
	pos_.x = 160 + this.rand() % 160;
	pos_.y = 80 + this.rand() % 120;

	if (this.x > ::battle.scroll_right - 360)
	{
		pos_.x = -pos_.x;
	}
	else if (this.x > ::battle.scroll_left + 360 && this.rand() % 100 <= 49)
	{
		pos_.x = -pos_.x;
	}

	if (this.y > ::battle.scroll_bottom - 360)
	{
		pos_.y = -pos_.y;
	}
	else if (this.y > ::battle.scroll_top + 360 && this.rand() % 100 <= 49)
	{
		pos_.y = -pos_.y;
	}

	this.MS2_Move(pos_);
}

function MS2_Move( t )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x + t.x;
	this.flag1.y = this.y + t.y;
	this.flag2 = 0.00000000;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0.40000001;

		if (this.flag2 >= 10.00000000)
		{
			this.flag2 = 10.00000000;
		}

		this.SetSpeed_XY((this.flag1.x - this.x) * 0.10000000, (this.flag1.y - this.y) * 0.10000000);
		local v_ = this.va.Length();

		if (v_ >= this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7.00000000)
		{
			this.flag3 = 0.00000000;
		}

		if (v_ <= 2.00000000)
		{
			this.MS2_Attack(null);
			return;
		}
	};
}

function MS2_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.v <- this.Vector3();

	switch(this.com_difficulty)
	{
	case 1:
		break;

	case 2:
		break;

	case 3:
	case 4:
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.func = [
		function ()
		{
			if (this.flag5.v.x == 0.00000000)
			{
				this.flag5.v.x = 0.02500000;
				this.flag5.v.RotateByDegree(-150);
			}
			else if (this.flag5.v.x > 0.00000000)
			{
				this.flag5.v.x = -0.02500000;
				this.flag5.v.RotateByDegree(20 - this.rand() % 41);
			}
			else
			{
				this.flag5.v.x = 0.02500000;
				this.flag5.v.RotateByDegree(20 - this.rand() % 41);
			}

			this.subState = function ()
			{
				if (this.flag4)
				{
					this.subState = function ()
					{
						this.Vec_Brake(0.10000000);
					};
					return;
				}

				if (this.count % 90 == 89)
				{
					this.func[0].call(this);
				}

				if (this.flag5.v.y < 0 && this.y < this.centerY - 80 || this.flag5.v.y > 0 && this.y > this.centerY + 80)
				{
					this.flag5.v.y *= -1.00000000;
				}

				this.AddSpeed_XY(this.flag5.v.x, this.flag5.v.y);

				if (this.va.Length() > 1.50000000)
				{
					this.va.SetLength(1.50000000);
				}

				this.ConvertTotalSpeed();
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(4045);

			if (this.back_park == null)
			{
				this.back_park = this.SetFreeObjectStencil(640, 360, 1.00000000, this.Occult_Back, {}).weakref();
			}

			local t_ = {};
			t_.scale <- 2.50000000;
			t_.level <- 3;
			this.back_hole.append(this.SetShotStencil(this.x, this.y, this.direction, this.Boss_Shot_MS1_Hole, t_).weakref());
			this.count = 0;
			this.func[0].call(this);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 180)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 240)
				{
					this.M2_Change_Slave(null);
					return;
				}
			};
		}
	];
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Doremy2(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Dream_1()
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

function Slave_Attack_Dream_Hijiri( t )
{
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag3 = 60;
	this.flag4 = t;
	this.flag5 = 180;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5 = 120;
		break;

	case 2:
		this.flag5 = 120;
		break;

	case 3:
	case 4:
		this.flag5 = 120;
		break;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 3.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.25000000);
			this.flag3--;

			if (this.count >= this.flag5 && this.flag3 <= 0)
			{
				this.flag4();
			}
		}
		else
		{
			this.VX_Brake(0.02500000);
		}
	};
}

function Slave_Attack_Dream_VeryShort( t )
{
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = t;
	this.flag5 = 90;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5 = 60;
		break;

	case 2:
		this.flag5 = 60;
		break;

	case 3:
	case 4:
		this.flag5 = 60;
		break;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, 1.00000000);

		if (this.count >= this.flag5)
		{
			this.flag4();
		}
	};
}

function Slave_Attack_Dream_Short( t )
{
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = t;
	this.flag5 = 150;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5 = 120;
		break;

	case 2:
		this.flag5 = 120;
		break;

	case 3:
	case 4:
		this.flag5 = 120;
		break;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, 1.00000000);

		if (this.count >= this.flag5)
		{
			this.flag4();
		}
	};
}

function Slave_Attack_Dream_Middle( t )
{
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = t;
	this.flag5 = 180;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, 1.00000000);

		if (this.count >= this.flag5)
		{
			this.flag4();
		}
	};
}

function Slave_Attack_Dream( t )
{
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = t;
	this.flag5 = 300;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5 = 270;
		break;

	case 2:
		this.flag5 = 240;
		break;

	case 3:
	case 4:
		this.flag5 = 210;
		break;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, 1.00000000);

		if (this.count >= this.flag5)
		{
			this.flag4();
		}
	};
}

function Slave_Smash_Dream( t )
{
	this.LabelClear();
	this.SetMotion(4979, 0);
	this.Warp(this.team.master.x, this.team.master.y);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.PlaySE(900);
	this.direction = this.team.master.direction;
	this.SetSpeed_XY(-3.00000000 * this.direction, -12.50000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.25000000, null, 10.00000000);

		if (this.va.y > 3.00000000 && this.keyTake <= 2)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.25000000, null, 10.00000000);
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	};
}

