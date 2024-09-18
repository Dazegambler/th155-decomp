function Master_Spell_1()
{
	this.team.slave.Slave_Miko_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.com_flag3 = 0;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.MS1_Move(null);
				}
			};
		}
	};
}

function MS1_Move( t )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.GetFront();
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = this.Vector3();
	this.flag2 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag3 = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};

	if (this.direction == 1.00000000 && this.x > ::battle.corner_left + 400 || this.direction == -1.00000000 && this.x < ::battle.corner_right - 400)
	{
		this.count = -40;
		this.flag1.x = -0.75000000 * this.direction;

		if (this.y >= this.target.y)
		{
			this.flag1.y = -0.25000000;
		}
		else
		{
			this.flag1.y = 0.25000000;
		}

		if (this.y < this.centerY - 125)
		{
			this.flag1.y = 0.25000000;
		}

		if (this.y > this.centerY + 125)
		{
			this.flag1.y = -0.25000000;
		}
	}
	else
	{
		if (this.rand() % 100 <= 49)
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0.40000001;
			}
			else
			{
				this.flag1.y = 0.40000001;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0.40000001;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0.40000001;
			}
		}
		else
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0.25000000;
			}
			else
			{
				this.flag1.y = 0.25000000;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0.25000000;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0.25000000;
			}
		}

		this.count = -20;

		if (this.com_flag1 == 0)
		{
			this.flag1.x = -0.50000000 * this.direction;
			this.com_flag1 = -1;
		}
		else
		{
			this.flag1.x = 0.50000000 * this.com_flag1 * this.direction;
			this.com_flag1 *= -1;
		}

		if (this.direction == 1.00000000 && this.x < ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x > ::battle.corner_right - 200)
		{
			this.flag1.x = 0.50000000 * this.direction;
		}
	}

	this.stateLabel = function ()
	{
		if (this.count >= 0)
		{
			this.flag3 = false;

			if (this.Vec_Brake(0.50000000))
			{
				this.MS1_Attack(null);
				return;
			}
		}
		else if (this.va.Length() <= 8.00000000)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.flag3)
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
		else
		{
			this.Boss_WalkMotionUpdate(0);
		}
	};
}

function MS1_Wait( wait_ )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.count = -wait_;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.20000000);
		}

		if (this.keyTake == 1)
		{
			if ((this.target.x - this.x) * this.direction < 0.00000000)
			{
				this.SetMotion(4998, 0);
				this.direction = -this.direction;
			}
		}

		if (this.count >= 0)
		{
			this.MS1_Attack(null);
			return;
		}
	};
}

function MS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.count = 0;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.shotNum <- 10;
	this.flag5.shotCount <- 10;
	this.flag5.shotRot <- 0.17453292;
	this.flag5.targetRot <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 45;
		this.flag5.shotRot = 0.13962634;
		break;

	case 2:
		this.flag5.shotCount = 90;
		this.flag5.shotRot = 0.10471975;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 180;
		this.flag5.shotRot = 0.08726646;
		break;
	}

	this.subState = function ()
	{
		this.SetSpeed_XY((640 - this.flag1.x * this.direction - this.x) * 0.10000000, (this.centerY + 0 + this.flag1.y * 0.50000000 - this.y) * 0.10000000);
	};
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag5.targetRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.stateLabel = function ()
			{
				if (this.count % 2 == 1)
				{
					if (this.flag5.shotNum >= 0)
					{
						this.PlaySE(2050);
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * -0.05235988 + this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_M1_Laser, t_));
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * 0.05235988 - this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_M1_Laser, t_));
						this.flag5.shotNum--;
					}
				}

				if (this.count == 45)
				{
					this.PlaySE(2103);
					this.flag3.Foreach(function ()
					{
						this.func[1].call(this);
					});
					this.M1_Change_Slave(null);
					return;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.MS1_Move(null);
		}
	];
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.S_Lance_Fire(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Miko_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.MS2_Attack(null);
				}
			};
		}
	};
}

function MS2_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.direction = this.com_flag1;
	this.flag1 = this.Vector3();
	this.flag1.x = 640 - 480 * this.direction;
	this.flag1.y = this.centerY - 150 - this.rand() % 25;
	this.flag2 = 0.00000000;
	this.flag3 = true;
	this.flag4 = null;
	this.com_flag1 *= -1.00000000;
	this.subState = function ()
	{
		this.flag2 += 0.50000000;

		if (this.flag2 > 15.00000000)
		{
			this.flag2 = 15.00000000;
		}

		this.va.x = (this.flag1.x - this.x) * 0.10000000;
		this.va.y = (this.flag1.y - this.y) * 0.10000000;
		local v_ = this.va.Length();

		if (v_ > this.flag2)
		{
			this.va.SetLength(this.flag2);
		}

		if (v_ <= 5.00000000)
		{
			this.flag3 = false;
		}

		this.ConvertTotalSpeed();
	};
	this.func = [
		function ()
		{
			this.SetMotion(4920, 0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.25000000);
			};
			this.keyAction = [
				function ()
				{
					this.count = 0;
					local t_ = {};
					t_.rot <- 60 * 0.01745329;
					this.flag4 = this.SetShot(this.x, ::battle.scroll_top - 400, this.direction, this.Boss_Shot_M2_Light, t_).weakref();
					this.stateLabel = function ()
					{
						this.Vec_Brake(0.25000000);

						if (this.count == 240)
						{
							if (this.flag4)
							{
								this.flag4.func[0].call(this.flag4);
							}

							this.flag4 = null;
						}

						if (this.count >= 300)
						{
							this.M2_Change_Slave(null);
							return;
						}
					};
				}
			];
		},
		function ()
		{
			this.SetMotion(4920, 3);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 2.00000000);

				if (this.count >= 90)
				{
					this.MS2_Attack(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();

		if (this.flag3)
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
		else
		{
			this.Boss_WalkMotionUpdate(0);
		}

		if (this.flag3 == false && this.va.Length() <= 1.00000000)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [];
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.S_FallKick_Attack(this.direction);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3()
{
	this.team.slave.Slave_Miko_3();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.com_flag3 = 0;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.MS3_MoveFirst(null);
				}
			};
		}
	};
}

function MS3_MoveFirst( t )
{
	this.com_flag2 = 2;
	this.MS3_Move(t);
}

function MS3_Move( t )
{
	this.LabelClear();
	this.HitReset();
	this.GetFront();
	this.PlaySE(801);
	this.SetMotion(4992, 0);
	this.flag5 = {};
	this.flag5.moveVec <- this.Vector3();
	this.flag5.moveVec.x = -this.direction * 0.50000000;

	if (this.x > ::battle.corner_right - 300)
	{
		this.flag5.moveVec.x = -0.75000000;
	}

	if (this.x < ::battle.corner_left + 300)
	{
		this.flag5.moveVec.x = 0.75000000;
	}

	this.flag5.moveVec.RotateByDegree(-45 + this.rand() % 91);

	if (this.y < this.centerY - 150 && this.flag5.moveVec.y < 0 || this.y > this.centerY + 150 && this.flag5.moveVec.y > 0)
	{
		this.flag5.moveVec.y *= -1.00000000;
	}

	if (this.flag5.moveVec.y < 0)
	{
		this.centerStop = -2;
	}

	if (this.flag5.moveVec.y > 0)
	{
		this.centerStop = 2;
	}

	this.count = 0;
	this.flag1 = false;
	this.subState = function ()
	{
		if (this.va.Length() < 6.00000000)
		{
			this.AddSpeed_XY(this.flag5.moveVec.x, this.flag5.moveVec.y);
		}

		if (this.count >= 25)
		{
			this.count = 0;
			this.flag1 = true;
			this.subState = function ()
			{
				if (this.Vec_Brake(0.25000000, 1.00000000))
				{
					this.AjustCenterStop();
					this.subState = function ()
					{
						this.CenterUpdate(0.20000000, 3.00000000);

						if (this.centerStop * this.centerStop <= 0)
						{
							this.VX_Brake(0.15000001);
						}

						if (this.count >= 25 && this.target.team.life > 0)
						{
							this.com_flag2--;

							if (this.com_flag2 >= 1)
							{
								this.MS3_Move(null);
								return true;
							}
							else
							{
								this.MS3_Attack2(null);
								return true;
							}
						}
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		if (this.flag1)
		{
			this.Boss_WalkMotionUpdate(0.00000000);
		}
		else
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
	return true;
}

function MS3_Attack( t )
{
	if (!this.Cancel_Check(10, 0, 0))
	{
		return false;
	}

	this.MS3_Attack2(t);
	return true;
}

function MS3_Attack2( t )
{
	this.com_flag3++;

	if (this.com_flag3 >= 3)
	{
		this.com_flag3 = 0;
		this.MS3_Attack3(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(4942, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.flag1 = null;
	};
	this.PlaySE(2160);
	this.flag1 = null;
	this.flag2 = this.Vector3();
	this.flag2.x = 100.00000000;
	this.flag3 = 0;
	this.flag4 = -0.52359873;
	this.flag5 = {};
	this.flag5.tRot <- 0.00000000;
	this.flag5.v <- 15.00000000;
	this.GetFront();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.Vec_Brake(0.50000000, 1.00000000))
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 0.50000000);

				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0.15000001);
				}
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.GetFront();
			this.count = 0;
			this.PlaySE(2161);
			this.flag5.tRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag2.RotateByRadian(this.flag5.tRot);
			this.flag3 = 3 + this.com_difficulty;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);
				this.Vec_Brake(0.50000000, 0.00000000);

				if (this.flag3 > 0 && this.count % 4 == 1)
				{
					this.flag3--;
					local t_ = {};
					t_.v <- this.flag5.v;
					t_.rot <- this.flag5.tRot + this.flag4;
					this.SetShot(this.x + this.flag2.x * this.direction, this.y + this.flag2.y, this.direction, this.Boss_Shot_M3, t_);
					this.flag4 += 11.25000000 * 0.01745329;
					this.flag2.RotateByRadian(11.25000000 * 0.01745329);
					this.flag5.v -= 0.75000000;

					if (this.flag3 == 0)
					{
						this.lavelClearEvent = null;

						if (this.flag1)
						{
							this.flag1.func();
						}

						this.flag1 = null;
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.10000000, null);
							this.Vec_Brake(0.50000000, 0.00000000);
						};
					}
				}
			};
		},
		null,
		function ()
		{
			this.lavelClearEvent = null;

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.flag1 = null;
		},
		function ()
		{
			this.MS3_MoveFirst(null);
			return;
		}
	];
	return true;
}

function MS3_Attack3( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4943, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.flag1 = null;
	};
	this.PlaySE(2160);
	this.flag1 = null;
	this.flag2 = this.Vector3();
	this.flag2.x = 100.00000000;
	this.flag3 = 0;
	this.flag4 = -1.04719746;
	this.flag5 = {};
	this.flag5.tRot <- 0.00000000;
	this.flag5.charge <- null;
	this.flag5.v <- 15.00000000;
	this.flag1 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};
	this.GetFront();
	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.Vec_Brake(0.50000000, 1.00000000))
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 0.50000000);

				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0.15000001);
				}
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.GetFront();
			this.count = 0;
			this.PlaySE(2161);
			this.flag5.tRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag2.RotateByRadian(this.flag5.tRot);
			this.flag3 = 3 * (this.com_difficulty + 1);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);
				this.Vec_Brake(0.50000000, 0.00000000);

				if (this.flag3 > 0 && this.count % 4 == 1)
				{
					this.flag3--;
					local t_ = {};
					t_.v <- this.flag5.v;
					t_.rot <- this.flag5.tRot + this.flag4;
					this.SetShot(this.x + this.flag2.x * this.direction, this.y + this.flag2.y, this.direction, this.Boss_Shot_M3, t_);
					local t_ = {};
					t_.v <- 2.50000000 + this.rand() % 55 * 0.10000000;
					t_.rot <- this.flag5.tRot + this.flag4 + (15 - this.rand() % 31) * 0.01745329;
					this.SetShot(this.x + this.flag2.x * this.direction, this.y + this.flag2.y, this.direction, this.Boss_Shot_M3_Mini, t_);
					local t_ = {};
					t_.v <- 2.50000000 + this.rand() % 55 * 0.10000000;
					t_.rot <- this.flag5.tRot + this.flag4 + (15 - this.rand() % 31) * 0.01745329;
					this.SetShot(this.x + this.flag2.x * this.direction, this.y + this.flag2.y, this.direction, this.Boss_Shot_M3_Mini, t_);
					this.flag4 += 0.52359873;
					this.flag2.RotateByRadian(11.25000000 * 0.01745329);
					this.flag5.v -= 0.75000000;

					if (this.flag3 == 0)
					{
						this.lavelClearEvent = null;

						if (this.flag1)
						{
							this.flag1.func();
						}

						this.flag1 = null;
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.10000000, null);
							this.Vec_Brake(0.50000000, 0.00000000);
						};
					}
				}
			};
		},
		null,
		function ()
		{
			this.lavelClearEvent = null;

			if (this.flag1)
			{
				this.flag1.func();
			}

			this.flag1 = null;
			this.M3_Change_Slave(null);
		}
	];
	return true;
}

function M3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Miko3(this.direction);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_D1()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.com_flag3 = 0;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.DS1_Move(null);
				}
			};
		}
	};
}

function DS1_Move( t )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.GetFront();
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = this.Vector3();
	this.flag2 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag3 = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};

	if (this.direction == 1.00000000 && this.x > ::battle.corner_left + 400 || this.direction == -1.00000000 && this.x < ::battle.corner_right - 400)
	{
		this.count = -40;
		this.flag1.x = -0.75000000 * this.direction;

		if (this.y >= this.target.y)
		{
			this.flag1.y = -0.50000000;
		}
		else
		{
			this.flag1.y = 0.25000000;
		}

		if (this.y < this.centerY - 125)
		{
			this.flag1.y = 0.50000000;
		}

		if (this.y > this.centerY + 125)
		{
			this.flag1.y = -0.50000000;
		}
	}
	else
	{
		if (this.rand() % 100 <= 49)
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0.50000000;
			}
			else
			{
				this.flag1.y = 0.50000000;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0.75000000;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0.75000000;
			}
		}
		else
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0.50000000;
			}
			else
			{
				this.flag1.y = 0.50000000;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0.75000000;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0.75000000;
			}
		}

		this.count = -20;

		if (this.com_flag1 == 0)
		{
			this.flag1.x = -0.50000000 * this.direction;
			this.com_flag1 = -1;
		}
		else
		{
			this.flag1.x = 0.50000000 * this.com_flag1 * this.direction;
			this.com_flag1 *= -1;
		}

		if (this.direction == 1.00000000 && this.x < ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x > ::battle.corner_right - 200)
		{
			this.flag1.x = 0.50000000 * this.direction;
		}
	}

	this.stateLabel = function ()
	{
		if (this.count >= 0)
		{
			this.flag3 = false;

			if (this.Vec_Brake(0.50000000))
			{
				this.DS1_Attack(null);
				return;
			}
		}
		else if (this.va.Length() <= 8.00000000)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.flag3)
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
		else
		{
			this.Boss_WalkMotionUpdate(0);
		}
	};
}

function DS1_Wait( wait_ )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.count = -wait_;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.20000000);
		}

		if (this.keyTake == 1)
		{
			if ((this.target.x - this.x) * this.direction < 0.00000000)
			{
				this.SetMotion(4998, 0);
				this.direction = -this.direction;
			}
		}

		if (this.count >= 0)
		{
			this.DS1_Attack(null);
			return;
		}
	};
}

function DS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.count = 0;
	this.com_flag2++;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.shotNum <- 6 + this.com_flag2;
	this.flag5.shotCount <- 180;
	this.flag5.shotRot <- 0.17453292;
	this.flag5.targetRot <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 180;
		this.flag5.shotRot = 0.13962634;
		break;

	case 2:
		this.flag5.shotCount = 180;
		this.flag5.shotRot = 0.10471975;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 180;
		this.flag5.shotRot = 0.08726646;
		break;
	}

	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag5.targetRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.stateLabel = function ()
			{
				if (this.count % 2 == 1)
				{
					if (this.flag5.shotNum >= 0)
					{
						this.PlaySE(2050);
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * -0.05235988 + this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_D1_Laser, t_));
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * 0.05235988 - this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_D1_Laser, t_));
						this.flag5.shotNum--;
					}
				}

				if (this.count == 45)
				{
					this.PlaySE(2103);
					this.flag3.Foreach(function ()
					{
						this.func[1].call(this);
					});
					this.SetMotion(this.motion, 4);
					return;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			if (this.com_flag2 >= 3)
			{
				this.com_flag2 = 0;
				this.DS1_Attack2(null);
				return;
			}

			this.DS1_Move(null);
		}
	];
}

function DS1_Attack2( t )
{
	this.LabelClear();
	this.SetMotion(4911, 0);
	this.HitReset();
	this.armor = -1;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.count = 0;
	this.com_flag3++;
	this.flag1 = 640 - 550 * this.direction;
	this.flag2 = 0.02500000;
	this.flag3 = 0.00000000;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;

		if (this.flag5.blade)
		{
			this.flag5.blade.func[0].call(this.flag5.blade);
		}

		this.flag5.blade = null;

		if (this.flag5.line)
		{
			this.flag5.line.func[0].call(this.flag5.line);
		}

		this.flag5.line = null;
	};
	this.flag5 = {};
	this.flag5.speed <- 15.00000000;
	this.flag5.charge <- 90;
	this.flag5.blade <- null;
	this.flag5.blade_wait <- 1;
	this.flag5.blade_cycle <- 1;
	this.flag5.line <- this.SetFreeObject(this.x, this.y - 25, this.direction, this.Boss_Shot_D1_PreBlade, {}).weakref();

	switch(this.com_difficulty)
	{
	case 0:
		this.flag2 = 0.01000000;
		this.flag5.speed = 22.50000000;
		break;

	case 1:
		this.flag2 = 0.02500000;
		this.flag5.speed = 35.00000000;
		this.flag5.blade_wait = 15;
		break;

	case 2:
		this.flag2 = 0.03750000;
		this.flag5.speed = 40.00000000;
		this.flag5.blade_wait = 15;
		break;

	case 3:
	case 4:
		this.flag2 = 0.05000000;
		this.flag5.speed = 40.00000000;
		this.flag5.blade_wait = 15;
		this.flag5.blade_cycle = 2;
		break;
	}

	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(2.50000000, 1.00000000 * this.direction);

				if (this.count == this.flag5.blade_wait)
				{
					if (this.flag5.blade)
					{
						this.flag5.blade.func[0].call(this.flag5.blade);
					}

					this.flag5.blade = null;
				}

				if (this.count == 60)
				{
					if (this.com_flag3 >= this.flag5.blade_cycle)
					{
						this.com_flag3 = 0;
						this.DS1_Change_Slave(null);
						return;
					}
					else
					{
						this.SetMotion(this.motion, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag3 += 0.50000000;
		this.SetSpeed_XY((this.flag1 - this.x) * 0.10000000, (this.target.y - this.y) * this.flag2);

		if (this.fabs(this.va.x) > this.flag3)
		{
			this.va.x = this.va.x >= 0.00000000 ? this.flag3 : -this.flag3;
		}

		if (this.count == this.flag5.charge)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
		},
		null,
		function ()
		{
			if (this.flag5.line)
			{
				this.flag5.line.func[0].call(this.flag5.line);
			}

			this.flag5.line = null;
			this.PlaySE(2133);
			::camera.Shake(6.00000000);

			for( local i = 0; i < 6; i++ )
			{
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_S4_BladeFlash, {});
			}

			this.flag5.blade = this.SetShot(this.x + 50 * this.direction, this.y - 25, this.direction, this.Boss_Shot_D1_Blade, {}).weakref();
			this.SetSpeed_XY(this.flag5.speed * this.direction, 0.00000000);

			if (this.direction == 1.00000000)
			{
				this.stateLabel = function ()
				{
					if (this.x > ::battle.scroll_right - 600)
					{
						this.func[1].call(this);
					}
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					if (this.x < ::battle.scroll_left + 600)
					{
						this.func[1].call(this);
					}
				};
			}
		},
		null,
		null,
		function ()
		{
			this.DS1_Move(null);
		}
	];
}

function DS1_Change_Slave( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.team.slave.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream_Short(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.DS1_Move(null);
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Slave_Hijiri_3()
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

function Slave_Attack_Hijiri3()
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.count = 0;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.shotNum <- 10;
	this.flag5.shotCount <- 10;
	this.flag5.shotRot <- 0.17453292;
	this.flag5.targetRot <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 60;
		this.flag5.shotRot = 0.13962634;
		break;

	case 2:
		this.flag5.shotCount = 75;
		this.flag5.shotRot = 0.10471975;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 90;
		this.flag5.shotRot = 0.08726646;
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag5.targetRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.02500000, 6.00000000);

				if (this.count % 2 == 1)
				{
					if (this.flag5.shotNum >= 0)
					{
						this.PlaySE(2050);
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * -0.05235988 + this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_S3_Laser, t_));
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * 0.05235988 - this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_S3_Laser, t_));
						this.flag5.shotNum--;
					}
				}

				if (this.count == 45)
				{
					this.PlaySE(2103);
					this.flag3.Foreach(function ()
					{
						this.func[1].call(this);
					});
				}

				if (this.count == 255)
				{
					this.Change_Master_Hijiri3(null);
					return;
				}
			};
		}
	];
}

function Change_Master_Hijiri3( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_3_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Hijiri_4()
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

function Slave_Attack_Hijiri4( t )
{
	this.LabelClear();
	this.SetMotion(4912, 0);
	this.GetFront();
	this.HitReset();
	this.armor = -1;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 640 - 550 * this.direction;
	this.flag2 = 0.02500000;
	this.flag3 = 0.00000000;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;

		if (this.flag5.blade)
		{
			this.flag5.blade.func[0].call(this.flag5.blade);
		}

		this.flag5.blade = null;
	};
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = this.x - 200 * this.direction;
	this.flag5.pos.y = this.target.y;
	this.flag5.speed <- 30.00000000;
	this.flag5.charge <- 60;
	this.flag5.blade <- null;

	switch(this.com_difficulty)
	{
	case 0:
		this.flag2 = 0.01000000;
		this.flag5.speed = 10.00000000;
		break;

	case 1:
		this.flag5.charge = 45;
		this.flag2 = 0.02500000;
		this.flag5.speed = 15.00000000;
		break;

	case 2:
		this.flag5.charge = 30;
		this.flag2 = 0.03750000;
		this.flag5.speed = 20.00000000;
		break;

	case 3:
	case 4:
		this.flag5.charge = 30;
		this.flag2 = 0.05000000;
		this.flag5.speed = 25.00000000;
		break;
	}

	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
			};
		},
		function ()
		{
			this.count = 0;

			if (this.flag5.blade)
			{
				this.flag5.blade.func[0].call(this.flag5.blade);
			}

			this.flag5.blade = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(2.50000000, 1.00000000 * this.direction);

				if (this.count == 60)
				{
					this.Change_Master_Hijiri4(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0.10000000, (this.flag5.pos.y - this.y) * 0.10000000);

		if (this.count == this.flag5.charge)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
		},
		null,
		function ()
		{
			this.PlaySE(2133);
			::camera.Shake(6.00000000);
			this.flag5.blade = this.SetShot(this.x + 50 * this.direction, this.y - 25, this.direction, this.Boss_Shot_S4_Blade, {}).weakref();
			this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
			this.count = 0;

			for( local i = 0; i < 6; i++ )
			{
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_S4_BladeFlash, {});
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000, 1.00000000 * this.direction);

				if (this.count == 150)
				{
					this.Change_Master_Hijiri4(null);
					return;
				}
			};
		}
	];
}

function Change_Master_Hijiri4( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS4_Attack_Under(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Hijiri_5()
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

function Slave_Attack_Hijiri5( t )
{
	this.LabelClear();
	::camera.lock = false;
	::camera.auto_zoom_limit = 1.04999995;
	::camera.lock = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		::camera.lock = false;
		::camera.auto_zoom_limit = 2.00000000;
	};
	this.GetFront();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0.00000000;
	this.flag2 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.charge <- 180;
	this.flag5.wait <- 210;
	this.flag5.shotRot <- 0.00000000;
	this.flag5.shotRotAdd <- 3.14159203;
	this.flag5.shotRotSpeed <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.charge = 90;
		break;

	case 2:
		this.flag5.charge = 90;
		break;

	case 3:
		this.flag5.charge = 90;
		break;

	case 4:
		this.flag5.charge = 90;
		break;
	}

	this.stateLabel = function ()
	{
		if (this.count > this.flag5.charge)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2120);
			this.count = 0;
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			local t_ = {};
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_S5_Back, t_);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.subState = function ()
			{
				this.flag5.shotRotAdd -= 0.10000000 * 0.01745329;

				if (this.count == 45)
				{
					this.PlaySE(2121);
					this.subState = function ()
					{
						this.flag5.shotRotSpeed += 0.25000000 * 0.01745329;
						local r_ = this.flag5.shotRotAdd * 0.07500000;

						if (r_ > this.flag5.shotRotSpeed)
						{
							r_ = this.flag5.shotRotSpeed;
						}

						this.flag5.shotRotAdd -= r_;

						if (this.flag5.shotRotAdd <= 0.26179937)
						{
							this.subState = function ()
							{
								this.flag5.shotRotAdd *= 0.98500001;
							};
						}
					};
				}
			};
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count <= this.flag5.wait - 60 && this.count % 5 == 1)
				{
					local t_ = {};
					t_.rot <- this.flag5.shotRot + this.flag5.shotRotAdd;
					this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_S5_Ray, t_);
					local t_ = {};
					t_.rot <- this.flag5.shotRot - this.flag5.shotRotAdd;
					this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_S5_Ray, t_);
				}

				if (this.count > this.flag5.wait)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
					return;
				}
			};
		},
		null,
		null,
		function ()
		{
			this.Change_Master_Hijiri5(null);
		}
	];
}

function Change_Master_Hijiri5( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS5_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

