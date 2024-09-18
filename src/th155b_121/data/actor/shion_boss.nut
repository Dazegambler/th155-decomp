function Stand_Init( t )
{
	this.LabelClear();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.SetMotion(0, 0);
}

function Set_BerserkAura( t )
{
	::camera.Shake(15.00000000);
	this.PlaySE(4680);
	this.aura = this.SetFreeObject(this.x, this.y, this.direction, this.Shion_BerserkAura, {}).weakref();
	this.FadeIn(0.00000000, 0.25000000, 1.00000000, 120);
	this.SetFreeObject(this.x, this.y - 10, this.direction, this.Shion_BerserkAura_Fire, {}).weakref();
	this.stateLabel = function ()
	{
		::camera.Shake(2.00000000);
	};
}

function Shake_Stop( t )
{
	this.stateLabel = function ()
	{
	};
}

function DamageFinish( t )
{
	this.LabelClear();
	this.SetMotion(211, 0);

	if (this.damageStopTime > 10)
	{
		this.damageStopTime = 10;
	}

	this.direction = t.direction;
	this.invin = -1;
	this.invinGrab = -1;
	this.invinObject = -1;
	this.SetSpeed_XY(-2.50000000 * this.direction, -2.50000000);
	this.centerStop = -3;
	this.count = 0;
	this.func = function ()
	{
		if (this.aura)
		{
			this.aura.func[0].call(this.aura);
		}

		this.isVisible = false;
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = null;
		this.centerStop = -2;
	};
	this.stateLabel = function ()
	{
		if (this.count >= 4)
		{
			this.PlaySE(846);
			this.SetEffect(this.x, this.y, 1.00000000, this.EF_KO_Flash, {}, this);
			this.count = 0;
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.00500000);
				this.AddSpeed_XY(0.00000000, 0.02500000);
			};
		}

		this.VX_Brake(0.01000000);
	};
}

function Master_Spell_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.invin = 30;
	this.invinGrab = 30;
	this.invinObject = 30;
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.koExp = true;
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					this.Master_Spell_1_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_1_PreMove()
{
	this.SetSpeed_Vec(1.00000000, -135 * 0.01745329, this.direction);
	this.flag5.moveCount = 0;
	this.subState[0] = function ()
	{
		if (this.AddSpeed_Vec(0.25000000, null, 6.00000000, this.direction))
		{
			this.subState[0] = function ()
			{
				if (this.Vec_Brake(0.25000000))
				{
					this.subState[1] = this.Master_Spell_1_YakuBarrage;
					this.subState[0] = function ()
					{
						this.flag5.moveCount++;

						if (this.flag5.moveCount >= 120)
						{
							this.Master_Spell_1_ChaiceMove();
						}
					};
				}
			};
		}
	};
}

function Master_Spell_1_ChaiceMove()
{
	this.GetFront();
	this.flag5.moveCount = 0;
	local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
	this.SetSpeed_Vec(1.00000000, r_, this.direction);
	this.subState[0] = function ()
	{
		this.TargetHoming(this.target, 0.10471975, this.direction);

		if (this.AddSpeed_Vec(0.10000000, null, 4.00000000, this.direction))
		{
			this.subState[0] = function ()
			{
				this.TargetHoming(this.target, 0.05235988, this.direction);
				this.flag5.moveCount++;

				if (this.flag5.moveCount >= 240)
				{
					this.subState[0] = function ()
					{
						this.Vec_Brake(0.10000000);
						this.flag5.moveCount++;

						if (this.flag5.moveCount >= 360)
						{
							this.Master_Spell_1_ChaiceMove();
						}
					};
				}
			};
		}
	};
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(5300, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 20;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 15;
		break;

	case 2:
		this.flag5.shotCycle = 10;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 5;
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
	this.stateLabel = function ()
	{
		if (this.team.life <= 4000)
		{
			this.Master_Spell_1_ModeChange_B();
		}

		this.subState[0].call(this);
		this.subState[1].call(this);
	};
	this.Master_Spell_1_PreMove();
}

function Master_Spell_1_YakuBarrage()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		local t_ = {};
		t_.v <- 2.00000000;
		t_.rot <- this.flag5.shotRot + this.rand() % 41 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		this.flag5.shotRot += 0.08726646;
	}
}

function Master_Spell_1_ModeChange_B()
{
	if (this.team.life <= 2000)
	{
		this.Master_Spell_1_ModeChange_C();
		return;
	}

	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.PlaySE(816);
	this.SetEffect(this.x, this.y, this.direction, this.Boss_SpellBreak, {});
	::camera.Shake(6.00000000);
	this.SetMotion(200, 0);
	this.GetFront();
	this.SetSpeed_Vec(15.00000000, -175 * 0.01745329, this.direction);
	this.count = 0;
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.Master_Spell_1_Attack2(null);
		}
	];
	this.stateLabel = function ()
	{
		if (this.Vec_Brake(0.33000001))
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					this.SetMotion(200, 1);
				}
			};
		}
	};
}

function Master_Spell_1_Attack2( t )
{
	this.LabelClear();
	this.SetMotion(5300, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 20;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 15;
		break;

	case 2:
		this.flag5.shotCycle = 10;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 5;
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
	this.stateLabel = function ()
	{
		if (this.team.life <= 2000)
		{
			this.Master_Spell_1_ModeChange_C();
		}

		this.subState[0].call(this);
		this.subState[1].call(this);
	};
	this.Master_Spell_1_PreMove2();
}

function Master_Spell_1_PreMove2()
{
	this.SetSpeed_Vec(1.00000000, -135 * 0.01745329, this.direction);
	this.flag5.moveCount = 0;
	this.subState[0] = function ()
	{
		if (this.AddSpeed_Vec(0.25000000, null, 2.00000000, this.direction))
		{
			this.subState[0] = function ()
			{
				this.flag5.moveCount++;

				if (this.flag5.moveCount >= 120)
				{
					this.subState[0] = function ()
					{
						this.flag5.moveCount++;

						if (this.flag5.moveCount >= 120)
						{
							this.Master_Spell_1_ChaiceMove2();
						}
					};
				}
			};
		}
	};
	this.subState[1] = this.Master_Spell_1_YakuBarrage2;
}

function Master_Spell_1_ChaiceMove2()
{
	this.GetFront();
	this.flag5.moveCount = 0;
	local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
	this.SetSpeed_Vec(1.00000000, r_, this.direction);
	this.subState[0] = function ()
	{
		this.TargetHoming(this.target, 3.14159203, this.direction);

		if (this.AddSpeed_Vec(0.10000000, null, 2.00000000, this.direction))
		{
			this.subState[0] = function ()
			{
				this.TargetHoming(this.target, 3.14159203, this.direction);
				this.flag5.moveCount++;

				if (this.flag5.moveCount >= 180)
				{
					this.subState[0] = function ()
					{
						this.Vec_Brake(0.10000000);
						this.flag5.moveCount++;

						if (this.flag5.moveCount >= 240)
						{
							this.Master_Spell_1_ChaiceMove2();
						}
					};
				}
			};
		}
	};
}

function Master_Spell_1_YakuBarrage2()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		local t_ = {};
		t_.v <- 5.00000000;
		t_.rot <- this.flag5.shotRot;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		local t_ = {};
		t_.v <- 5.00000000;
		t_.rot <- this.flag5.shotRot + 120 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		local t_ = {};
		t_.v <- 5.00000000;
		t_.rot <- this.flag5.shotRot + 240 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		this.flag5.shotRot += 0.08726646;
	}
}

function Master_Spell_1_ModeChange_C()
{
	this.SetMotion(200, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.GetFront();
	::camera.Shake(6.00000000);
	this.PlaySE(816);
	this.SetEffect(this.x, this.y, this.direction, this.Boss_SpellBreak, {});
	this.SetSpeed_Vec(15.00000000, -175 * 0.01745329, this.direction);
	this.count = 0;
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.Master_Spell_1_Attack3(null);
		}
	];
	this.stateLabel = function ()
	{
		if (this.Vec_Brake(0.33000001))
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					this.SetMotion(200, 1);
				}
			};
		}
	};
}

function Master_Spell_1_Attack3( t )
{
	this.LabelClear();
	this.SetMotion(5300, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 20;
	this.flag5.shotCount <- 0;
	this.flag5.shotNum <- 8;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 15;
		this.flag5.shotNum = 12;
		break;

	case 2:
		this.flag5.shotCycle = 10;
		this.flag5.shotNum = 18;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 5;
		this.flag5.shotNum = 24;
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
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
	this.Master_Spell_1_PreMove3();
}

function Master_Spell_1_PreMove3()
{
	this.subState[0] = this.Master_Spell_1_CenterWait;
}

function Master_Spell_1_CenterWait()
{
	this.flag5.moveV += 0.20000000;

	if (this.flag5.moveV >= 6.00000000)
	{
		this.flag5.moveV = 6.00000000;
	}

	local pos_ = this.Vector3();
	pos_.x = (640 - this.x) * 0.10000000;
	pos_.y = (240 - this.y) * 0.10000000;
	local r_ = pos_.Length();

	if (r_ > this.flag5.moveV)
	{
		pos_.SetLength(this.flag5.moveV);
	}

	if (r_ <= 10.00000000)
	{
		this.subState[1] = this.Master_Spell_1_YakuBarrage3;
		this.flag5.moveV = 0;
		this.flag5.moveCount = 0;
		this.subState[0] = function ()
		{
			this.flag5.moveV += 0.02500000;
			this.flag5.moveCount++;
			pos_ = this.Vector3();
			pos_.x = 640 + this.flag5.moveV * this.sin(this.flag5.moveCount * 0.01745329);
			pos_.y = 240 + this.flag5.moveV * 0.50000000 * this.cos(this.flag5.moveCount * 0.05235988);
			this.SetSpeed_XY((pos_.x - this.x) * 0.10000000, (pos_.y - this.y) * 0.10000000);
		};
	}
	else
	{
		this.SetSpeed_XY(pos_.x, pos_.y);
	}
}

function Master_Spell_1_YakuBarrage3()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1 && this.flag5.shotCount % 150 <= 90)
	{
		local t_ = {};
		t_.v <- 8.00000000;
		t_.rot <- this.flag5.shotRot;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		local t_ = {};
		t_.v <- 8.00000000;
		t_.rot <- this.flag5.shotRot + 90 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		local t_ = {};
		t_.v <- 8.00000000;
		t_.rot <- this.flag5.shotRot + 180 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		local t_ = {};
		t_.v <- 8.00000000;
		t_.rot <- this.flag5.shotRot + 270 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		this.flag5.shotRot += 0.17453292;
	}

	if (this.flag5.shotCount % 150 == 90)
	{
		for( local i = 0; i < this.flag5.shotNum; i++ )
		{
			local t_ = {};
			t_.v <- 2.00000000 + this.rand() % 6;
			t_.rot <- (this.rand() % 6 + i * 15) * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_1_Shot, t_);
		}
	}
}

function Master_Spell_2()
{
	this.LabelClear();
	this.SetMotion(5009, 0);
	this.disableGuard = -1;
	this.cpuState = null;
	this.boss_cpu = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.invin = 30;
	this.invinGrab = 30;
	this.invinObject = 30;
	this.count = 0;
	this.flag1 = null;
	this.flag2 = 0.00000000;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 180)
		{
			this.flag1 = this.SetFreeObject(640, 240, 1.00000000, this.Aura_LastAttackStart, {});
			this.subState = function ()
			{
				this.flag2 += 0.50000000;

				if (this.flag2 >= 12.50000000)
				{
					this.flag2 = 12.50000000;
				}

				local v_ = this.Vector3();
				v_.x = (640 - this.x) * 0.10000000;
				v_.y = (360 - this.y) * 0.10000000;

				if (v_.Length() >= this.flag2)
				{
					v_.SetLength(this.flag2);
				}

				this.SetSpeed_XY(v_.x, v_.y);
			};
		}

		if (this.count == 480)
		{
			this.flag1.func[0].call(this.flag1);
			this.Master_Spell_2_Start(null);
			return;
		}
	};
	return true;
}

function Master_Spell_2_Start( t )
{
	this.LabelClear();
	this.SetMotion(5009, 0);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 45);
	this.BossForceCall_Init();
	this.flag5 = {};
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.totalCount <- 0;
	this.flag5.shot_Range <- 0.00000000;
	this.flag5.shot_AddRange <- 0.10000000;
	this.flag5.back <- this.SetFreeObject(640, 360, 1.00000000, this.Shion_Back, {}).weakref();
	this.count = 0;

	switch(this.com_difficulty)
	{
	case 0:
		this.atkRate = 0.25000000;
		break;

	case 1:
		this.atkRate = 0.50000000;
		break;

	case 2:
		this.atkRate = 1.00000000;
		break;

	case 3:
	case 4:
		this.atkRate = 1.50000000;
		break;
	}

	this.DamageBuffAjust();
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
		this.flag2 += 0.50000000;

		if (this.flag2 >= 12.50000000)
		{
			this.flag2 = 12.50000000;
		}

		local v_ = this.Vector3();
		v_.x = (640 - this.x) * 0.10000000;
		v_.y = (360 - this.y) * 0.10000000;

		if (v_.Length() >= this.flag2)
		{
			v_.SetLength(this.flag2);
		}

		this.SetSpeed_XY(v_.x, v_.y);
	};
	this.subState[1] = function ()
	{
		this.flag5.shotCount++;

		if (this.flag5.shotCount == 60)
		{
			this.PlaySE(849);
		}

		if (this.flag5.shotCount >= 120)
		{
			this.subState[1] = this.Master_Spell_2_Attack_1_Top;
		}
	};
	this.stateLabel = function ()
	{
		this.flag5.totalCount++;

		if (this.flag5.totalCount == 1200)
		{
			this.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag5.back.func[1].call(this.flag5.back);
			this.flag5.shotCycle = 7;
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= 60)
				{
					this.subState[1] = this.Master_Spell_2_Attack_1_Top;
				}
			};
		}

		if (this.flag5.totalCount == 2400)
		{
			this.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag5.back.func[2].call(this.flag5.back);
			this.flag5.shotCycle = 10;
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= 60)
				{
					this.subState[1] = this.Master_Spell_2_Attack_2_Top;
				}
			};
		}

		if (this.flag5.totalCount == 3300)
		{
			this.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag5.back.func[3].call(this.flag5.back);
			this.flag5.shotCycle = 45;
			this.flag5.shotCount = 0;
			this.flag5.shot_AddRange = 75;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= 60)
				{
					this.subState[1] = this.Master_Spell_2_Attack_3;
				}
			};
		}

		if (this.flag5.totalCount == 3780)
		{
			this.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag5.back.func[0].call(this.flag5.back);
			this.Master_Spell_2_Break(null);
			return;
		}

		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_2_Attack_1_Top()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		this.flag5.shot_Range += this.flag5.shot_AddRange;
		local t_ = {};
		t_.v <- 2.00000000;
		t_.rot <- 1.57079601;
		local x_ = ::camera.camera2d.right - ::camera.camera2d.left;
		this.SetShot(::camera.camera2d.left + x_ * this.flag5.shot_Range, ::camera.camera2d.top, 1.00000000, this.Master_Spell_2_ShotA, t_);

		if (this.flag5.shot_Range >= 1.00000000)
		{
			this.flag5.shotCount = 0;
			this.flag5.shot_Range = 0;
			this.subState[1] = this.Master_Spell_2_Attack_1_Right;
		}
	}
}

function Master_Spell_2_Attack_1_Right()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		this.flag5.shot_Range += this.flag5.shot_AddRange;
		local t_ = {};
		t_.v <- 2.00000000;
		t_.rot <- 3.14159203;
		local x_ = ::camera.camera2d.bottom - ::camera.camera2d.top;
		this.SetShot(::camera.camera2d.right, ::camera.camera2d.top + x_ * this.flag5.shot_Range, 1.00000000, this.Master_Spell_2_ShotA, t_);

		if (this.flag5.shot_Range >= 1.00000000)
		{
			this.flag5.shotCount = 0;
			this.flag5.shot_Range = 0;
			this.subState[1] = this.Master_Spell_2_Attack_1_Bottom;
		}
	}
}

function Master_Spell_2_Attack_1_Bottom()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		this.flag5.shot_Range += this.flag5.shot_AddRange;
		local t_ = {};
		t_.v <- 2.00000000;
		t_.rot <- -1.57079601;
		local x_ = ::camera.camera2d.left - ::camera.camera2d.right;
		this.SetShot(::camera.camera2d.right + x_ * this.flag5.shot_Range, ::camera.camera2d.bottom, 1.00000000, this.Master_Spell_2_ShotA, t_);

		if (this.flag5.shot_Range >= 1.00000000)
		{
			this.flag5.shotCount = 0;
			this.flag5.shot_Range = 0;
			this.subState[1] = this.Master_Spell_2_Attack_1_Left;
		}
	}
}

function Master_Spell_2_Attack_1_Left()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		this.flag5.shot_Range += this.flag5.shot_AddRange;
		local t_ = {};
		t_.v <- 2.00000000;
		t_.rot <- 0;
		local x_ = ::camera.camera2d.top - ::camera.camera2d.bottom;
		this.SetShot(::camera.camera2d.left, ::camera.camera2d.bottom + x_ * this.flag5.shot_Range, 1.00000000, this.Master_Spell_2_ShotA, t_);

		if (this.flag5.shot_Range >= 1.00000000)
		{
			this.flag5.shotCount = 0;
			this.flag5.shot_Range = 0;
			this.subState[1] = this.Master_Spell_2_Attack_1_Top;
		}
	}
}

function Master_Spell_2_Attack_2_Top()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		this.flag5.shot_Range += this.flag5.shot_AddRange;
		local t_ = {};
		t_.v <- 1.00000000;
		t_.rot <- 1.57079601;
		local x_ = ::camera.camera2d.right - ::camera.camera2d.left;
		this.SetShot(::camera.camera2d.left + x_ * this.flag5.shot_Range, ::camera.camera2d.top, 1.00000000, this.Master_Spell_2_ShotA, t_);
		local t_ = {};
		t_.v <- 1.00000000;
		t_.rot <- -1.57079601;
		this.SetShot(::camera.camera2d.right - x_ * this.flag5.shot_Range, ::camera.camera2d.bottom, 1.00000000, this.Master_Spell_2_ShotA, t_);

		if (this.flag5.shot_Range >= 1.00000000)
		{
			this.flag5.shotCount = 0;
			this.flag5.shot_Range = 0;
			this.subState[1] = this.Master_Spell_2_Attack_2_Side;
		}
	}
}

function Master_Spell_2_Attack_2_Side()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		this.flag5.shot_Range += this.flag5.shot_AddRange;
		local t_ = {};
		t_.v <- 1.00000000;
		t_.rot <- 0;
		local x_ = ::camera.camera2d.bottom - ::camera.camera2d.top;
		this.SetShot(::camera.camera2d.left, ::camera.camera2d.bottom - x_ * this.flag5.shot_Range, 1.00000000, this.Master_Spell_2_ShotA, t_);
		local t_ = {};
		t_.v <- 1.00000000;
		t_.rot <- 3.14159203;
		this.SetShot(::camera.camera2d.right, ::camera.camera2d.top + x_ * this.flag5.shot_Range, 1.00000000, this.Master_Spell_2_ShotA, t_);

		if (this.flag5.shot_Range >= 1.00000000)
		{
			this.flag5.shotCount = 0;
			this.flag5.shot_Range = 0;
			this.subState[1] = this.Master_Spell_2_Attack_2_Top;
		}
	}
}

function Master_Spell_2_Attack_3()
{
	this.flag5.shotCount++;

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		for( local i = ::camera.camera2d.left; i < ::camera.camera2d.right; i = i + this.flag5.shot_AddRange )
		{
			this.SetShot(i, ::camera.camera2d.top, 1.00000000, this.Master_Spell_2_ShotB, {});
			this.SetShot(i, ::camera.camera2d.bottom, 1.00000000, this.Master_Spell_2_ShotB, {});
		}

		for( local i = ::camera.camera2d.top; i < ::camera.camera2d.bottom; i = i + this.flag5.shot_AddRange )
		{
			this.SetShot(::camera.camera2d.right, i, 1.00000000, this.Master_Spell_2_ShotB, {});
			this.SetShot(::camera.camera2d.left, i, 1.00000000, this.Master_Spell_2_ShotB, {});
		}
	}
}

function Master_Spell_2_Break( t )
{
	this.LabelClear();
	this.SetMotion(200, 0);
	this.isVisible = true;
	this.enableKO = true;
	this.SetSpellBack(false);
	::camera.Shake(20.00000000);
	this.atkRate = 1.00000000;
	this.DamageBuffAjust();
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 120);
	this.GetFront();
	this.SetSpeed_XY(-12.50000000 * this.direction, -3.00000000);
	this.count = 0;
	this.PlaySE(4686);
	::battle.Begin_BattleDemo();
	this.SetFreeObject(640, 720, 1.00000000, this.Shion_BackHeaven, {});
	this.stateLabel = function ()
	{
		if (this.Vec_Brake(0.50000000, 3.00000000))
		{
			this.AddSpeed_XY(0.00000000, 0.00100000, null, 1.00000000);

			if (this.count >= 120)
			{
				this.SetMotion(200, 2);
				this.stateLabel = function ()
				{
					this.Vec_Brake(0.20000000);
				};
				this.keyAction = function ()
				{
					this.stateLabel = function ()
					{
						this.Vec_Brake(0.20000000);

						if (::battle.state == 8)
						{
							this.target.team.current.ForceSpecialCall_Init();
							this.Master_Spell_2_Attack_B(null);
						}
					};
				};
			}
		}
	};
}

function Master_Spell_2_Attack_B( t )
{
	this.LabelClear();
	this.SetMotion(5311, 0);
	this.GetFront();
	this.flag2 = 0;
	this.flag5 = {};
	this.flag5.shotCycle <- 2;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.totalCount <- 0;
	this.flag5.shot_Range <- 0.00000000;
	this.flag5.shot_AddRange <- 0.10000000;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 320 * this.direction;
	this.flag5.pos.y = 240;
	this.flag5.bigCycle <- 0;

	switch(this.com_difficulty)
	{
	case 0:
		this.flag5.bigCycle = 360;
		break;

	case 1:
		this.flag5.bigCycle = 300;
		break;

	case 2:
		this.flag5.bigCycle = 240;
		break;

	case 3:
		this.flag5.bigCycle = 210;
		break;

	case 4:
		this.flag5.bigCycle = 150;
		break;
	}

	::camera.Shake(15.00000000);
	this.PlaySE(4680);
	this.aura = this.SetFreeObject(this.x, this.y, this.direction, this.Shion_BerserkAura, {}).weakref();
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
		this.flag2 += 0.12500000;

		if (this.flag2 >= 12.50000000)
		{
			this.flag2 = 12.50000000;
		}

		local v_ = this.Vector3();
		v_.x = (this.flag5.pos.x - this.x) * 0.10000000;
		v_.y = (this.flag5.pos.y - this.y) * 0.10000000;

		if (v_.Length() >= this.flag2)
		{
			v_.SetLength(this.flag2);
		}

		this.SetSpeed_XY(v_.x, v_.y);
		this.flag5.moveCount++;

		if (this.flag5.moveCount == 60)
		{
			this.subState[1] = this.Master_Spell_2_YakuBarrage;
		}

		if (this.flag5.moveCount >= 120)
		{
			this.Master_Spell_2_Move();
		}
	};
	this.stateLabel = function ()
	{
		if (this.target.team.sp < this.target.team.sp_max2 && this.target.team.sp + 1 >= this.target.team.sp_max2)
		{
			this.PlaySE(866);
			local t_ = {};
			t_.owner <- this.target.team.current.weakref();
			t_.type <- 1;
			this.target.team.current.SetEffect(this.target.team.index == 0 ? 40 : 1240, 664, 1.00000000, ::actor.effect_class.EF_SpellCharge, t_);
		}

		if (this.target.team.sp < this.target.team.sp_max && this.target.team.sp + 1 >= this.target.team.sp_max)
		{
			this.PlaySE(865);
			local t_ = {};
			t_.owner <- this.target.team.current.weakref();
			t_.type <- 0;
			this.target.team.current.SetEffect(this.target.team.index == 0 ? 40 : 1240, 664, 1.00000000, ::actor.effect_class.EF_SpellCharge, t_);
		}

		this.target.team.sp += 1;

		if (this.target.team.sp > this.target.team.sp_max2)
		{
			this.target.team.sp = this.target.team.sp_max2;
		}

		this.target.team.AddMP(10, 0);
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_2_Move()
{
	this.GetFront();
	this.flag5.pos.x -= this.rand() % 128 * this.direction;

	if (this.flag5.pos.x < 240)
	{
		this.flag5.pos.x += 128;
	}

	if (this.flag5.pos.x > 1040)
	{
		this.flag5.pos.x -= 128;
	}

	this.flag5.pos.y = 240 + this.rand() % 360;
	this.flag2 = 1.00000000;
	this.flag5.moveCount = 0;
	this.subState[0] = function ()
	{
		this.flag2 += 0.12500000;

		if (this.flag2 >= 12.50000000)
		{
			this.flag2 = 12.50000000;
		}

		local v_ = this.Vector3();
		v_.x = (this.flag5.pos.x - this.x) * 0.10000000;
		v_.y = (this.flag5.pos.y - this.y) * 0.10000000;

		if (v_.Length() >= this.flag2)
		{
			v_.SetLength(this.flag2);
		}

		this.SetSpeed_XY(v_.x, v_.y);
		this.flag5.moveCount++;

		if (this.flag5.moveCount >= 240)
		{
			this.Master_Spell_2_Move();
		}
	};
}

function Master_Spell_2_YakuBarrage()
{
	this.flag5.shotCount++;
	local cycle_ = 150;

	if (this.team.life <= 5000)
	{
		cycle_ = 120;
	}

	if (this.team.life <= 3000)
	{
		cycle_ = 90;
	}

	if (this.team.life <= 1750)
	{
		cycle_ = 60;
	}

	if (this.flag5.bigCycle > 0 && this.flag5.shotCount % cycle_ == 0)
	{
		local t_ = {};
		t_.v <- 1.00000000;
		t_.rot <- this.rand() % 360 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_2_ShotBig, t_);
	}

	if (this.flag5.shotCount % this.flag5.shotCycle == 1)
	{
		local t_ = {};
		t_.v <- 1.00000000;
		t_.rot <- this.rand() % 360 * 0.01745329;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Master_Spell_2_ShotC, t_);
	}
}

function Slave_Jyoon_1()
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

function Slave_Attack_Jyoon( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 6;
	this.flag5.shotCount <- 60 + 60;
	this.flag5.scale <- 1.00000000;

	switch(this.team.master.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCycle = 3;
		this.flag5.scale = 2.00000000;
		break;

	case 2:
		this.flag5.shotCycle = 2;
		this.flag5.scale = 3.00000000;
		break;

	case 3:
		this.flag5.shotCycle = 1;
		this.flag5.scale = 4.00000000;
		break;

	case 4:
		this.flag5.shotCycle = 1;
		this.flag5.scale = 5.00000000;
		break;
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
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000, -1.50000000 * this.direction);
				this.CenterUpdate(0.05000000, 0.50000000);

				if (this.flag5.shotCount > this.count && this.count % this.flag5.shotCycle == 0)
				{
					local t_ = {};
					t_.scale <- this.flag5.scale;

					if (this.com_difficulty == 4)
					{
						this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Boss_Shot_SL1_OD, t_);
					}
					else
					{
						this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Boss_Shot_SL1, t_);
					}
				}

				if (this.flag5.shotCount == this.count)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count >= this.flag5.shotCount + 180)
				{
					this.Change_Master_Jyoon(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Jyoon( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1_Move();
	this.Set_BossSpellBariaRate(1);
}

function Slave_Attack_Jyoon2( x_, y_ )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = null;
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = x_;
	this.flag5.pos.y = y_;
	this.flag5.moveV <- 0.00000000;
	this.flag5.moveCount <- 240;

	switch(this.team.master.com_difficulty)
	{
	case 0:
		break;

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
		this.flag5.moveV += 0.10000000;

		if (this.flag5.moveV >= 15.00000000)
		{
			this.flag5.moveV = 15.00000000;
		}

		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0.10000000, (this.flag5.pos.y - this.y) * 0.10000000);
		local v_ = this.va.Length();

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		if (this.count == this.flag5.moveCount - 120 && this.com_difficulty == 4)
		{
			this.Slave_Attack_Jyoon2B(null);
			return;
		}

		if (this.count >= this.flag5.moveCount)
		{
			this.Change_Master_Jyoon2(null);
			return;
		}
	};
}

function Slave_Attack_Jyoon2B( t_ )
{
	this.LabelClear();
	this.SetMotion(4920, 1);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.PlaySE(4680);
	::camera.Shake(9.00000000);

	for( local i = 0; i < 36; i++ )
	{
		local t_ = {};
		t_.rot <- i * 0.17453292;
		this.SetShot(this.point0_x, this.point0_y, 1.00000000, this.Boss_Shot_SL2_OD, t_);
	}

	this.stateLabel = function ()
	{
		if (this.count >= 120)
		{
			this.Change_Master_Jyoon2(null);
			return;
		}
	};
}

function Change_Master_Jyoon2( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_2_Attack();
	this.com_flag1 = 1 - this.rand() % 2 * 2;
	this.Set_BossSpellBariaRate(1);
	this.team.master.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
}

function Slave_Jyoon_3()
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

