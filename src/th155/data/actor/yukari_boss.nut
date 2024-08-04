function Master_Tutorial_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.com_flag3 = 0;
	this.com_flag4 = 0;
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
				if (this.com_flag4 == 0 && this.team.life <= this.team.life_max * 0,50000000.0)
				{
					this.com_flag4 = 1;
					this.Set_Boss_Shield(1);
				}

				if (this.Cancel_Check(10))
				{
					this.MT1_Move();
				}
			};
		}
	};
	return true;
}

function MT1_Move()
{
	if (this.team.life <= this.team.life_max * 0,50000000.0)
	{
		this.MT2_Move();
		return;
	}

	this.LabelClear();
	this.SetMotion(4990, 0);
	this.GetFront();
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = this.Vector3();
	this.flag2 = null;
	this.flag3 = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};

	if (this.direction == 1,00000000.0 && this.x > ::battle.corner_left + 400 || this.direction == -1,00000000.0 && this.x < ::battle.corner_right - 400)
	{
		this.count = -40;
		this.flag1.x = -0,75000000.0 * this.direction;

		if (this.y >= this.target.y)
		{
			this.flag1.y = -0,25000000.0;
		}
		else
		{
			this.flag1.y = 0,25000000.0;
		}

		if (this.y < this.centerY - 125)
		{
			this.flag1.y = 0,25000000.0;
		}

		if (this.y > this.centerY + 125)
		{
			this.flag1.y = -0,25000000.0;
		}
	}
	else
	{
		if (this.rand() % 100 <= 49)
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0,40000001.0;
			}
			else
			{
				this.flag1.y = 0,40000001.0;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0,40000001.0;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0,40000001.0;
			}
		}
		else
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0,25000000.0;
			}
			else
			{
				this.flag1.y = 0,25000000.0;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0,25000000.0;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0,25000000.0;
			}
		}

		this.count = -40;

		if (this.com_flag1 == 0)
		{
			this.flag1.x = -0,50000000.0 * this.direction;
			this.com_flag1 = -1;
		}
		else
		{
			this.flag1.x = 0,50000000.0 * this.com_flag1 * this.direction;
			this.com_flag1 *= -1;
		}

		if (this.direction == 1,00000000.0 && this.x < ::battle.corner_left + 200 || this.direction == -1,00000000.0 && this.x > ::battle.corner_right - 200)
		{
			this.flag1.x = 0,50000000.0 * this.direction;
		}
	}

	this.stateLabel = function ()
	{
		if (this.count >= 0)
		{
			this.flag3 = false;

			if (this.Vec_Brake(0,50000000.0))
			{
				this.MT1_Attack(null);
				return;
			}
		}
		else if (this.va.Length() <= 5,00000000.0)
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

function MT1_Attack( t )
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
	this.flag5.shotNum <- 8;
	this.flag5.shotCount <- 4;
	this.flag5.shotRot <- 0;
	this.flag5.targetRot <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 6;
		break;

	case 2:
		this.flag5.shotCount = 8;
		this.flag5.shotRot = 0,17453292.0;
		break;

	case 3:
		this.flag5.shotCount = 16;
		this.flag5.shotRot = 0,34906584.0;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local r_ = 0;

			if (this.flag5.shotRot > 0)
			{
				r_ = this.flag5.shotRot * this.sin(this.count * 0,08726646.0);
			}

			local pos_ = this.Vector3();
			pos_.x = 100,00000000.0;
			pos_.RotateByRadian(this.flag5.targetRot + r_);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.targetRot + 0,78539813.0 * i + r_;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_Tutorial, t_);
				pos_.RotateByDegree(45);
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag5.targetRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.stateLabel = function ()
			{
				if (this.count % 6 == 1)
				{
					if (this.flag5.shotCount >= 0)
					{
						this.func[0].call(this);
						this.flag5.shotCount--;
					}
				}

				if (this.count == 90)
				{
					this.SetMotion(this.motion, 2);
					return;
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,05000000.0, 1,00000000.0);

				if (this.count == 60)
				{
					this.MT1_Move();
				}
			};
		}
	];
}

function Master_Tutorial_2()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.com_flag3 = 0;
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					this.MT2_Move();
				}
			};
		}
	};
	return true;
}

function MT2_Move()
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.GetFront();
	this.centerStop = -2;
	this.com_flag2++;
	this.com_flag3++;
	this.AjustCenterStop();
	this.flag1 = this.Vector3();

	if (this.com_flag3 % 2 == 1)
	{
		this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellChargeDark, {}, this.weakref()).weakref();
	}
	else
	{
		this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	}

	this.flag3 = true;

	if (this.com_flag2 == 1)
	{
		::battle.Set_BattleMessage(640, 480, "赤チャージエフェクト�\x2560攻撃�\x2550スレイブ�\x2554交代し�\x2500避ける");
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};

	if (this.direction == 1,00000000.0 && this.x > ::battle.corner_left + 400 || this.direction == -1,00000000.0 && this.x < ::battle.corner_right - 400)
	{
		this.count = -40;
		this.flag1.x = -0,75000000.0 * this.direction;

		if (this.y >= this.target.y)
		{
			this.flag1.y = -0,25000000.0;
		}
		else
		{
			this.flag1.y = 0,25000000.0;
		}

		if (this.y < this.centerY - 125)
		{
			this.flag1.y = 0,25000000.0;
		}

		if (this.y > this.centerY + 125)
		{
			this.flag1.y = -0,25000000.0;
		}
	}
	else
	{
		if (this.rand() % 100 <= 49)
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0,40000001.0;
			}
			else
			{
				this.flag1.y = 0,40000001.0;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0,40000001.0;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0,40000001.0;
			}
		}
		else
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0,25000000.0;
			}
			else
			{
				this.flag1.y = 0,25000000.0;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0,25000000.0;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0,25000000.0;
			}
		}

		this.count = -40;

		if (this.com_flag1 == 0)
		{
			this.flag1.x = -0,50000000.0 * this.direction;
			this.com_flag1 = -1;
		}
		else
		{
			this.flag1.x = 0,50000000.0 * this.com_flag1 * this.direction;
			this.com_flag1 *= -1;
		}

		if (this.direction == 1,00000000.0 && this.x < ::battle.corner_left + 200 || this.direction == -1,00000000.0 && this.x > ::battle.corner_right - 200)
		{
			this.flag1.x = 0,50000000.0 * this.direction;
		}
	}

	this.stateLabel = function ()
	{
		if (this.count >= 0)
		{
			this.flag3 = false;

			if (this.Vec_Brake(0,50000000.0))
			{
				if (this.count == 30)
				{
					if (this.com_flag3 % 2 == 1)
					{
						this.MT2_Attack(null);
					}
					else
					{
						this.MT2_AttackB(null);
					}

					return;
				}
			}
		}
		else if (this.va.Length() <= 5,00000000.0)
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

function MT2_Attack( t )
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
	this.flag5.shotNum <- 2;
	this.flag5.shotWay <- 3,14159203.0;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 0,26179937.0;

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
		this.flag5.shotWay = 2,09439468.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 180;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotWay = 1,57079601.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 240;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local pos_ = this.Vector3();
			pos_.x = 100,00000000.0;
			pos_.RotateByRadian(this.flag5.shotRot);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.shotRot;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_Tutorial2, t_);
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
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.Set_BossSpellBariaRate(10);
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count <= this.flag5.shotCount && this.count % this.flag5.shotCycle == 1)
				{
					this.func[0].call(this);
				}

				if (this.count == this.flag5.shotCount)
				{
					this.Set_BossSpellBariaRate(1);
				}

				if (this.count > this.flag5.shotCount)
				{
					this.CenterUpdate(0,05000000.0, 1,00000000.0);
				}

				if (this.count == this.flag5.shotCount + 60)
				{
					this.SetMotion(this.motion, 2);
					return;
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,05000000.0, 1,00000000.0);

				if (this.count == 60)
				{
					this.MT2_Move();
				}
			};
		}
	];
}

function MT2_AttackB( t )
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
	this.flag5.shotNum <- 2;
	this.flag5.shotWay <- 3,14159203.0;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 0,26179937.0;

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
		this.flag5.shotWay = 2,09439468.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 180;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotWay = 1,57079601.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 240;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local pos_ = this.Vector3();
			pos_.x = 100,00000000.0;
			pos_.RotateByRadian(this.flag5.shotRot);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.shotRot;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_Tutorial2B, t_);
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
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count <= this.flag5.shotCount && this.count % this.flag5.shotCycle == 1)
				{
					this.func[0].call(this);
				}

				if (this.count > this.flag5.shotCount)
				{
					this.CenterUpdate(0,05000000.0, 1,00000000.0);
				}

				if (this.count == this.flag5.shotCount + 60)
				{
					this.SetMotion(this.motion, 2);
					return;
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,05000000.0, 1,00000000.0);

				if (this.count == 60)
				{
					this.MT2_Move();
				}
			};
		}
	];
}

function Master_Spell_1B()
{
	this.team.slave.Slave_Yukari_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
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

					this.Master_Spell_1B_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_1B_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4990, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.flag1 = this.Vector3();
	this.flag1.x = -0,40000001.0 * this.direction;
	this.flag1.y = -0,20000000.0;
	this.stateLabel = function ()
	{
		if (this.count <= 15)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.count >= 50)
		{
			this.Vec_Brake(0,25000000.0);
			this.Boss_WalkMotionUpdate(0);
		}
		else
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}

		if (this.count >= 75)
		{
			this.Master_Spell_1B_Attack(null);
			return;
		}
	};
}

function Master_Spell_1B_Move()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4990, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.flag1 = this.Vector3();

	if (this.x < 420)
	{
		this.flag1.x = 0,40000001.0 + this.rand() % 3 * 0,10000000.0;
	}
	else if (this.x > 820)
	{
		this.flag1.x = -0,40000001.0 - this.rand() % 3 * 0,10000000.0;
	}
	else if (this.rand() % 100 <= 49)
	{
		this.flag1.x = 0,40000001.0 + this.rand() % 3 * 0,10000000.0;
	}
	else
	{
		this.flag1.x = -0,40000001.0 - this.rand() % 3 * 0,10000000.0;
	}

	if (this.y < this.centerY - 160)
	{
		this.flag1.y = 0,10000000.0 + this.rand() % 10 * 0,01000000.0;
	}
	else if (this.y < this.centerY - 160)
	{
		this.flag1.y = -0,10000000.0 - this.rand() % 10 * 0,01000000.0;
	}
	else if (this.rand() % 100 <= 49)
	{
		this.flag1.y = 0,10000000.0 + this.rand() % 10 * 0,01000000.0;
	}
	else
	{
		this.flag1.y = -0,10000000.0 - this.rand() % 10 * 0,01000000.0;
	}

	this.stateLabel = function ()
	{
		if (this.count <= 15)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.count >= 90)
		{
			this.Vec_Brake(0,25000000.0);
			this.Boss_WalkMotionUpdate(0);
		}
		else
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}

		if (this.count >= 120)
		{
			this.Master_Spell_1B_Attack(null);
			return;
		}
	};
}

function Master_Spell_1B_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4910, 0);
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCount <- 10;
	this.flag5.shotRotSpeed <- 0,50000000.0 * 0,01745329.0;
	this.flag5.targetRot <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 20;
		break;

	case 2:
		this.flag5.shotCount = 30;
		break;

	case 3:
		this.flag5.shotCount = 40;
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
			this.PlaySE(4430);
			local r_ = 0;
			local pos_ = this.Vector3();
			pos_.x = 100,00000000.0;
			pos_.RotateByRadian(this.flag5.targetRot + r_);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.targetRot + 0,78539813.0 * i;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_Tutorial, t_);
				pos_.RotateByDegree(45);
			}

			this.flag5.shotRotSpeed += 0,50000000.0 * 0,01745329.0;
			this.flag5.targetRot += this.flag5.shotRotSpeed;
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag5.targetRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.stateLabel = function ()
			{
				if (this.count >= 30 && this.count % 6 == 1)
				{
					if (this.flag5.shotCount >= 0)
					{
						this.func[0].call(this);
						this.flag5.shotCount--;
					}
				}

				if (this.flag5.shotCount <= 0)
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
	this.team.current.Slave_Attack_Yukari(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2B()
{
	this.team.slave.Slave_Yukari_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.boss_cpu = function ()
	{
		if (this.Cancel_Check(10))
		{
			this.BossForceCall_Init();

			if (this.team.shield == null)
			{
				this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
			}

			this.Master_Spell_2B_Start();
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					if (this.team.shield == null)
					{
						this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
					}

					this.Master_Spell_2B_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_2B_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4990, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.flag1 = 0,00000000.0;
	this.flag2 = true;
	this.flag3 = 0;
	this.stateLabel = function ()
	{
		this.flag1 += 0,50000000.0;

		if (this.flag1 > 10,00000000.0)
		{
			this.flag1 = 10,00000000.0;
		}

		this.va.x = (640 - this.x) * 0,10000000.0;
		this.va.y = (200 - this.y) * 0,10000000.0;

		if (this.va.Length() >= this.flag1)
		{
			this.va.SetLength(this.flag1);
		}

		if (this.flag1 > 6,00000000.0 && this.va.Length() <= 3,00000000.0)
		{
			this.flag2 = false;
		}

		this.ConvertTotalSpeed();

		if (!this.flag2)
		{
			this.Boss_WalkMotionUpdate(0);
			this.flag3++;

			if (this.flag3 >= 30)
			{
				this.Master_Spell_2B_Attack(null);
			}
		}
		else
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
}

function Master_Spell_2B_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4920, 0);
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag1 = 0,00000000.0;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.shotNum <- 2;
	this.flag5.shotWay <- 3,14159203.0;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 0,26179937.0;

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
		this.flag5.shotWay = 2,09439468.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 180;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotWay = 1,57079601.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 240;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local pos_ = this.Vector3();
			pos_.x = 100,00000000.0;
			pos_.RotateByRadian(this.flag5.shotRot);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.shotRot;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_Tutorial2, t_);
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
		this.flag1 += 0,50000000.0;

		if (this.flag1 > 10,00000000.0)
		{
			this.flag1 = 10,00000000.0;
		}

		this.va.x = (640 - this.x) * 0,10000000.0;
		this.va.y = (200 - this.y) * 0,10000000.0;

		if (this.va.Length() >= this.flag1)
		{
			this.va.SetLength(this.flag1);
		}

		this.ConvertTotalSpeed();
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count % this.flag5.shotCycle == 1)
				{
					this.func[0].call(this);
				}

				if (this.count == this.flag5.shotCount)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == this.flag5.shotCount + 90)
				{
					if (this.target == this.target.team.slave)
					{
						this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_ChangeWave, {});
					}

					this.M2_Change_Slave(t);
					return;
				}

				this.flag1 += 0,50000000.0;

				if (this.flag1 > 10,00000000.0)
				{
					this.flag1 = 10,00000000.0;
				}

				this.va.x = (640 - this.x) * 0,10000000.0;
				this.va.y = (200 - this.y) * 0,10000000.0;

				if (this.va.Length() >= this.flag1)
				{
					this.va.SetLength(this.flag1);
				}

				this.ConvertTotalSpeed();
			};
		}
	];
}

function Master_Spell_2B_FastAttack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4920, 1);
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag1 = 0,00000000.0;

	if (this.target == this.target.team.slave)
	{
		this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_ChangeWave, {});
	}

	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.shotNum <- 2;
	this.flag5.shotWay <- 3,14159203.0;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 0,26179937.0;

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
		this.flag5.shotWay = 2,09439468.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 180;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotWay = 1,57079601.0;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 240;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local pos_ = this.Vector3();
			pos_.x = 100,00000000.0;
			pos_.RotateByRadian(this.flag5.shotRot);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.shotRot;
				this.SetShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_Tutorial2, t_);
				pos_.RotateByRadian(this.flag5.shotWay);
				this.flag5.shotRot += this.flag5.shotWay;
			}

			this.flag5.shotRot += this.flag5.shotRotSpeed;
		},
		function ()
		{
		}
	];
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.flag1 += 0,50000000.0;

		if (this.flag1 > 10,00000000.0)
		{
			this.flag1 = 10,00000000.0;
		}

		this.va.x = (640 - this.x) * 0,10000000.0;
		this.va.y = (200 - this.y) * 0,10000000.0;

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
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count == this.flag5.shotCount + 90)
		{
			if (this.target == this.target.team.slave)
			{
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_ChangeWave, {});
			}

			this.M2_Change_Slave(t);
			return;
		}
	};
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Yukari2(null);
	this.Set_BossSpellBariaRate(10);
}

