function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 3)
	{
		this.BeginBattle_Hijiri(null);
		return;
	}

	local r_ = this.rand() % 2;

	if (r_ == 1)
	{
		this.BeginBattleA(null);
	}
	else
	{
		this.BeginBattleA(null);
		  // [041]  OP_JMP            0      0    0    0
	}
}

function Func_Win()
{
	local r_ = this.rand() % 3;

	switch(r_)
	{
	case 2:
		this.WinC(null);
		break;

	case 1:
		this.WinB(null);
		break;

	default:
		this.WinA(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function StoryDemo_Udonge1( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(9011, 0);
	this.stateLabel = null;
}

function StoryDemo_Udonge2( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(9030, 0);
	this.keyAction = function ()
	{
		this.animationSpeed = 0;
		this.PlaySE(2120);
	};
	this.stateLabel = function ()
	{
		::camera.shake_radius = 1,50000000.0;
	};
}

function StoryDemo_Udonge3( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(9030, 2);
	this.animationSpeed = 100;
	this.stateLabel = null;
}

function BeginBattleA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.PlaySE(2190);
	this.SetMotion(9000, 0);
	this.stateLabel = function ()
	{
		if (this.count >= 120)
		{
			this.stateLabel = function ()
			{
			};
			this.PlaySE(2191);
			this.SetMotion(9000, 1);
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,50000000.0);
	this.LabelClear();
	this.Warp(this.x - 50 * this.direction, this.y - 120);

	if (this.team.index == 1)
	{
		this.flag1 = ::battle.start_x[0];
	}
	else
	{
		this.flag1 = ::battle.start_x[1];
	}

	this.SetMotion(9001, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 120)
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		}

		if (this.count >= 180)
		{
			this.SetMotion(this.motion, 1);
			this.count = 0;
			this.stateLabel = null;
		}
	};
	this.demoObject = null;
	this.keyAction = [
		null,
		function ()
		{
			this.Warp(this.flag1.x, this.flag1.y);
		},
		function ()
		{
			this.EndtoFreeMove();
			this.CommonBegin();
		}
	];
}

function BeginBattle_Hijiri( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.Warp(::battle.start_x[this.team.index] - 390 * this.direction, this.centerY - 340);
	this.team.slave.BeginBattle_Slave(null);
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.SetSpeed_Vec(25, 0,78539813.0, this.direction);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 1;
			this.SetMotion(9002, 1);
			this.SetSpeed_XY(5,00000000.0 * this.direction, 3,00000000.0);
			this.stateLabel = function ()
			{
				if (this.va.x > 0,00000000.0 && this.x > ::battle.start_x[this.team.index] || this.va.x < 0 && this.x < ::battle.start_x[this.team.index])
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				}

				this.VX_Brake(0,30000001.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			::camera.Shake(10,00000000.0);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_GuardCrash, {});
			this.PlaySE(2156);
		},
		function ()
		{
			this.CommonBegin();
		}
	];
}

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.Warp(::battle.start_x[this.team.index] - 240 * this.direction, this.centerY - 340);
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.SetSpeed_Vec(25, 0,78539813.0, this.direction);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 1;
			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(5,00000000.0 * this.direction, 3,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,30000001.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			::camera.Shake(10,00000000.0);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_GuardCrash, {});
			this.PlaySE(2156);
		},
		function ()
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	];
}

function WinA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.count = 0;
	this.PlaySE(2192);
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.CommonWin();
		}
	};
}

function WinB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.CommonWin();
		}
	};
}

function WinC( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.SetMotion(this.motion, 1);
		}

		if (this.count == 60 + 90)
		{
			this.SetMotion(this.motion, 2);
		}

		if (this.count == 90 + 90 + 60)
		{
			this.CommonWin();
		}
	};
}

function Lose( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.CommonLose();
		}
	};
}

function Stand_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.Stand;
	this.SetMotion(0, 0);
}

function MoveFront_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveFront;
	this.SetMotion(1, 0);
	this.SetSpeed_XY(6,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-6,00000000.0 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- -16,50000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 16,50000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- -16,50000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 16,50000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- 16,50000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 16,50000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- 16,50000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 16,50000000.0;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = -7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = 7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 6,00000000.0;
	t_.addSpeed <- 0,20000000.0;
	t_.maxSpeed <- 13,50000000.0;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 6,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0,17500000.0;
	t_.maxSpeed <- 13,50000000.0;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10,00000000.0 * this.direction, -4,50000000.0);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,44999999.0);

		if (this.y > this.centerY && this.va.y > 0,00000000.0)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2,50000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -7,50000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 30;
	this.DashBack_Air_Common(t_);
}

function Atk_Low_Init( t )
{
	this.LabelClear();

	if (this.style == 1)
	{
		this.SetMotion(1001, 0);
	}
	else
	{
		this.SetMotion(1000, 0);
	}

	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2000);
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,10000000.0);
		}
	};
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();

	if (this.style == 1)
	{
		this.SetMotion(1501, 0);
	}
	else
	{
		this.SetMotion(1500, 0);
	}

	this.HitReset();
	this.atk_id = 1;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2000);
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,10000000.0);
		}
	};
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.hitCount = 0;

	if (this.style == 1)
	{
		this.SetMotion(1101, 0);
	}
	else
	{
		this.SetMotion(1100, 0);
	}

	this.flag1 = 0;
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2002);
			this.SetSpeed_XY(6,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				if (this.hitResult && this.hitCount <= 3)
				{
					this.flag1++;

					if (this.flag1 >= 4)
					{
						this.flag1 = 0;
						this.HitTargetReset();
					}
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4;
	this.hitCount = 0;

	if (this.style == 1)
	{
		this.SetMotion(1601, 0);
	}
	else
	{
		this.SetMotion(1600, 0);
	}

	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(8,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(2002);
			this.SetSpeed_XY(6,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				if (this.hitResult && this.hitCount <= 3)
				{
					this.flag1++;

					if (this.flag1 >= 4)
					{
						this.flag1 = 0;
						this.HitTargetReset();
					}
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;

	if (this.style == 1)
	{
		this.SetMotion(1111, 0);
	}
	else
	{
		this.SetMotion(1110, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(2004);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;

	if (this.style == 1)
	{
		this.SetMotion(1211, 0);
	}
	else
	{
		this.SetMotion(1210, 0);
	}

	this.SetSpeed_XY(null, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2006);
			this.SetSpeed_XY(10,00000000.0 * this.direction, 8,00000000.0);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.VY_Brake(0,60000002.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;

	if (this.style == 1)
	{
		this.SetMotion(1711, 0);
	}
	else
	{
		this.SetMotion(1710, 0);
	}

	this.flag1 = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(-3,00000000.0 * this.direction, -8,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2006);
			this.SetSpeed_XY(17,50000000.0 * this.direction, 12,00000000.0);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.VY_Brake(0,60000002.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,20000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;

	if (this.style == 1)
	{
		this.SetMotion(1216, 0);
	}
	else
	{
		this.SetMotion(1215, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(2006);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;

	if (this.style == 1)
	{
		this.SetMotion(1221, 0);
	}
	else
	{
		this.SetMotion(1220, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(2008);
			this.SetSpeed_XY(10,00000000.0 * this.direction, -10,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
				this.AddSpeed_XY(null, 0,30000001.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x, 6,00000000.0);
			this.centerStop = 2;
			this.PlaySE(2009);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(null, 0,40000001.0);

				if (this.y > this.centerY)
				{
					if (this.keyTake <= 2)
					{
						this.SetMotion(this.motion, 3);
					}

					this.SetSpeed_XY(3,00000000.0 * this.direction, 3);
					this.centerStop = 1;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,40000001.0);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;

	if (this.style == 1)
	{
		this.SetMotion(1721, 0);
	}
	else
	{
		this.SetMotion(1720, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(2008);
			this.SetSpeed_XY(7,50000000.0 * this.direction, -10,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
				this.AddSpeed_XY(null, 0,30000001.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 6,00000000.0);
			this.centerStop = 2;
			this.PlaySE(2009);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(null, 0,40000001.0);

				if (this.y > this.centerY)
				{
					if (this.keyTake <= 2)
					{
						this.SetMotion(this.motion, 3);
					}

					this.SetSpeed_XY(3,00000000.0 * this.direction, 3);
					this.centerStop = 1;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,40000001.0);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;

	if (this.style == 1)
	{
		this.SetMotion(1226, 0);
	}
	else
	{
		this.SetMotion(1225, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(2008);
			this.SetSpeed_XY(7,50000000.0 * this.direction, 0,00000000.0);
			this.AjustCenterStop();
		},
		function ()
		{
			this.PlaySE(2009);
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);

	if (this.style == 1)
	{
		this.SetMotion(1741, 0);
	}
	else
	{
		this.SetMotion(1740, 0);
	}

	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;

	if (this.style == 1)
	{
		this.SetMotion(1231, 0);
	}
	else
	{
		this.SetMotion(1230, 0);
	}

	this.flag2 = 0;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(10,00000000.0 * this.direction, null);
		},
		function ()
		{
			this.PlaySE(2011);
			local t_ = {};
			t_.type <- 1;

			if (this.motion == 1231 || this.motion == 1731)
			{
				t_.type = 0;
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.AtkHighFront_Object, t_);
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(2);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,30000001.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.atk_id = 32;

	if (this.style == 1)
	{
		this.SetMotion(1731, 0);
	}
	else
	{
		this.SetMotion(1730, 0);
	}

	this.flag1 = 0;
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16;

	if (this.style == 1)
	{
		this.SetMotion(1751, 0);
	}
	else
	{
		this.SetMotion(1750, 0);
	}

	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 1,00000000.0, this.va.y * 0,25000000.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
			this.PlaySE(2011);
			local t_ = {};
			t_.type <- 1;

			if (this.motion == 1751)
			{
				t_.type = 0;
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.AtkHighFront_Object, t_);
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}

				this.HitCycleUpdate(2);
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 3);
			this.GetFront();
			this.combo_func = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighFront_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetSpeed_XY(this.va.x * 0,60000002.0, this.va.y * 0,25000000.0);

	if (this.style == 1)
	{
		this.SetMotion(1236, 0);
	}
	else
	{
		this.SetMotion(1235, 0);
	}

	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(2011);
			local t_ = {};
			t_.type <- 1;

			if (this.motion == 1236 || this.motion == 1731)
			{
				t_.type = 0;
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.AtkHighFront_Object, t_);
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}

				this.HitCycleUpdate(2);
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 5);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;

	if (this.style == 1)
	{
		this.SetMotion(1302, 0);
	}
	else
	{
		this.SetMotion(1300, 0);
	}

	this.SetSpeed_XY(10,00000000.0 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2013);
			this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.hitCount = 0;

	if (this.style == 1)
	{
		this.SetMotion(1311, 0);
	}
	else
	{
		this.SetMotion(1310, 0);
	}

	this.SetSpeed_XY(10,00000000.0 * this.direction, null);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(11,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0, 7,50000000.0 * this.direction);

				if (this.hitCount < 4)
				{
					this.HitCycleUpdate(2);
				}
			};
		},
		function ()
		{
			this.PlaySE(2015);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.PlaySE(2017);
			this.HitReset();
			this.hitResult = 1;
			local t_ = {};
			t_.vy <- this.va.y;

			if (this.motion == 1310)
			{
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.HighShot_Dash, t_);
			}
			else
			{
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.HighShot_DashB, t_);
			}

			this.SetSpeed_XY(-11,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Grab_Actor( t )
{
	this.target = this.initTable.pare.target.weakref();
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.target.Warp(this.owner.x + (-(this.owner.target.point0_x - this.owner.target.x) + (this.owner.point0_x - this.owner.x)), this.initTable.pare.y);
	};
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.Warp(this.point0_x, this.y);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1,00000000.0)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1,00000000.0)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.target.DamageGrab_Common(300, 2, -this.direction);
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
	this.flag2 = null;
	this.stateLabel = function ()
	{
		if (this.Atk_Grab_Hit_Update())
		{
			this.flag1.func[0].call(this.flag1);
			this.target.autoCamera = true;
			this.Grab_Blocked(null);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
			this.Atk_Throw(null);
		}
	];
}

function Atk_Throw( t )
{
	this.LabelClear();
	this.SetMotion(1802, 1);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2157);
			this.count = 0;
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(301, 2, -this.direction);
			this.flag1.func[0].call(this.flag1);
			this.target.SetSpeed_XY(-10,00000000.0 * this.target.direction, 0,00000000.0);
			this.target.stateLabel = function ()
			{
				this.VX_Brake(0,60000002.0, 0,00000000.0);
			};
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashB, {});
			this.SetFreeObject(this.target.point0_x, this.target.point0_y - 20, this.direction, this.Grab_Hit_Effect, {}, this.target.weakref()).weakref();
		},
		function ()
		{
			this.PlaySE(2158);
			::camera.shake_radius = 3,00000000.0;
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;

			if (this.flag2)
			{
				this.flag2.func();
			}

			this.HitReset();
			this.hitResult = 1;
			this.target.team.regain_life -= ((this.target.team.regain_life - this.target.team.life) * 0,50000000.0).tointeger();
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
}

function Shot_Normal_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2000, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.flag1 = t;
	this.flag2 = 0,00000000.0;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			local t = {};
			t.rot <- this.flag2;
			t.style <- this.style;
			this.PlaySE(2050);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2005, 0);
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.flag1 = t;
	this.flag2 = 0,00000000.0;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			local t = {};
			t.rot <- this.flag2;
			t.style <- this.style;
			this.PlaySE(2050);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.Shot_Normal_Init(t);
	this.flag2 = -30 * 0,01745329.0;
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.flag2 = -30 * 0,01745329.0;
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.Shot_Normal_Init(t);
	this.flag2 = 30 * 0,01745329.0;
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.flag2 = 30 * 0,01745329.0;
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = t;
	this.flag3 = null;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2053);
		},
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 90);
			this.PlaySE(2054);
			local t = {};
			t.rot <- 0,00000000.0;
			t.style <- this.style;
			this.flag3 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t).weakref();
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2015, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = t;
	this.flag3 = null;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.PlaySE(2053);
		},
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 90);
			this.PlaySE(2054);
			local t = {};
			t.rot <- 0,00000000.0;
			t.style <- this.style;
			this.flag3 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t).weakref();
			this.SetSpeed_XY(-6,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5,00000000.0;
	this.flag2.vy <- 3,00000000.0;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.SetMotion(2020, 0);
	this.flag1 = 1;
	this.flag2 = t.ky;
	this.flag4 = t.charge;
	this.keyAction = [
		function ()
		{
			this.SetMotion(2020, 2);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,20000000.0);
				}
			};
		},
		null,
		function ()
		{
			this.SetSpeed_XY(-7,00000000.0 * this.direction, 0,00000000.0);
			this.hitResult = 1;
			local t_ = {};
			t_.k <- this.flag2;
			t_.style <- this.style;
			t_.charge <- this.flag4;
			t_.rot <- 0,00000000.0;

			if (this.flag2 < 0,00000000.0)
			{
				t_.rot = -20,00000000.0 * 0,01745329.0;
			}

			if (this.flag2 > 0,00000000.0)
			{
				t_.rot = 20,00000000.0 * 0,01745329.0;
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_);
			this.PlaySE(2105);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,00000000.0);
				this.VX_Brake(0,20000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 1,00000000.0);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,20000000.0);
		}
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;
	this.flag2.rot <- -1,04719746.0;
	this.flag2.AddSpeed <- 0,01745329.0;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			if (this.count % 3 == 1)
			{
				this.PlaySE(2050);
				local t_ = {};
				t_.rot <- this.flag2.rot;
				this.SetShot(this.x + 10 * this.direction, this.y - 35, this.direction, this.Shot_Barrage, t_);
				local t_ = {};
				t_.rot <- -this.flag2.rot;
				this.SetShot(this.x + 10 * this.direction, this.y - 35, this.direction, this.Shot_Barrage, t_);
				this.flag2.rot += this.flag2.AddSpeed;
				this.flag2.AddSpeed += 0,50000000.0 * 0,01745329.0;

				if (this.flag2.AddSpeed >= 0,08726646.0)
				{
					this.flag2.AddSpeed = 0,08726646.0;
				}

				if (this.flag2.rot >= 1,57079601.0)
				{
					this.flag2.rot = -1,57079601.0;
					this.flag2.AddSpeed = 0,01745329.0;
				}
			}
		}
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.atk_id = 524288;
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.PlaySE(2128);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.Okult_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(2500, 8);
		},
		function ()
		{
		},
		this.EndtoFreeMove,
		null,
		this.EndtoFreeMove,
		null,
		this.EndtoFreeMove,
		null
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Okult_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(2502, 0);
	this.target.DamageGrab_Common(308, 0, -this.direction);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.flag3 = this.rand() % 2;
	this.flag5 = 1;

	if (this.rand() % 100 <= 49)
	{
		this.flag5 = -1;
	}

	foreach( a in this.styleAura )
	{
		if (a)
		{
			a.func[0].call(a);
		}
	}

	this.styleAura = [];
	this.subState = function ()
	{
		if (this.flag2)
		{
			if (this.flag3 == 0)
			{
				if (this.target.input.x * this.flag5 > 0)
				{
					this.PlaySE(2136);
					this.flag3 = 1;
					this.flag2[0].func[3].call(this.flag2[0]);
					this.flag2[1].func[2].call(this.flag2[1]);
				}
			}
			else if (this.target.input.x * this.flag5 < 0)
			{
				this.PlaySE(2136);
				this.flag3 = 0;
				this.flag2[0].func[2].call(this.flag2[0]);
				this.flag2[1].func[3].call(this.flag2[1]);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.target.x += (this.x - this.target.x) * 0,10000000.0;
		this.target.y += (this.y - this.target.y) * 0,10000000.0;
		this.target.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2135);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.target.SetSpeed_XY(0,00000000.0, 0,00000000.0);

				if (this.count >= 30)
				{
					this.subState();
				}

				if (this.count == 20)
				{
					local t_ = {};

					if (this.flag5 == 1)
					{
						t_.rev <- false;
						t_.fake <- false;

						if (this.rand() % 100 <= 33)
						{
							t_.fake <- true;
						}

						this.flag2 = [
							this.SetFreeObject(this.x - 75, this.y - 75, 1,00000000.0, this.Okult_Select, t_).weakref(),
							this.SetFreeObject(this.x + 75, this.y - 75, -1,00000000.0, this.Okult_Select, t_).weakref()
						];
					}
					else
					{
						t_.rev <- true;
						t_.fake <- false;

						if (this.rand() % 100 <= 33)
						{
							t_.fake <- true;
						}

						this.flag2 = [
							this.SetFreeObject(this.x + 75, this.y - 75, -1,00000000.0, this.Okult_Select, t_).weakref(),
							this.SetFreeObject(this.x - 75, this.y - 75, 1,00000000.0, this.Okult_Select, t_).weakref()
						];
					}

					if (this.flag3 == 0)
					{
						this.flag2[0].func[2].call(this.flag2[0]);
						this.flag2[1].func[3].call(this.flag2[1]);
					}
					else
					{
						this.flag2[0].func[3].call(this.flag2[0]);
						this.flag2[1].func[2].call(this.flag2[1]);
					}
				}

				if (this.count % 3 == 0)
				{
					local t_ = {};
					t_.take <- 0;

					if (this.count % 6 == 0)
					{
						t_.take = 1;
						this.flag1.Add(this.SetFreeObject(this.x, this.y + 50, -this.direction, this.Okult_Aura, t_));
						local t_ = {};
						t_.take <- 3;
						this.flag1.Add(this.SetFreeObject(this.x, this.y + 100, -this.direction, this.Okult_AuraFront, t_));
					}
					else
					{
						this.flag1.Add(this.SetFreeObject(this.x, this.y + 50, this.direction, this.Okult_Aura, t_));
						local t_ = {};
						t_.take <- 2;
						this.flag1.Add(this.SetFreeObject(this.x, this.y + 100, this.direction, this.Okult_AuraFront, t_));
					}
				}

				if (this.count == 50)
				{
					if (this.flag3 > 0)
					{
						this.SetMantType(2);
						this.flag2[1].func[1].call(this.flag2[1]);
						this.flag2[0].func[0].call(this.flag2[0]);
					}
					else
					{
						this.SetMantType(1);
						this.flag2[1].func[1].call(this.flag2[0]);
						this.flag2[0].func[0].call(this.flag2[1]);
					}

					this.styleTime = 1000;
					local t_ = {};
					t_.type <- this.style + 3;
					this.styleAura.append(this.SetFreeObjectDynamic(this.x, this.y + 50, 1,00000000.0, this.Okult_TimeAura, t_).weakref());
					this.flag1.Foreach(function ()
					{
						this.func[0].call(this);
					});
					this.SetMotion(2502, 2);
					this.stateLabel = function ()
					{
						if (this.count == 102)
						{
							local t_ = {};
							t_.type <- this.style + 3;
							this.styleAura.append(this.SetFreeObjectDynamic(this.x, this.y + 50, 1,00000000.0, this.Okult_TimeAura, t_).weakref());
						}
					};
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(2130);
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.target.x = pos_.x;
			this.target.y = pos_.y;
			this.KnockBackTarget(-this.direction);
			this.hitResult = 1;
		}
	];
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 1048576;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = this.Vector3();

	if (this.style == 1)
	{
		this.SetMotion(3001, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A, {});
				this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_Dummy, {});
				this.PlaySE(2100);
				this.SetMotion(3001, 2);
			},
			function ()
			{
			},
			function ()
			{
				this.flag1.x = this.x - 300 * this.direction;
				this.flag1.y = this.y;

				if (this.input.y < 0)
				{
					this.flag1.y = this.centerY - 150;
					this.flag1.x = this.x;
				}

				if (this.input.y > 0)
				{
					this.flag1.y = this.centerY + 150;
					this.flag1.x = this.x;
				}

				if (this.input.x * this.direction > 0)
				{
					this.flag1.x = this.x + 300 * this.direction;
				}

				if (this.input.x * this.direction < 0)
				{
					this.flag1.x = this.x - 300 * this.direction;
				}

				if (this.input.x * this.direction < 0)
				{
					this.flag1.x = this.x - 300 * this.direction;
				}

				this.flag1.x = this.Math_MinMax(this.flag1.x, 20, 1260);
				this.Warp(this.flag1.x, this.flag1.y);

				if (this.y > this.centerY)
				{
					this.centerStop = 2;
				}
				else if (this.y < this.centerY)
				{
					this.centerStop = -2;
				}
				else
				{
					this.centerStop = 0;
				}

				this.GetFront();
				this.warpCount = 1;
				this.PlaySE(2101);
			},
			function ()
			{
				this.GetFront();
			}
		];
	}
	else
	{
		this.SetMotion(3000, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.SetFreeObject(this.x + 5 * this.direction, this.y - 30, this.direction, this.SPShot_A, {});
				this.PlaySE(2100);
			},
			function ()
			{
				this.flag1.x = this.x - 300 * this.direction;
				this.flag1.y = this.y;

				if (this.input.y < 0)
				{
					this.flag1.y = this.centerY - 150;
					this.flag1.x = this.x;
				}

				if (this.input.y > 0)
				{
					this.flag1.y = this.centerY + 150;
					this.flag1.x = this.x;
				}

				if (this.input.x * this.direction > 0)
				{
					this.flag1.x = this.x + 300 * this.direction;
				}

				if (this.input.x * this.direction < 0)
				{
					this.flag1.x = this.x - 300 * this.direction;
				}

				if (this.input.x * this.direction < 0)
				{
					this.flag1.x = this.x - 300 * this.direction;
				}

				this.flag1.x = this.Math_MinMax(this.flag1.x, 20, 1260);
				this.Warp(this.flag1.x, this.flag1.y);

				if (this.y > this.centerY)
				{
					this.centerStop = 2;
				}
				else if (this.y < this.centerY)
				{
					this.centerStop = -2;
				}
				else
				{
					this.centerStop = 0;
				}

				this.GetFront();
				this.warpCount = 1;
			},
			function ()
			{
				this.PlaySE(2101);
			},
			function ()
			{
				this.GetFront();
			}
		];
	}

	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.atk_id = 2097152;
	this.AjustCenterStop();

	if (this.style == 2)
	{
		this.SetMotion(3011, 0);
	}
	else
	{
		this.SetMotion(3010, 0);
	}

	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.type <- 0;

			if (this.flag1 == 6)
			{
				t_.type = 1;
			}

			if (this.flag1 == 4)
			{
				t_.type = 2;
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.PlaySE(2102);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.atk_id = 4194304;
	this.SetMotion(3030, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
			};
			this.PlaySE(2113);
			this.func();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,02500000.0);
				}
			};
		}
	];
	this.func = function ()
	{
		local list_ = [];
		local t_ = {};
		t_.rot <- -45,00000000.0 * 0,01745329.0;
		t_.type <- 4;
		list_.append(this.SetShot(this.x + (100,00000000.0 * this.cos(-t_.rot) + 25) * this.direction, this.y + 100,00000000.0 * this.sin(-t_.rot), this.direction, this.SPShot_C, t_).weakref());
		local t_ = {};
		t_.rot <- 45,00000000.0 * 0,01745329.0;
		t_.type <- 4;
		list_.append(this.SetShot(this.x + (100,00000000.0 * this.cos(-t_.rot) + 25) * this.direction, this.y + 100,00000000.0 * this.sin(-t_.rot), this.direction, this.SPShot_C, t_).weakref());
		local t_ = {};
		t_.rot <- 0,00000000.0 * 0,01745329.0;
		t_.type <- 4;
		list_.append(this.SetShot(this.x + 75,00000000.0 * this.cos(t_.rot) * this.direction, this.y + 75,00000000.0 * this.sin(t_.rot), this.direction, this.SPShot_C, t_).weakref());

		if (this.style == 2)
		{
			local t_ = {};
			t_.rot <- 22,50000000.0 * 0,01745329.0;
			t_.type <- 4;
			list_.append(this.SetShot(this.x + 150,00000000.0 * this.cos(t_.rot) * this.direction, this.y + 150,00000000.0 * this.sin(t_.rot), this.direction, this.SPShot_C, t_).weakref());
			local t_ = {};
			t_.rot <- -22,50000000.0 * 0,01745329.0;
			t_.type <- 4;
			list_.append(this.SetShot(this.x + 150,00000000.0 * this.cos(t_.rot) * this.direction, this.y + 150,00000000.0 * this.sin(t_.rot), this.direction, this.SPShot_C, t_).weakref());
		}

		local t_ = {};
		t_.list <- list_;
		t_.rot <- 0,00000000.0;
		local a_ = this.SetShot(this.x + 75,00000000.0 * this.cos(t_.rot) * this.direction, this.y + 75,00000000.0 * this.sin(t_.rot), this.direction, this.SPShot_C_Root, t_, list_);

		foreach( a in list_ )
		{
			a.hitOwner = a_;
		}
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,02500000.0);
		}
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 8388608;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.SetMotion(3040, 0);

	if (this.style <= 1)
	{
		this.keyAction = [
			function ()
			{
				local t_ = {};
				t_.scale <- 1,00000000.0;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_D_Pure, t_);
				this.PlaySE(2108);
			},
			function ()
			{
				this.team.AddMP(-200, 120);
				this.AjustCenterStop();
				this.stateLabel = function ()
				{
					this.Vec_Brake(0,20000000.0);
				};
				this.PlaySE(2109);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D, {});
			}
		];
	}
	else
	{
		this.keyAction = [
			function ()
			{
				local t_ = {};
				t_.scale <- 1,20000005.0;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_D_Pure, t_);
				this.PlaySE(2108);
			},
			function ()
			{
				this.team.AddMP(-200, 120);
				this.AjustCenterStop();
				this.stateLabel = function ()
				{
					this.Vec_Brake(0,20000000.0);
				};
				this.PlaySE(2109);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D_High, {});
			}
		];
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,20000000.0);
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 16777216;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.SetMotion(3060, 0);
	this.flag3 = {};

	if (t.kx * this.direction > 0)
	{
		this.flag3.rot <- 45 * 0,01745329.0;
	}
	else
	{
		this.flag3.rot <- 60 * 0,01745329.0;
	}

	this.flag3.count <- 15;
	this.flag3.type <- 0;

	if (this.style == 2)
	{
		this.flag3.rad <- 8;
		this.flag3.num <- 7;
		this.flag3.type = 2;
	}
	else
	{
		this.flag3.rad <- 8;
		this.flag3.num <- 7;
	}

	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}

		this.CenterUpdate(0,10000000.0, 3,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(2117);
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.rot <- this.flag3.rot;
			t_.rad <- this.flag3.rad;
			t_.num <- this.flag3.num;
			t_.count <- this.flag3.count;
			t_.type <- this.flag3.type;
			this.SetFreeObject(this.x, ::battle.scroll_top - 100, this.direction, this.SPShot_E_Light, t_);
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}

				this.CenterUpdate(0,10000000.0, 3,00000000.0);

				if (this.count >= 45)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
		}
	];
	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 33554432;
	this.SetSpeed_XY(this.va.x * 0,10000000.0, this.va.y * 0,10000000.0);
	this.AjustCenterStop();
	this.SetMotion(3070, 0);
	this.flag1 = null;
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}

		this.CenterUpdate(0,05000000.0, 1,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(2154);
			this.team.AddMP(-200, 120);

			if (this.style == 2)
			{
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F_Blue, {}).weakref();
			}
			else
			{
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F, {}).weakref();
			}

			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}

				this.CenterUpdate(0,05000000.0, 1,00000000.0);

				if (this.count == 26)
				{
					if (this.flag1)
					{
						this.flag1.func[1].call(this.flag1);
					}
				}

				if (this.count == 33)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.flag1 = null;
					this.lavelClearEvent = null;
				}
			};
		},
		function ()
		{
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = 85;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(2120);
		},
		function ()
		{
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B, t_);
			this.count = 0;
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				if (this.count % 3 == 1 && this.flag1 >= -85)
				{
					this.PlaySE(2121);
					local t_ = {};
					t_.rot <- this.flag1 * 0,01745329.0;
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x, this.y, this.direction, this.SpellShot_B_Ray, t_);
					local t_ = {};
					t_.rot <- this.flag1 * 0,01745329.0;
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x, this.y, -this.direction, this.SpellShot_B_Ray, t_);
					this.flag1 -= 15;
				}

				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = null;
				}
			};
		}
	];
	return true;
}

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4020, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.PlaySE(2123);
	local t_ = {};
	t_.rate <- 1,00000000.0;
	this.flag1 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellShot_C, t_).weakref();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		},
		function ()
		{
			this.hitResult = 1;
			this.team.spell_enable_end = false;
			this.PlaySE(2124);
			this.flag1.func[1].call(this.flag1);
		}
	];
	return true;
}

function Spell_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;

	if (this.style > 0)
	{
		this.flag3 = 1;
	}
	else
	{
		this.flag3 = 0;
	}

	this.flag2 = 80 * 60;

	if (this.flag3)
	{
		this.SetMotion(4031, 0);
	}
	else
	{
		this.SetMotion(4030, 0);
	}

	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.styleTime = 0;
	this.SetMantType(-1);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(2126);
			this.hitResult = 1;
			this.SetSpeed_XY(-25,00000000.0 * this.direction, 0,00000000.0);
			local t_ = {};
			t_.type <- this.flag3;
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_D, t_).weakref();
			this.stateLabel = function ()
			{
				this.Vec_Brake(1,50000000.0, 0,50000000.0);

				if (this.flag1)
				{
					this.Warp.call(this.flag1, this.point0_x, this.point0_y);
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1,50000000.0, 0,50000000.0);

				if (this.flag1)
				{
					this.Warp.call(this.flag1, this.point0_x, this.point0_y);
				}

				this.flag2 -= 80;

				if (this.flag2 <= 0)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,05000000.0);
					};
				}
			};
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = false;
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–“\x2534•\x2569‚\x2554—\x255d•û‘I‚\x256c‚\x2563‚\x2500‚â‚ë‚¤I–");
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
			};
		},
		function ()
		{
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
			this.PlaySE(2131);
			this.SetFreeObject(this.point1_x, this.point1_y, 1,00000000.0, this.Object_Climax_Slash, {});
			this.SetFreeObject(this.point1_x, this.point1_y, -1,00000000.0, this.Object_Climax_Slash, {});
			this.stateLabel = function ()
			{
				if (!this.flag1 && this.hitResult & 1)
				{
					this.invin = this.invinGrab = this.invinObject = -1;
					this.target.DamageGrab_Common(301, 2, this.target.direction);
					this.flag1 = true;
					return;
				}
			};
		},
		function ()
		{
			if (this.flag1)
			{
				this.Spell_Climax_Hit(null);
				return;
			}

			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Object_Climax_Slash( t )
{
	if (this.direction == 1,00000000.0)
	{
		this.SetMotion(4909, 10);
	}
	else
	{
		this.SetMotion(4909, 9);
	}

	this.sy = 2,00000000.0;
	this.rz = -10 * 0,01745329.0;
	this.flag1 = 0,25000000.0;
	this.SetSpeed_XY(10,00000000.0 * this.direction, 6,00000000.0);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,40000001.0);
		this.VY_Brake(0,40000001.0);
		this.sy *= 0,89999998.0;
		this.sx += this.flag1;
		this.flag1 -= 0,07000000.0;

		if (this.flag1 < 0,02500000.0)
		{
			this.flag1 = 0,02500000.0;
		}

		this.alpha -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Effect_ClimaxSpark( t )
{
	this.SetMotion(107, t.take);
	this.rz = t.rot;
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.green = this.blue = 0,00000000.0;
	this.sx = this.sy = 3,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,10000000.0;
		this.count++;

		if (this.count == 3)
		{
			this.Release();
		}
	};
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 0);
	::battle.enableTimeUp = false;
	this.invin = this.invinGrab = this.invinObject = 0;
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.zoom <- 2,00000000.0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640;
	this.flag5.pos.y = 360;
	this.stateLabel = function ()
	{
		if (this.count == 50)
		{
			this.BackFadeOut(0,15000001.0, 0,00000000.0, 0,15000001.0, 30);
			this.FadeOut(0,25000000.0, 0,00000000.0, 0,25000000.0, 30);
		}

		if (this.count == 90)
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.PlaySE(2132);
					this.target.DamageGrab_Common.call(this.target, 301, 2, this.target.direction);
					this.EraceBackGround(true);
					this.x = 640;
					this.y = 360;
					this.target.x = this.x;
					this.target.y = this.y;
					this.SetMotion(4901, 2);
					::camera.SetTarget(this.flag5.pos.x, this.flag5.pos.y, this.flag5.zoom, true);
				}

				if (this.count == 61)
				{
					this.FadeIn(0,25000000.0, 0,00000000.0, 0,25000000.0, 10);
					this.count == 0;
					this.stateLabel = function ()
					{
						this.flag5.zoom -= 0,00350000.0;
						this.target.y += 0,50000000.0;

						if (this.count == 90)
						{
							local a_ = this.SetFreeObject(640, 400, this.direction, this.Climax_CutIn, {});
							this.flag1.Add(a_);
							this.flag2 = a_.weakref();
						}

						if (this.count == 100)
						{
							local t_ = {};
							t_.rot <- -80 * 0,01745329.0;
							t_.take <- 0;
							this.SetEffect(640, 720, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 110)
						{
							local t_ = {};
							t_.rot <- -60 * 0,01745329.0;
							t_.take <- 1;
							this.SetEffect(240, 720, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 180)
						{
							local t_ = {};
							t_.rot <- -30 * 0,01745329.0;
							t_.take <- 0;
							this.SetEffect(0, 680, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 184)
						{
							local t_ = {};
							t_.rot <- -170 * 0,01745329.0;
							t_.take <- 0;
							this.SetEffect(1480, 280, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 250)
						{
							local t_ = {};
							t_.rot <- -160 * 0,01745329.0;
							t_.take <- 1;
							this.SetEffect(1280, 400, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 265)
						{
							local t_ = {};
							t_.rot <- 25 * 0,01745329.0;
							t_.take <- 0;
							this.SetEffect(0, 200, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 267)
						{
							local t_ = {};
							t_.rot <- -90 * 0,01745329.0;
							t_.take <- 2;
							this.SetEffect(480, 780, this.direction, this.Effect_ClimaxSpark, t_);
						}

						if (this.count == 290)
						{
							this.count = 0;
							this.stateLabel = function ()
							{
								this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,20000000.0;
								::camera.SetTarget(this.flag5.pos.x, this.flag5.pos.y, this.flag5.zoom, true);

								if (this.count == 10)
								{
									this.PlaySE(2133);
									this.count = 0;
									this.SetFreeObject(640, 460, 1,00000000.0, this.Climax_Blade, {});
									this.SetFreeObject(640, 460, -1,00000000.0, this.Climax_Blade, {});
									this.stateLabel = function ()
									{
										if (this.count == 10)
										{
											this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 30);
											this.x = 640;
											this.y = 360;
											this.target.x = 640;
											this.target.y = 520;
											this.BackFadeIn(0,15000001.0, 0,00000000.0, 0,15000001.0, 30);
											this.SetMotion(4901, 3);
											this.flag1.Foreach(function ()
											{
												this.ReleaseActor();
											});
											::camera.SetTarget(640, 360, 2,00000000.0, true);
											::camera.ResetTarget();
											this.EraceBackGround(false);
										}

										if (this.count >= 20 && this.count <= 110 && this.count % 10 == 0)
										{
											this.PlaySE(2134);
											::camera.shake_radius = 4,00000000.0;
											this.SetEffect(this.target.x - 50 + this.rand() % 101, this.target.y - 50 + this.rand() % 101, this.direction, this.EF_HitSmashC, {});
											this.KnockBackTarget(-this.direction);
										}

										if (this.count == 150)
										{
											::battle.enableTimeUp = true;
											this.SetMotion(4901, 4);
											this.stateLabel = null;
										}
									};
								}
							};
						}

						::camera.SetTarget(this.flag5.pos.x, this.flag5.pos.y, this.flag5.zoom, true);
					};
				}
			};
		}
	};
}

