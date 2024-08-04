function BreakDishCount( t_ = 1 )
{
}

function Master_Spell_1()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.team.slave.Slave_Futo_1();
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
	return true;
}

function Master_Spell_1_Start( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4940, 0);
	this.flag5 = 0;
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -12,50000000.0);
			this.flag5 = this.y;
			this.subState[0] = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

				if (this.va.y > 0,00000000.0 && this.y >= this.flag5)
				{
					this.SetMotion(this.motion, 5);
					this.SetSpeed_XY(this.va.x, 2,00000000.0);
					this.subState[0] = function ()
					{
						this.VX_Brake(0,50000000.0);
						this.VY_Brake(0,40000001.0);
					};
				}
			};
		},
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.Master_Spell_1_Attack(null);
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4940, 7);
	this.flag3 = 0;
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
	this.flag5.shotNum <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 18 * 0,01745329.0;
	this.flag5.changeCycle <- 4;
	this.flag5.moveCount <- 0;
	this.flag5.moveCycle <- 120;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.hv <- 0,00000000.0;
	this.flag5.vec <- this.Vector3();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 9;
		this.flag5.shotRotSpeed = 0,17453292.0;
		break;

	case 2:
		this.flag5.shotNum = 11;
		this.flag5.moveCycle = 105;
		this.flag5.shotRotSpeed = 0,13962634.0;
		break;

	case 3:
		this.flag5.shotNum = 12;
		this.flag5.moveCycle = 100;
		this.flag5.shotRotSpeed = 7 * 0,01745329.0;
		break;

	case 4:
		this.flag5.shotNum = 15;
		this.flag5.moveCycle = 90;
		this.flag5.shotRotSpeed = 0,10471975.0;
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
			this.flag5.vec.x = 10 + this.rand() % 6;
			this.flag5.vec.y = -5 - this.rand() % 6;

			if (this.y < this.centerY)
			{
				this.flag5.vec.y *= -1;
			}

			if (this.x > ::battle.corner_left + 480 && this.direction == 1,00000000.0 || this.x < ::battle.corner_right - 480 && this.direction == -1,00000000.0)
			{
				this.flag5.vec.x *= 0,25000000.0;
			}

			if (this.x > ::battle.corner_right - 250 && this.direction == 1,00000000.0 || this.x < ::battle.corner_left + 250 && this.direction == -1,00000000.0)
			{
				this.flag5.vec.x *= 3,00000000.0;
			}

			this.flag5.vec.Normalize();
			this.flag5.hv = 0,00000000.0;
			this.flag5.moveV = 0,00000000.0;
			this.flag5.moveCount = 0;
			this.func[1].call(this);
			this.subState[0] = function ()
			{
				this.flag5.moveCount++;
				this.flag5.hv -= 0,20000000.0;

				if (this.flag5.hv < -2,50000000.0)
				{
					this.flag5.hv = -2,50000000.0;
				}

				if (this.flag5.moveCount <= 60)
				{
					this.flag5.moveV += 0,50000000.0;

					if (this.flag5.moveV > 6,50000000.0)
					{
						this.flag5.moveV = 6,50000000.0;
					}
				}
				else
				{
					this.flag5.moveV -= 0,25000000.0;

					if (this.flag5.moveV <= 1,50000000.0)
					{
						this.flag5.moveV = 1,50000000.0;
					}
				}

				this.SetSpeed_XY((this.flag5.hv + this.flag5.vec.x * this.flag5.moveV) * this.direction, this.flag5.vec.y * this.flag5.moveV);

				if (this.flag5.moveCount >= this.flag5.moveCycle)
				{
					this.flag5.changeCycle--;

					if (this.flag5.changeCycle <= 0)
					{
						this.M1_Change_Slave(null);
						return true;
					}

					if (this.flag5.changeCycle == 1)
					{
						this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
					}

					this.flag5.vec.x = 10 + this.rand() % 6;
					this.flag5.vec.y = -5 - this.rand() % 6;

					if (this.y < this.centerY)
					{
						this.flag5.vec.y *= -1;
					}

					if (this.x > ::battle.corner_left + 480 && this.direction == 1,00000000.0 || this.x < ::battle.corner_right - 480 && this.direction == -1,00000000.0)
					{
						this.flag5.vec.x *= 0,25000000.0;
					}

					if (this.x > ::battle.corner_right - 250 && this.direction == -1,00000000.0 || this.x < ::battle.corner_left + 250 && this.direction == 1,00000000.0)
					{
						this.flag5.vec.x *= 2,00000000.0;
					}

					if (this.x > this.target.x && this.direction == 1,00000000.0 || this.x < this.target.x && this.direction == -1,00000000.0)
					{
						this.flag5.vec.x *= -0,50000000.0;
					}

					this.flag5.vec.Normalize();
					this.flag5.moveV = 0,00000000.0;
					this.flag5.moveCount = 0;
					this.func[1].call(this);
				}
			};
		},
		function ()
		{
			this.flag3 = this.flag5.shotNum;
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag3 > 0 && this.flag5.shotCount % 5 == 1)
				{
					this.flag5.shotRot += this.flag5.shotRotSpeed;
					this.flag3--;
					this.PlaySE(1822);
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS1, t_);
				}
			};
		}
	];
	this.keyAction = [
		null,
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.func[0].call(this);
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState[0].call(this))
		{
			return;
		}

		this.subState[1].call(this);
	};
	this.func[0].call(this);
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Futo(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Kokoro_1()
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

function Slave_Attack_Kokoro( t )
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
		this.flag5.wait = 120;
		break;

	case 2:
		this.flag5.wait = 90;
		break;

	case 3:
	case 4:
		this.flag5.wait = 90;
		break;
	}

	this.keyAction = [
		null,
		null,
		function ()
		{
			this.team.master.shot_actor.Foreach(function ()
			{
				this.team.slave.SetShot(this.x, this.y, this.direction, this.team.slave.Boss_Shot_SL1, {});
				this.ReleaseActor();
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
					this.Slave_Move_Kokoro(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Slave_Move_Kokoro( t )
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
			this.Change_Master_Kokoro(null);
			return;
		}
	};
}

function Change_Master_Kokoro( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Ichirin_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.resist_baria = true;
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
	case 4:
		this.flag5.wait = 30;
		break;
	}

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
					this.Slave_Move_Ichirin(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Slave_Move_Ichirin( t )
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

function Slave_Miko_3()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.resist_baria = true;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Miko3( t )
{
	this.LabelClear();
	this.SetMotion(4950, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 6;
	this.flag5.shotNum <- 4;
	this.flag5.shotRot2 <- 0,17453292.0;
	this.flag5.wait <- 120;
	this.flag5.shotRot <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.wait = 120;
		break;

	case 2:
		this.flag5.wait = 120;
		break;

	case 3:
	case 4:
		this.flag5.wait = 120;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.team.master.shot_actor.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.GetFront();
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag5.shotNum > 0 && this.count % this.flag5.shotCycle == 1)
				{
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					t_.rot2 <- this.flag5.shotNum * 0,34906584.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_SL3, t_);
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					t_.rot2 <- -this.flag5.shotNum * 0,34906584.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_SL3, t_);
					this.flag5.shotNum--;
					this.flag5.shotRot2 += 0,26179937.0;
				}

				if (this.count == 60)
				{
					this.SetMotion(this.motion, 2);
				}
			};
		},
		null,
		function ()
		{
			this.team.master.shot_actor.Foreach(function ( rot_ = this.flag5.shotRot, dir_ = this.direction )
			{
				this.func[2].call(this, rot_, dir_);
			});
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
					this.Change_Master_Miko3(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Slave_Move_Miko3( t )
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
			this.Change_Master_Miko3(null);
			return;
		}
	};
}

function Change_Master_Miko3( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS3_MoveFirst(null);
	this.Set_BossSpellBariaRate(1);
}

