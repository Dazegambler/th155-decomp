function Master_Tutorial_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.boss_cpu = function ()
	{
		if (this.Cancel_Check(10))
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.com_flag2 == 1)
				{
					this.com_flag2 = 0;
					this.Master_Tutorial_1_BackStep(null);
				}
				else
				{
					local r_ = this.rand() % 3;

					switch(r_)
					{
					case 1:
						this.Master_Tutorial_1_SlideUpper(null);
						break;

					case 2:
						this.Master_Tutorial_1_SlideUnder(null);
						break;

					default:
						this.Master_Tutorial_1_BackStep(null);
						break;
					}
				}
			}
			else
			{
				this.Master_Tutorial_1_BackStep(null);
			}
		}
	};
	return true;
}

function Master_Tutorial_1_Com()
{
	if (this.Cancel_Check(10))
	{
		this.Master_Tutorial_1_SlideUpper(null);
	}
}

function Master_Tutorial_1_BackStep( t )
{
	this.GetFront();

	if (this.direction == 1.00000000 && this.x <= ::battle.corner_left + 400 || this.direction == -1.00000000 && this.x >= ::battle.corner_right - 400)
	{
		this.Master_Tutorial_1_WideShot(t);
		return;
	}

	this.LabelClear();
	this.SetMotion(4986, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.armor = -1;
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 3.00000000);

				if (this.count >= 10)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Tutorial_1_WideShot(t);
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Master_Tutorial_1_SlideUpper( t )
{
	this.LabelClear();
	this.SetMotion(4983, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.armor = -1;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.centerStop = -2;

			if (this.direction == 1.00000000 && this.x <= ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x >= ::battle.corner_right - 200)
			{
				this.SetSpeed_XY(7.00000000 * this.direction, -15.50000000);
			}
			else
			{
				this.SetSpeed_XY(-5.00000000 * this.direction, -15.50000000);
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 0.60000002 : 0.25000000);
				this.Boss_SlideMotionUpdate(-1.00000000);
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Tutorial_1_UnderShot(t);
		}
	];
	return true;
}

function Master_Tutorial_1_SlideUnder( t )
{
	this.LabelClear();
	this.SetMotion(4984, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.armor = -1;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.centerStop = 2;

			if (this.direction == 1.00000000 && this.x <= ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x >= ::battle.corner_right - 200)
			{
				this.SetSpeed_XY(7.00000000 * this.direction, 15.50000000);
			}
			else
			{
				this.SetSpeed_XY(-5.00000000 * this.direction, 15.50000000);
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.va.y > 0.00000000 ? -0.60000002 : -0.25000000);
				this.Boss_SlideMotionUpdate(1.00000000);
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Tutorial_1_UpperShot(t);
		}
	];
	return true;
}

function Master_Tutorial_1_WideShot( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.flag1 = -5;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotNum <- 1;
	this.flag5.shotRot <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.charge = 90;
		this.flag5.shotNum = 4;
		break;

	case 2:
		this.flag5.charge = 60;
		this.flag5.shotNum = 10;
		break;

	case 3:
	case 4:
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000, -2.00000000 * this.direction);
		this.CenterUpdate(0.10000000, 3.00000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
				this.CenterUpdate(0.10000000, 3.00000000);

				if (this.count == this.flag5.charge)
				{
					this.SetMotion(4910, 2);

					if (this.flag2)
					{
						this.flag2.func();
					}

					this.flag2 = null;
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.PlaySE(1250);

						for( local i = 0; i < 360; i = i + 40 )
						{
							local t_ = {};
							t_.rot <- (i + this.flag5.shotRot) * 0.01745329;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Tutorial, t_);
						}

						this.flag5.shotRot += 5;
						this.flag5.shotNum--;
					}
					else
					{
						this.armor = 0;
						this.SetMotion(4910, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 3.00000000);
			};
		},
		function ()
		{
			if (this.com_flag1 == -1.00000000)
			{
				this.Master_Tutorial_1_SlideUpper(null);
			}
			else
			{
				this.Master_Tutorial_1_SlideUnder(null);
			}

			this.com_flag1 *= -1.00000000;
		}
	];
	return true;
}

function Master_Tutorial_1_UnderShot( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.flag1 = -5;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotNum <- 1;
	this.flag5.shotRot <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.charge = 90;
		this.flag5.shotNum = 4;
		break;

	case 2:
		this.flag5.charge = 60;
		this.flag5.shotNum = 10;
		break;

	case 3:
	case 4:
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.GetFront();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					if (this.flag2)
					{
						this.flag2.func();
					}

					this.flag2 = null;
					this.SetMotion(4910, 2);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.PlaySE(1250);

						for( local i = 0; i < 360; i = i + 40 )
						{
							local t_ = {};
							t_.rot <- (i + this.flag5.shotRot) * 0.01745329;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Tutorial, t_);
						}

						this.flag5.shotRot += 5;
						this.flag5.shotNum--;
					}
					else
					{
						this.armor = 0;
						this.SetMotion(4910, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 10.00000000);
			};
		},
		function ()
		{
			this.LabelClear();
			this.SetMotion(4983, 3);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 10.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.50000000);
					};
					this.keyAction = function ()
					{
						this.LabelClear();
						this.count = 0;
						this.SetMotion(4980, 0);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(0.50000000);

							if (this.count == 30)
							{
								this.Master_Tutorial_1_BackStep(null);
							}
						};
					};
				}
			};
		}
	];
	return true;
}

function Master_Tutorial_1_UpperShot( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.flag1 = 5;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotNum <- 1;
	this.flag5.shotRot <- 0.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 4;
		this.flag5.charge = 90;
		break;

	case 2:
		this.flag5.charge = 60;
		this.flag5.shotNum = 10;
		break;

	case 3:
	case 4:
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					if (this.flag2)
					{
						this.flag2.func();
					}

					this.flag2 = null;
					this.SetMotion(4910, 2);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.PlaySE(1250);

						for( local i = 0; i < 360; i = i + 40 )
						{
							local t_ = {};
							t_.rot <- (i + this.flag5.shotRot) * 0.01745329;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Tutorial, t_);
						}

						this.flag5.shotRot += 5;
						this.flag5.shotNum--;
					}
					else
					{
						this.armor = 0;
						this.SetMotion(4910, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 10.00000000);
			};
		},
		function ()
		{
			this.LabelClear();
			this.SetMotion(4984, 3);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 10.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.50000000);
					};
					this.keyAction = function ()
					{
						this.LabelClear();
						this.count = 0;
						this.SetMotion(4980, 0);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(0.50000000);

							if (this.count == 30)
							{
								this.Master_Tutorial_1_BackStep(null);
							}
						};
					};
				}
			};
		}
	];
	return true;
}

function Master_Tutorial_2()
{
	this.team.slave.Slave_Tutorial_2();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
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

					this.MT2_Position_Change(null);
				}
			};
		}
	};
}

function MT2_Position_Change( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
	{
		this.flag1.x = ::battle.corner_right - 200;
		this.flag1.y = this.centerY - 250;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200;
		this.flag1.y = this.centerY - 250;
	}

	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0.33000001;

		if (this.flag2 >= 12.50000000)
		{
			this.flag2 = 12.50000000;
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
			this.MT2_Attack(null);
			return;
		}
	};
}

function MT2_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4921, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.flag1 = -400.00000000;
	this.flag2 = 0.10000000;
	this.flag5 = {};
	this.flag5.vec <- this.Vector3();
	this.flag5.vec.x = 16.00000000;
	this.flag5.vec.RotateByDegree(72);
	this.flag5.shotNum <- 4;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.y = -150;
	this.flag5.shotCycle <- 30;
	this.flag5.shotTimes <- 1;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotTimes = 2;
		this.flag5.shotCycle = 30;
		break;

	case 2:
		this.flag5.shotTimes = 3;
		this.flag5.shotCycle = 20;
		break;

	case 3:
	case 4:
		this.flag5.shotTimes = 4;
		this.flag5.shotCycle = 15;
		break;
	}

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
	{
		this.direction = 1.00000000;
	}
	else
	{
		this.direction = -1.00000000;
	}

	this.AjustCenterStop();
	this.func = function ()
	{
		this.PlaySE(1308);

		for( local i = 0; i < 5; i++ )
		{
			for( local j = 0; j < this.flag5.shotNum; j++ )
			{
				local t_ = {};
				t_.vx <- this.flag5.pos.x * 0.02500000;
				t_.vy <- -2 + this.flag5.pos.y * 0.02500000;
				this.SetShot(this.x + this.flag5.pos.x, this.y + this.flag5.pos.y, this.direction, this.Boss_Shot_T_StarFall, t_);
				this.flag5.pos += this.flag5.vec;
			}

			this.flag5.vec.RotateByDegree(-72);

			for( local k = 0; k < this.flag5.shotNum; k++ )
			{
				local t_ = {};
				t_.vx <- this.flag5.pos.x * 0.02500000;
				t_.vy <- -2 + this.flag5.pos.y * 0.02500000;
				this.SetShot(this.x + this.flag5.pos.x, this.y + this.flag5.pos.y, this.direction, this.Boss_Shot_T_StarFall, t_);
				this.flag5.pos += this.flag5.vec;
			}

			this.flag5.vec.RotateByDegree(144);
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % this.flag5.shotCycle == 1 && this.flag5.shotTimes > 0)
				{
					this.func();
					this.flag5.shotTimes--;
				}

				this.CenterUpdate(0.05000000, 0.50000000);

				if (this.count >= 180)
				{
					this.SetMotion(this.motion, 4);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 0.50000000);

						if (this.count == 60)
						{
							this.SetMotion(this.motion, 5);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.10000000, 1.00000000);
							};
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.SetMotion(4990, 0);
			this.stateLabel = function ()
			{
				this.MT2_Change_Slave(null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000, 0.50000000);
	};
}

function MT2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.ST2_PositionChange(null);
	this.Set_BossSpellBariaRate(20);
}

function Master_Spell_1()
{
	this.team.slave.Slave_Marisa_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
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
	this.SetMotion(4990, 0);
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
		this.flag5.moveV += 0.33000001;

		if (this.flag5.moveV > 15.00000000)
		{
			this.flag5.moveV = 15.00000000;
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

				if (this.Vec_Brake(0.75000000))
				{
					this.Master_Spell_1_Attack(null);
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
}

function Master_Spell_1_Move( t )
{
	this.LabelClear();
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
	{
		this.flag1.x = ::battle.corner_right - 200;
		this.flag1.y = this.centerY - 250;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200;
		this.flag1.y = this.centerY - 250;
	}

	this.flag3 = true;
	this.SetMotion(4990, 0);
	this.stateLabel = function ()
	{
		if (this.flag3)
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
		else
		{
			this.Boss_WalkMotionUpdate(0);
		}

		this.flag2 += 0.33000001;

		if (this.flag2 >= 15.00000000)
		{
			this.flag2 = 15.00000000;
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
			this.Master_Spell_1_Attack(null);
			return;
		}
	};
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4930, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.flag1 = -400.00000000;
	this.flag2 = 0.10000000;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.vec <- this.Vector3();
	this.flag5.vec.x = 16.00000000;
	this.flag5.vec.RotateByDegree(72);
	this.flag5.shotNum <- 4;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.y = -150;
	this.flag5.shotCycle <- 30;
	this.flag5.shotTimes <- 1;
	this.flag5.chargeCount <- 90;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotTimes = 2;
		this.flag5.shotCycle = 30;
		this.flag5.chargeCount = 60;
		break;

	case 2:
		this.flag5.shotTimes = 3;
		this.flag5.shotCycle = 30;
		this.flag5.chargeCount = 60;
		break;

	case 3:
	case 4:
		this.flag5.shotTimes = 4;
		this.flag5.shotCycle = 30;
		this.flag5.chargeCount = 60;
		break;
	}

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
	{
		this.direction = 1.00000000;
	}
	else
	{
		this.direction = -1.00000000;
	}

	this.AjustCenterStop();
	this.func = function ()
	{
		this.PlaySE(1308);

		for( local i = 0; i < 5; i++ )
		{
			for( local j = 0; j < this.flag5.shotNum; j++ )
			{
				local t_ = {};
				t_.vx <- this.flag5.pos.x * 0.04000000;
				t_.vy <- (this.flag5.pos.y + 75) * 0.04000000;
				this.SetShot(this.x + this.flag5.pos.x, this.y + this.flag5.pos.y, this.direction, this.Boss_Shot_1, t_);
				this.flag5.pos += this.flag5.vec;
			}

			this.flag5.vec.RotateByDegree(-72);

			for( local k = 0; k < this.flag5.shotNum; k++ )
			{
				local t_ = {};
				t_.vx <- this.flag5.pos.x * 0.04000000;
				t_.vy <- (this.flag5.pos.y + 75) * 0.04000000;
				this.SetShot(this.x + this.flag5.pos.x, this.y + this.flag5.pos.y, this.direction, this.Boss_Shot_1, t_);
				this.flag5.pos += this.flag5.vec;
			}

			this.flag5.vec.RotateByDegree(144);
		}
	};
	this.keyAction = [
		function ()
		{
			this.lavelClearEvent = function ()
			{
				if (this.flag4)
				{
					this.flag4.func();
				}

				this.flag4 = null;
			};
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.25000000, 0.50000000);
				this.flag5.chargeCount--;

				if (this.flag5.chargeCount == 0)
				{
					this.SetMotion(this.motion, 2);

					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % this.flag5.shotCycle == 1 && this.flag5.shotTimes >= 1)
				{
					this.func();
					this.flag5.shotTimes--;
				}

				this.CenterUpdate(0.05000000, 0.50000000);

				if (this.count >= 135)
				{
					this.M1_Change_Slave(null);
					return;
					this.SetMotion(this.motion, 4);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 0.50000000);

						if (this.count == 60)
						{
							this.SetMotion(this.motion, 5);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.10000000, 1.00000000);
							};
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.M1_Change_Slave(null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000, 0.50000000);
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Move_Marisa(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 1.00000000;
	this.com_flag2 = 0;
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

					this.MS2_Attack();
				}
			};
		}
	};
	return true;
}

function MS2_Step()
{
	this.LabelReset();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.keyAction = [
		function ()
		{
		}
	];
	local state_ = function ()
	{
		this.CenterUpdate(0.50000000, 12.50000000);

		if (this.keyTake == 2 && this.fabs(this.va.y) <= 2.00000000)
		{
			this.SetMotion(this.motion, 3);
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 5);
			this.keyAction = function ()
			{
				this.MS2_Attack();
			};
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 12.50000000);
				this.VX_Brake(0.50000000);
			};
		}
	};

	if (this.rand() % 100 <= 49)
	{
		this.SetMotion(4983, 0);
		this.keyAction[0] = function ()
		{
			this.PlaySE(800);
			this.centerStop = -3;
			this.SetSpeed_XY(5.00000000 + this.rand() % 4, -12.50000000);

			if (this.x > ::battle.corner_right - 400 || this.x > ::battle.corner_left + 400 && this.rand() % 100 >= 49)
			{
				this.va.x *= -1.00000000;
			}

			this.ConvertTotalSpeed();
			this.stateLabel = state_;
		};
	}
	else
	{
		this.SetMotion(4984, 0);
		this.keyAction[0] = function ()
		{
			this.PlaySE(800);
			this.centerStop = 3;
			this.SetSpeed_XY(5.00000000 + this.rand() % 4, 12.50000000);

			if (this.x > ::battle.corner_right - 400 || this.x > ::battle.corner_left + 400 && this.rand() % 100 >= 49)
			{
				this.va.x *= -1.00000000;
			}

			this.ConvertTotalSpeed();
			this.stateLabel = state_;
		};
	}
}

function MS2_Attack()
{
	this.LabelReset();
	this.SetMotion(4950, 0);
	this.direction = this.com_flag1;
	this.com_flag1 *= -1.00000000;
	this.com_flag2++;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotWay <- 3;
	this.flag5.shotCount <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- this.Vector3();
	this.flag5.wait <- 45;

	if (this.com_flag2 >= 4)
	{
		this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1292);
			this.SetShot(640 + 720 * this.direction, ::battle.scroll_bottom - 200 - this.rand() % 2 * 400, -this.direction, this.Boss_Shot_2_Core, {});
			::camera.lock = false;
			::camera.auto_zoom_limit = 1.10000002;
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
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count > this.flag5.wait && this.com_flag2 <= 3)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
					};
					this.keyAction = function ()
					{
						this.MS2_Step();
					};
					return;
				}

				if (this.count >= this.flag5.wait + 90)
				{
					this.com_flag2 = 0;
					this.M2_Change_Slave(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.MS2_Step();
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Slave_Ichirin_1()
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

function Slave_Attack_Ichirin( t )
{
	this.LabelClear();
	this.SetMotion(4940, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.shotCount <- 45;
	this.flag5.shotScale <- 1.00000000;
	this.flag5.wait <- 120;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 60;
		this.flag5.shotScale = 1.10000002;
		break;

	case 2:
		this.flag5.shotCount = 75;
		this.flag5.shotScale = 1.20000005;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 90;
		this.flag5.shotScale = 1.29999995;
		break;
	}

	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.33000001);
		this.CenterUpdate(0.20000000, 3.00000000);

		if (this.count == 30)
		{
			this.SetSpeed_XY(this.va.x, 0.00000000);
			this.SetMotion(this.motion, 2);
			this.count = 0;
			this.PlaySE(1363);
			this.rz = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.rz = this.Math_MinMax(this.rz, -0.34906584, 0.34906584);
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					local t_ = {};
					t_.scale <- this.flag5.shotScale;
					t_.rot <- this.rz;
					this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_SL1, t_).weakref();
				}

				if (this.count == 60)
				{
					this.PlaySE(1352);
					::camera.Shake(10.00000000);
					this.count = 0;
					this.team.master.shot_actor.Foreach(function ()
					{
						this.func[1].call(this);
					});
					this.stateLabel = function ()
					{
						if (this.com_difficulty == 4 && (this.count == 1 || this.count == 31))
						{
							local pos_ = this.Vector3();
							this.GetPoint(0, pos_);

							for( local i = 0; i < 18; i++ )
							{
								local t_ = {};
								t_.rot <- i * 0.34906584;
								t_.v <- 4.00000000;
								this.SetShot(pos_.x, pos_.y, this.direction, this.Boss_Shot_SL1_Star, t_);
							}
						}

						::camera.Shake(2.00000000);
						this.VX_Brake(0.75000000, -0.50000000 * this.direction);

						if (this.count > this.flag5.shotCount)
						{
							if (this.flag2)
							{
								this.flag2.func[0].call(this.flag2);
							}

							this.flag2 = null;
							this.SetMotion(this.motion, 4);
							this.stateLabel = function ()
							{
								this.VX_Brake(0.05000000);
							};
						}
					};
				}
			};
			return;
		}
	};
	this.keyAction = [
		null,
		null,
		null,
		null,
		function ()
		{
			this.rz = 0.00000000;
			this.Slave_Move_Ichirin(null);
		},
		function ()
		{
			this.team.master.shot_actor.Foreach(function ()
			{
				this.team.slave.SetShot(this.x, this.y, this.direction, this.team.slave.Boss_Shot_SL1, {});
				this.func[0].call(this);
			});
			this.count = 0;
			this.PlaySE(1965);
			this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000, -1.00000000 * this.direction);
				this.CenterUpdate(0.05000000, 0.50000000);
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.05000000);
				this.CenterUpdate(0.05000000, 3.00000000);

				if (this.count >= this.flag5.wait)
				{
					this.Slave_Move_Ichirin(null);
					return;
				}
			};
		}
	];
}

function Slave_Move_Ichirin( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
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
		this.flag2 += 0.40000001;

		if (this.flag2 >= 12.50000000)
		{
			this.flag2 = 12.50000000;
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

		if (v_ <= 12.50000000)
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

function Slave_Reimu_2()
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

function Slave_Attack_Reimu_2( t )
{
	this.LabelClear();
	this.SetMotion(4940, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag2 = null;
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
	this.flag5.shotCount <- 60;
	this.flag5.shotScale <- 1.00000000;
	this.flag5.wait <- 120;

	if (this.x > 640)
	{
		this.direction = -1.00000000;
	}
	else
	{
		this.direction = 1.00000000;
	}

	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 90;
		this.flag5.shotScale = 1.10000002;
		break;

	case 2:
		this.flag5.shotCount = 120;
		this.flag5.shotScale = 1.20000005;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 150;
		this.flag5.shotScale = 1.29999995;
		break;
	}

	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.33000001, -1.00000000 * this.direction);

		if (this.count == 60)
		{
			this.SetMotion(this.motion, 2);
			this.count = 0;
			this.PlaySE(1363);
			local t_ = {};
			t_.scale <- this.flag5.shotScale;
			t_.rot <- this.rz;
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_SL2, t_).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					this.PlaySE(1352);
					this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
					::camera.Shake(10.00000000);
					this.count = 0;
					this.team.master.shot_actor.Foreach(function ()
					{
						this.func[1].call(this);
					});
					this.stateLabel = function ()
					{
						::camera.Shake(2.00000000);
						this.VX_Brake(0.75000000, -1.50000000 * this.direction);

						if (this.count > this.flag5.shotCount)
						{
							if (this.flag2)
							{
								this.flag2.func[0].call(this.flag2);
							}

							this.flag2 = null;
							this.SetMotion(this.motion, 4);
							this.stateLabel = function ()
							{
								this.VX_Brake(0.05000000);
							};
						}
					};
				}
			};
			return;
		}
	};
	this.keyAction = [
		null,
		null,
		null,
		null,
		function ()
		{
			this.rz = 0.00000000;
			this.Change_Master_Reimu(null);
		}
	];
}

function Change_Master_Reimu( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_2_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

