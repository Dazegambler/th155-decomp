function Func_BeginBattle()
{
	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.BeginBattleA(null);
		break;

	case 1:
		this.BeginBattleB(null);
		break;
	}
}

function Func_Win()
{
	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.WinA(null);
		break;

	case 1:
		this.WinB(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattleA( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.Warp(this.x, this.y - 960);
	this.centerStop = -2;
	this.stone.func[3].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 30.00000000);
			this.stateLabel = function ()
			{
				if (this.y >= this.centerY)
				{
					this.count = 0;
					this.stone.func[2].call(this.stone);
					this.PlaySE(4258);
					::camera.Shake(6.00000000);
					this.Warp(this.x, this.centerY);
					this.SetSpeed_XY(0.00000000, 3.00000000);
					this.centerStop = 1;
					this.SetMotion(9000, 2);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.PlaySE(4257);
		}
	};
}

function BeginBattleB_Ball( t )
{
	this.SetMotion(9001, 3);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(6.00000000 * this.direction, -4.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.64999998);
			};
		},
		function ()
		{
			this.PlaySE(4259);
			this.rz = 0.78539813;
			this.SetSpeed_Vec(25.00000000, -0.78539813, this.direction);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function BeginBattleB( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 0);
	this.demoObject = [
		null
	];
	this.demoObject[0] = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginBattleB_Ball, {}).weakref();
	this.keyAction = [
		function ()
		{
			this.demoObject[0].func[1].call(this.demoObject[0]);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
			this.demoObject[0].func[2].call(this.demoObject[0]);
		},
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
}

function WinA( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4260);
		},
		function ()
		{
			this.CommonWin();
		}
	];
}

function WinB_Rainbow( t )
{
	this.SetMotion(9011, 3);
	this.DrawActorPriority(100);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.02500000;
		this.sx = this.sy += 0.00100000;
	};
}

function WinB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.demoObject = [
		null
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(4261);
			this.demoObject[0] = this.SetFreeObject(this.x, this.y, 1.00000000, this.WinB_Rainbow, {}).weakref();
		},
		function ()
		{
			this.count = 0;
			this.CommonWin();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Lose( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.CommonLose();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function BeginStory( t )
{
	this.LabelClear();
	this.SetMotion(19, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.y = ::battle.scroll_top - 200;
	this.isVisible = true;

	if (this.team == 2)
	{
		this.Warp(::battle.start_x[1], ::battle.scroll_top - 100);
		this.direction = -1.00000000;
	}
	else
	{
		this.Warp(::battle.start_x[0], ::battle.scroll_top - 100);
		this.direction = 1.00000000;
	}

	this.flag1 = true;
	this.count = 0;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.func[0].call(this);
	});
	this.func = [
		function ()
		{
			this.stateLabel = null;
			this.SetMotion(9002, 0);
		},
		function ()
		{
			this.SetMotion(9002, 2);
			this.SetSpeed_XY(-7.00000000 * this.direction, 0.00000000);
			this.SetEndMotionCallbackFunction(this.EndtoFreeMove);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag1)
		{
			this.y = -200;
			this.centerStop = -2;
			this.flag1 = false;
			return;
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(19, 2);
			this.stateLabel = null;
		}
	};
}

function TalkActionA1( t )
{
	this.LabelClear();
	this.SetMotion(9002, 2);
	this.SetSpeed_XY(-7.00000000 * this.direction, 0.00000000);
	this.keyAction = this.EndtoFreeMove;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
}

function TalkActionA2( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(40, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(12.00000000 * this.direction, 0.00000000);
	this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
	this.DrawActorPriority();
	this.stateLabel = function ()
	{
		if (this.count == 9)
		{
			this.SetMotion(9002, 3);
			this.SetMotion.call(this.target, 9002, 0);
			this.target.keyAction = function ()
			{
				::camera.Shake(5.00000000);
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginStoryFlash, {});
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginStoryFlash2, {});
				this.SetMotion.call(this.target, 9003, 0);
				this.SetSpeed_XY.call(this.target, -17.00000000, 0.00000000);
				this.FadeOut(0, 0, 0, 180);
				this.target.stateLabel = function ()
				{
					if (this.count == 30)
					{
						::trophy.Trophy_PreStoryClear();
					}

					this.VX_Brake(this.va.x * this.direction < -1.50000000 ? 1.75000000 : 0.02500000);

					if (this.count == 40)
					{
						this.ActorTimeStop(600);
					}
				};
			};
			this.stateLabel = function ()
			{
			};
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
	this.SetSpeed_XY(5.50000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5.50000000 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- 17.00000000;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- -17.00000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 17.00000000;
	this.SlideUp_Common(t_);
	this.stone.func[2].call(this.stone);
	local func_ = this.keyAction[0];
	this.keyAction[0] = function ()
	{
		func_();
		this.stone.func[0].call(this.stone);
	};
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- -17.00000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 17.00000000;
	this.C_SlideUp_Common(t_);
	this.stone.func[2].call(this.stone);
	local func_ = this.keyAction[0];
	this.keyAction[0] = function ()
	{
		func_();
		this.stone.func[0].call(this.stone);
	};
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- 17.00000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 17.00000000;
	this.SlideFall_Common(t_);
	this.stone.func[2].call(this.stone);
	local func_ = this.keyAction[0];
	this.keyAction[0] = function ()
	{
		func_();
		this.stone.func[0].call(this.stone);
	};
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- 17.00000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 17.00000000;
	this.C_SlideFall_Common(t_);
	this.stone.func[2].call(this.stone);
	local func_ = this.keyAction[0];
	this.keyAction[0] = function ()
	{
		func_();
		this.stone.func[0].call(this.stone);
	};
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7.00000000;
	this.flag5.vy = 6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7.00000000;
	this.flag5.vy = 6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = -7.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = 7.50000000;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 5.00000000;
	t_.addSpeed <- 0.33000001;
	t_.maxSpeed <- 15.00000000;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 7.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 13.00000000;
	this.DashFront_Air_Common(t_);
	local func_ = this.keyAction[0];
	this.keyAction[0] = function ()
	{
		func_();
		this.stone.func[2].call(this.stone);
	};
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.y > this.centerY && this.va.y > 0.00000000)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2.50000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
}

function DashBack_Air_Init( t )
{
	this.LabelClear();
	this.SetMotion(43, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stone.func[2].call(this.stone);
	this.dashCount++;
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(801);
			this.flag1 = this.y;

			if (this.y <= this.centerY)
			{
				this.centerStop = -2;
				this.SetSpeed_XY(-12.50000000 * this.direction, -2.00000000);
			}
			else
			{
				this.centerStop = 2;
				this.SetSpeed_XY(-12.50000000 * this.direction, 2.00000000);
			}

			this.stone.func[0].call(this.stone);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.34999999, -6.00000000 * this.direction);
				this.CenterUpdate(0.30000001, null);

				if (this.count >= 15)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
}

function Flight_Assult_Init( t )
{
	this.Flight_Assult_Common(t);
	this.flag2 = 10.00000000;
	this.flag4 = 0.26179937;
}

local func_ = this.Guard_Init;
function Guard_Init( t )
{
	func_(t);
	this.stone.func[2].call(this.stone);
}

local func_ = this.JustGuard_Init;
function JustGuard_Init( t )
{
	func_(t);
	this.stone.func[2].call(this.stone);
}

local func_ = this.DamageFinish;
function DamageFinish( t )
{
	func_(t);
	this.stone.func[0].call(this.stone);
}

local func_ = this.SpellCall_Init;
function SpellCall_Init( t )
{
	func_(t);
	this.Vanish_Sword();
	this.stone.func[2].call(this.stone);
	local func_ = this.keyAction[3];
	this.keyAction[3] = function ()
	{
		func_();

		if (this.centerStop * this.centerStop >= 2)
		{
			this.stone.func[0].call(this.stone);
		}
	};
}

function StandAnimal_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.SetMotion(49, 0);
	this.stateLabel = function ()
	{
		this.GetFront();
		this.CenterUpdate(0.75000000, 17.50000000);

		if (this.centerStop == 0)
		{
			if (this.input.y)
			{
				this.SetSpeed_XY(null, this.input.y > 0 ? 17.50000000 : -17.50000000);
				this.centerStop = this.input.y > 0 ? 3 : -3;
				this.graze = 15;
			}
		}

		if (this.input.x)
		{
			this.SetSpeed_XY(this.input.x > 0 ? 4.00000000 : -4.00000000, null);
		}
		else
		{
			this.VX_Brake(0.50000000);
		}

		if (this.debuff_animal.time <= 0)
		{
			this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
			this.stone.func[2].call(this.stone);
			this.EndtoFreeMove();
		}
	};
}

function DamageAnimalBegin_Init( t )
{
	this.LabelClear();
	this.stone.func[4].call(this.stone);
	this.centerStop = -3;

	if (this.y > this.centerY)
	{
		this.centerStop = 3;
	}

	this.direction = t.direction;
	this.SetSpeed_XY(-4.50000000 * this.direction, this.centerStop < 0 ? -10.00000000 : 10.00000000);
	this.SetMotion(289, 0);
	this.count = 0;
	this.flag1 = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.50000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.25000000);
			this.flag1++;

			if (this.flag1 > 30)
			{
				this.StandAnimal_Init(null);
				this.SetSpeed_XY(0.00000000, 0.00000000);
			}
		}
	};
}

function DamageAnimalB_Init( t )
{
	this.LabelClear();
	this.flag1 = this.y;
	this.stone.func[4].call(this.stone);
	this.centerStop = -3;
	this.direction = t.direction;

	switch(t.atkRank)
	{
	case 1:
		this.SetSpeed_XY(-4.50000000 * this.direction, -4.00000000 - this.rand() % 4);
		break;

	case 2:
		this.SetSpeed_XY(-4.50000000 * this.direction, -8.00000000 - this.rand() % 4);
		break;

	default:
		this.SetSpeed_XY(-4.50000000 * this.direction, -3.50000000 - this.rand() % 2);
		break;
	}

	this.SetMotion(289, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.va.y > 0.00000000 && this.y + this.va.y >= this.flag1 || this.count >= 90)
		{
			if (this.debuff_animal.time <= 0)
			{
				this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
				this.stone.func[2].call(this.stone);
				this.EndtoFreeMove();
			}
			else
			{
				this.StandAnimal_Init(null);
				this.SetSpeed_XY(null, this.va.y * 0.50000000);
			}
		}
	};
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4200);
		}
	];
	return true;
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4200);
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.Atk_Mid_Init(t);
	this.SetMotion(1600, 0);
	this.atk_id = 4;
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.SetSpeed_XY(8.00000000 * this.direction, null);
	this.stateLabel = function ()
	{
		this.VX_Brake(0.10000000);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4202);
			this.SetSpeed_XY(4.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	];
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;
	this.SetMotion(1110, 0);
	this.stone.func[0].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4210);
		},
		function ()
		{
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, this.va.y);
			this.PlaySE(4204);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.66000003);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(8.00000000 * this.direction, this.va.y);
			this.PlaySE(4204);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1211, 0);

	if (this.stone)
	{
		this.stone.func[2].call(this.stone);
	}

	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4204);
		},
		function ()
		{
		},
		this.EndtoFreeMove
	];
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.atk_id = 64;
	this.count = 0;
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4206);
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.Atk_HighUpper_Init(t);
	this.SetMotion(1720, 0);
	this.atk_id = 64;
	this.keyAction[0] = function ()
	{
		this.PlaySE(4206);
		this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.atk_id = 512;
	this.count = 0;
	this.SetMotion(1221, 0);
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4206);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
			this.stone.func[0].call(this.stone);
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1700, 0);
	this.atk_id = 32;
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
	this.atk_id = 2048;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(1230, 0);
	this.atk_id = 32;
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4216);
			this.stone.func[0].call(this.stone);
			this.centerStop = -2;
			this.SetSpeed_XY(10.00000000 * this.direction, -4.00000000);
			this.flag1 = this.y;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 1.00000000);
				this.VX_Brake(0.50000000, 6.00000000 * this.direction);

				if (this.va.y > 0.00000000 && this.y >= this.flag1)
				{
					this.centerStop = 1;
					this.stone.func[1].call(this.stone);
					this.SetMotion(this.motion, 2);
					this.PlaySE(4208);
					this.SetSpeed_XY(this.va.x, 3.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(1.00000000);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(1740, 0);
	this.atk_id = 16;
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4206);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.combo_func = null;
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.GetFront();
			this.SetMotion(1110, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
	return true;
}

function Atk_HighFront_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.atk_id = 256;
	this.SetMotion(1231, 0);
	this.flag1 = 0;
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4216);
			this.stone.func[0].call(this.stone);
			this.centerStop = -2;
			this.SetSpeed_XY(10.00000000 * this.direction, -6.50000000);
			this.flag1 = this.y;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 1.00000000);
				this.VX_Brake(0.50000000, 6.00000000 * this.direction);

				if (this.va.y > 0.00000000 && this.y >= this.flag1)
				{
					this.AjustCenterStop();
					this.stone.func[2].call(this.stone);
					this.SetMotion(this.motion, 2);
					this.PlaySE(4208);
					this.SetSpeed_XY(this.va.x, 0.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(1.00000000, 2.00000000 * this.direction);
						this.CenterUpdate(0.25000000, 6.00000000);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(this.motion, 3);
							this.stateLabel = function ()
							{
								this.VX_Brake(1.00000000);
							};
						}
					};
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(1.00000000);
					};
				}
			};
		},
		function ()
		{
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	};
	return true;
}

function Atk_RushCb_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.count = 0;
	this.SetMotion(1740, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4206);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 5.00000000);
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
			this.stone.func[0].call(this.stone);
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 5.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
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
	this.SetMotion(1300, 0);
	this.SetSpeed_XY(8.00000000 * this.direction, null);
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4217);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000, 4.00000000 * this.direction);

				if (this.hitCount <= 3)
				{
					this.HitCycleUpdate(2);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.atk_id = 8192;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	this.SetMotion(1310, 0);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.SetSpeed_XY(14.00000000 * this.direction, 0.00000000);
			this.PlaySE(4219);
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.Shot_Dash, {}).weakref();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000, 3.00000000 * this.direction);
			};
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
		},
		function ()
		{
			this.lavelClearEvent = null;

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		this.EndtoFreeMove
	];
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
		this.target.Warp(this.initTable.pare.point0_x, this.initTable.pare.y);
	};
	return true;
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.Warp(this.point0_x, this.y);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1.00000000)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1.00000000)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
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
	return true;
}

function Atk_Throw( t )
{
	this.LabelClear();
	this.SetMotion(1802, 1);
	this.HitReset();
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(4233);
			this.count = 0;
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
			this.target.DamageGrab_Common(312, 0, -this.direction);
			this.flag1.func[0].call(this.flag1);
			this.target.SetSpeed_XY(8.00000000 * this.direction, 0.00000000);
			this.target.stateLabel = function ()
			{
				this.VX_Brake(0.75000000, -0.20000000 * this.direction);
			};
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashA, {});
			this.stateLabel = function ()
			{
				if (this.count == 22)
				{
					this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
				}

				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
			this.PlaySE(4234);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
			this.KnockBackTarget(-this.direction);
			this.target.DamageGrab_Common(301, 2, -this.direction);
			this.target.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
			this.target.stateLabel = function ()
			{
				this.VX_Brake(0.50000000, -0.20000000 * this.direction);
			};
			this.SetSpeed_XY(0.00000000, 0.00000000);
		},
		function ()
		{
			this.PlaySE(4235);
			::camera.shake_radius = 3.00000000;
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;

			if (this.flag2)
			{
				this.flag2.func();
			}

			this.HitReset();
			this.hitResult = 1;
			this.hitStopTime = 15;
			this.target.team.regain_life -= ((this.target.team.regain_life - this.target.team.life) * 0.50000000).tointeger();
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
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
	this.count = 0;
	this.flag1 = -2;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(4236);

			for( local i = -2; i <= 2; i++ )
			{
				local t = {};
				t.rot <- 0.17453292 * i;
				t.wait <- 15 + i;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.SetSpeed_XY(-9.00000000 * this.direction, 0.00000000);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.stone.func[2].call(this.stone);
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2001, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			this.PlaySE(4236);

			for( local i = -2; i <= 2; i++ )
			{
				local t = {};
				t.rot <- 0.17453292 * i;
				t.wait <- 15 + i;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.SetSpeed_XY(-6.00000000 * this.direction, 3.00000000 * this.flag2);
			this.centerStop = -2 * this.flag2;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		},
		function ()
		{
			this.stone.func[1].call(this.stone);
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			this.PlaySE(4236);

			for( local i = -2; i <= 2; i++ )
			{
				local t = {};
				t.rot <- 0.17453292 * (i - 3);
				t.wait <- 15 + i;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.SetSpeed_XY(-9.00000000 * this.direction, 0.00000000);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.stone.func[2].call(this.stone);
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2001, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			this.PlaySE(4236);

			for( local i = -2; i <= 2; i++ )
			{
				local t = {};
				t.rot <- 0.17453292 * (i - 3);
				t.wait <- 15 + i;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.SetSpeed_XY(-6.00000000 * this.direction, 3.00000000 * this.flag2);
			this.centerStop = -2 * this.flag2;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 1.00000000);
		this.VX_Brake(0.10000000);
	};
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			this.PlaySE(4236);

			for( local i = -2; i <= 2; i++ )
			{
				local t = {};
				t.rot <- 0.17453292 * (i + 3);
				t.wait <- 15 + i;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.SetSpeed_XY(-9.00000000 * this.direction, 0.00000000);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.stone.func[2].call(this.stone);
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2001, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 60);
			this.PlaySE(4236);

			for( local i = -2; i <= 2; i++ )
			{
				local t = {};
				t.rot <- 0.17453292 * (i + 3);
				t.wait <- 15 + i;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.SetSpeed_XY(-6.00000000 * this.direction, 3.00000000 * this.flag2);
			this.centerStop = -2 * this.flag2;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 1.00000000);
		this.VX_Brake(0.10000000);
	};
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(2010, 0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4212);
			this.team.AddMP(-200, 60);
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, null);
			local t_ = {};
			t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);

			if (this.target.centerStop * this.target.centerStop <= 0)
			{
				t_.rot <- 0.00000000;
			}

			t_.rot = this.Math_MinMax(t_.rot, -0.34906584, 0.34906584);
			this.sword = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Front, t_).weakref();
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(2011, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.AjustCenterStop();
	this.flag1 = this.y <= this.centerY ? -1 : 1;
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4212);
			this.AjustCenterStop();
			this.team.AddMP(-200, 60);
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, 4.00000000 * this.flag1);
			this.centerStop = -2 * this.flag1;
			local t_ = {};
			t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -0.34906584, 0.34906584);
			this.sword = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Front, t_).weakref();
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.20000000, 2.00000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.50000000, -2.00000000 * this.direction);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.20000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.20000000, 2.00000000);
	};
	return true;
}

function Shot_FrontCatch_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.PlaySE(4214);

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(2040, 0);
		this.SetSpeed_XY(-7.50000000 * this.direction, 0.00000000);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.33000001);
		};
	}
	else
	{
		this.stone.func[2].call(this.stone);
		this.SetMotion(2041, 0);
		this.AjustCenterStop();
		this.SetSpeed_XY(-7.50000000 * this.direction, -3.00000000);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.33000001, -2.00000000 * this.direction);
			this.CenterUpdate(0.20000000, null);
		};
		this.keyAction = function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.33000001, -2.00000000 * this.direction);
				}
			};
		};
	}

	this.SetEffect(this.point1_x, this.point1_y, this.direction, this.EF_HitSmashA, {});
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.stone.func[1].call(this.stone);
	this.flag2.rot <- 0.00000000;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.Vanish_Sword();

	if (this.shot_charge)
	{
		this.shot_charge.func[0].call(this.shot_charge);
	}

	this.SetMotion(2020, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.count = 0;
	this.flag1 = null;
	this.flag2 = t.ky;
	this.flag3 = false;
	this.flag4 = t.charge;
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			local t_ = {};
			t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -0.52359873, 0.52359873);
			this.shot_charge = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_).weakref();
			this.PlaySE(4266);
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 1.50000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.25000000, -3.00000000 * this.direction);
				}
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
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
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;
	this.flag2.bitRot <- -135 * 0.01745329;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			local c_ = this.count % 30;

			if (c_ == 11)
			{
				local t_ = {};
				t_.rot <- this.flag2.bitRot;
				this.SetShot(this.x, this.y + 75, this.direction, this.Shot_BarrageBit, t_).weakref();
				this.flag2.bitRot *= -1;
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
	this.hitResult = 1;
	this.Vanish_Sword();

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(2500, 0);
	}
	else
	{
		this.SetMotion(2501, 0);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.SetEffect(this.point1_x, this.point1_y, this.direction, this.EF_ChargeO, {});
			this.team.AddMP(-200, 120);
			this.occult_cycle = 15;
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.occult_time = 360;
			this.PlaySE(4262);
			this.occult_back = this.SetFreeObjectDynamic(640, -200, 1.00000000, this.Shot_Occult_Clowd, {}).weakref();
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
	};
	return true;
}

function SP_Ikou_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_Ikou_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3000, 0);
	this.flag1 = this.SetShot(this.point1_x, this.point1_y, this.direction, this.SP_Hisou_Stone, {}).weakref();
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(4221);
			this.flag1.func[1].call(this.flag1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.30000001);
			};
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_Ikou_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
	this.SetMotion(3001, 0);
	this.flag1 = this.SetShot(this.point1_x, this.point1_y, this.direction, this.SP_Hisou_Stone, {}).weakref();
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(4221);
			this.flag1.func[1].call(this.flag1);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 1.00000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		},
		function ()
		{
			this.stone.func[1].call(this.stone);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 1.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function SP_Koma_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_Koma_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0.00000000, this.va.y);
	this.SetMotion(3040, 0);
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(4221);
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.SP_Koma_Shot, {});
			this.SetSpeed_XY(-8.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.30000001);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_Koma_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.stone.func[2].call(this.stone);
	this.SetMotion(3041, 0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(4221);
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.SP_Koma_Shot, {});
			this.SetSpeed_XY(-8.00000000 * this.direction, 0.00000000);
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}

				this.CenterUpdate(0.20000000, 4.00000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		},
		function ()
		{
			this.stone.func[0].call(this.stone);
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}

		this.CenterUpdate(0.20000000, 4.00000000);
	};
	return true;
}

function SP_Kaname_Crash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3010, 0);
	this.PlaySE(4225);
	this.stone.func[2].call(this.stone);
	local t_ = {};
	t_.y <- -1;
	local t2_ = {};
	t2_.y <- 1;
	this.lavelClearEvent = function ()
	{
		foreach( a in this.flag1 )
		{
			if (a)
			{
				a.func[0].call(a);
			}
		}
	};
	this.flag1 = [
		this.SetShot(this.point1_x, this.point1_y, this.direction, this.SP_Kaname_Crash_Stone, t_).weakref(),
		this.SetShot(this.point1_x, this.point1_y, this.direction, this.SP_Kaname_Crash_Stone, t2_).weakref()
	];
	this.keyAction = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[1].call(a);
				}
			}

			this.team.AddMP(-200, 120);
		},
		function ()
		{
			if (this.centerStop * this.centerStop >= 2)
			{
				this.stone.func[1].call(this.stone);
			}
		}
	];
	return true;
}

function SP_Kaname_Jump( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_Kaname_Jump_Air(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(3020, 0);
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4229);
			this.team.AddMP(-200, 120);
			this.Warp(this.x, this.centerY);
			this.centerStop = -3;
			this.SetSpeed_XY(25.00000000 * this.direction, -8.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.50000000, 3.00000000);

				if (this.count >= 12)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.75000000, null);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(this.motion, 4);
							this.stateLabel = function ()
							{
								this.VX_Brake(0.50000000);
							};
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function SP_Kaname_Jump_Air( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3021, 0);
	this.stone.func[2].call(this.stone);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.flag1 = this.y;
			this.stone.func[3].call(this.stone);
			this.SetShot(this.x, this.y, this.direction, this.SPShot_Kaname_Drop, {});
			this.PlaySE(4229);
			this.team.AddMP(-200, 120);
			this.centerStop = -3;
			this.SetSpeed_XY(25.00000000 * this.direction, -8.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.50000000, 3.00000000);

				if (this.count >= 12)
				{
					this.centerStop = -2;
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0.00000000, 0.75000000, 0.00000000, 10.00000000);

						if (this.va.y > 0.00000000 && (this.y > this.flag1 || this.IsGround(this.va.y)))
						{
							if (this.y > this.centerY)
							{
								this.SetSpeed_XY(null, this.va.y * 0.50000000);
							}

							this.EndtoFallLoop();
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.50000000);
	};
	return true;
}

function SP_Hisou_Charge( t )
{
	this.SetMotion(3039, 2);
	this.sx = this.sy = t.scale;
	this.flag1 = 0.15000001 * t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag1;
		this.flag1 *= 0.93000001;
		this.alpha = this.blue = this.green -= 0.05000000;
	};
}

function SP_Hisou_Slash( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_Hisou_Slash_Air(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(3030, 0);
	this.flag1 = null;
	this.flag2 = 1.00000000;
	this.flag3 = true;
	this.stone.func[2].call(this.stone);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(4275);
			this.stateLabel = function ()
			{
				if (this.flag3 && (this.input.b2 == 0 || ::battle.state != 8))
				{
					this.flag3 = false;
				}

				if (this.count == 25)
				{
					this.SetMotion(this.motion, 2);
					this.PlaySE(4231);
					this.flag2 = 1.50000000;
					local t_ = {};
					t_.scale <- 1.00000000;
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SP_Hisou_Charge, t_);
				}

				if (this.count == 75)
				{
					this.SetMotion(this.motion, 3);
					this.flag2 = 2.00000000;
					this.PlaySE(4231);
					local t_ = {};
					t_.scale <- 2.00000000;
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SP_Hisou_Charge, t_);
				}

				this.VX_Brake(1.00000000);

				if (this.count >= 4 && this.flag3 == false)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
					return;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(4230);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(12.00000000 * this.direction, 0.00000000);
			local t_ = {};
			t_.scale <- this.flag2;
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SP_Hisou_Slash_Blade, t_).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
		},
		function ()
		{
			this.lavelClearEvent = null;
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag3 && (this.input.b2 == 0 || ::battle.state != 8))
		{
			this.flag3 = false;
		}

		this.VX_Brake(1.00000000);
	};
	return true;
}

function SP_Hisou_Slash_Air( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(3031, 0);
	this.flag1 = null;
	this.flag2 = 1.00000000;
	this.flag3 = true;
	this.stone.func[2].call(this.stone);
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(4275);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(1.00000000);
				}

				if (this.flag3 && (this.input.b2 == 0 || ::battle.state != 8))
				{
					this.flag3 = false;
				}

				if (this.count == 25)
				{
					this.SetMotion(this.motion, 2);
					this.PlaySE(4231);
					this.flag2 = 1.50000000;
					local t_ = {};
					t_.scale <- 1.00000000;
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SP_Hisou_Charge, t_);
				}

				if (this.count == 75)
				{
					this.SetMotion(this.motion, 3);
					this.flag2 = 2.00000000;
					this.PlaySE(4231);
					local t_ = {};
					t_.scale <- 2.00000000;
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SP_Hisou_Charge, t_);
				}

				if (this.count >= 4 && this.flag3 == false)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 2.00000000);

						if (this.centerStop == 0)
						{
							this.VX_Brake(1.00000000);
						}
					};
					return;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(4230);
			this.team.AddMP(-200, 120);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(12.00000000 * this.direction, 0.00000000);
			}
			else
			{
				this.SetSpeed_XY(0.00000000, 0.00000000);
			}

			local t_ = {};
			t_.scale <- this.flag2;
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SP_Hisou_Slash_Blade, t_).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		},
		function ()
		{
			this.lavelClearEvent = null;
		},
		function ()
		{
			this.stone.func[1].call(this.stone);
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag3 && (this.input.b2 == 0 || ::battle.state != 8))
		{
			this.flag3 = false;
		}

		this.CenterUpdate(0.05000000, 2.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(1.00000000);
		}
	};
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(4000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.stone.func[2].call(this.stone);
	this.flag5 = ::manbow.Actor2DProcGroup();
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
			this.hitResult = 1;
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 1)
				{
					this.PlaySE(4245);
					local se_ = 4246;

					for( local i = 0; i <= 3; i++ )
					{
						for( local j = 0; j <= 2; j++ )
						{
							local r_ = (i * 120 + j * 10) * 0.01745329;
							this.vec.x = this.cos(r_) * 1200;
							this.vec.y = this.sin(r_) * 1200;
							local t_ = {};
							t_.rot <- r_;
							t_.se <- se_;
							this.SetShot(this.target.x - this.vec.x * this.direction, this.target.y - this.vec.y, this.direction, this.SpellShot_A, t_);
							se_ = 0;
						}
					}
				}

				if (this.count == 31)
				{
					this.PlaySE(4245);
					local se_ = 4246;

					for( local i = 0; i <= 3; i++ )
					{
						for( local j = 0; j <= 2; j++ )
						{
							local r_ = (i * 120 + j * 10 + 50) * 0.01745329;
							this.vec.x = this.cos(r_) * 1200;
							this.vec.y = this.sin(r_) * 1200;
							local t_ = {};
							t_.rot <- r_;
							t_.se <- se_;
							this.SetShot(this.target.x - this.vec.x * this.direction, this.target.y - this.vec.y, this.direction, this.SpellShot_A, t_);
							se_ = 0;
						}
					}
				}

				if (this.count == 61)
				{
					this.PlaySE(4245);
					local se_ = 4248;

					for( local i = 0; i <= 18; i++ )
					{
						local r_ = i * 0.34906584;
						this.vec.x = this.cos(r_) * 1200;
						this.vec.y = this.sin(r_) * 1200;
						local t_ = {};
						t_.rot <- r_;
						t_.se <- se_;
						this.SetShot(this.target.x - this.vec.x * this.direction, this.target.y - this.vec.y, this.direction, this.SpellShot_A, t_);
						se_ = 0;
					}

					this.stateLabel = null;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			if (this.centerStop * this.centerStop >= 2)
			{
				this.stone.func[0].call(this.stone);
			}
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(4010, 0);
	this.atk_id = 67108864;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4249);
			this.centerStop = -3;
			this.SetSpeed_XY(7.50000000 * this.direction, -10.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000, 4.50000000 * this.direction);
				this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 0.33000001 : 0.10000000);
			};
		},
		function ()
		{
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.UseSpellCard(60, -this.team.sp_max);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.HitReset();
			this.PlaySE(4251);
			this.count = 0;
			this.centerStop = 3;
			this.SetSpeed_XY(0.00000000, 35.00000000);
			this.stateLabel = function ()
			{
				if (this.ground)
				{
					::camera.Shake(5.00000000);
					this.SetMotion(this.motion, 6);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 10)
						{
							this.hitResult = 1;
							this.PlaySE(4253);
							this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SpellShot_B, {}).weakref();
							this.lavelClearEvent = function ()
							{
								if (this.flag1)
								{
									this.flag1.func[0].call(this.flag1);
								}

								this.flag1 = null;
							};
							::camera.Shake(25.00000000);
							this.SetSpeed_XY(0.00000000, -15.00000000);
							this.count = 0;
							this.stateLabel = function ()
							{
								if (this.count == 10)
								{
									this.stateLabel = function ()
									{
										this.VY_Brake(2.00000000);
									};
								}
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
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.flag1 = null;
			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.15000001, 6.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 9);
					this.stateLabel = function ()
					{
					};
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
	this.hitResult = 1;
	this.Vanish_Sword();
	this.SetMotion(4020, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stone.func[2].call(this.stone);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(4254);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			::camera.shake_radius = 10.00000000;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellShot_C_Aura, {});

			if (!this.momo_aura)
			{
				this.momo_aura = this.SetFreeObject(this.x, this.y, 1.00000000, this.SpellShot_C_AuraB, {}).weakref();
			}

			this.momo_time = 300;
			this.armor = -1;
			this.PlaySE(4255);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			if (this.centerStop * this.centerStop >= 2)
			{
				this.stone.func[0].call(this.stone);
			}
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.Vanish_Sword();
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = false;
	this.flag2 = false;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "ÅñëÂãCåóÇ\x2550â‰Ç™éËíÜÇ\x2554Ç†ÇËÅñ");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
		},
		function ()
		{
			this.lavelClearEvent = function ()
			{
				this.flag3.Foreach(function ()
				{
					this.func[0].call(this);
				});
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
			this.PlaySE(4238);
			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
			local t_ = {};
			t_.rot <- 0.00000000;
			t_.rate <- this.atkRate_Pat;
			local a_ = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_, null);
			this.flag1 = a_.weakref();
			this.flag3.Add(a_);
			local t_ = {};
			t_.rot <- 40.00000000 * 0.01745329;
			t_.rate <- this.atkRate_Pat;
			this.flag3.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_, a_));
			local t_ = {};
			t_.rot <- -40.00000000 * 0.01745329;
			t_.rate <- this.atkRate_Pat;
			this.flag3.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_, a_));
			local t_ = {};
			t_.rot <- 80.00000000 * 0.01745329;
			t_.rate <- this.atkRate_Pat;
			this.flag3.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_, a_));
			local t_ = {};
			t_.rot <- -80.00000000 * 0.01745329;
			t_.rate <- this.atkRate_Pat;
			this.flag3.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_, a_));
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag1 && this.flag1.hitResult & 1)
				{
					this.Spell_Climax_Hit();
					return;
				}

				if (this.count >= 40)
				{
					this.lavelClearEvent = function ()
					{
						this.lastword.Deactivate();
						::battle.enableTimeUp = true;
					};
					this.flag3.Foreach(function ()
					{
						this.func[1].call(this);
					});
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_Climax_Hit()
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	::battle.enableTimeUp = false;
	this.target.DamageGrab_Common(300, 2, this.target.direction);
	this.count = 0;
	this.flag5 = {};
	this.flag5.haarp <- null;
	this.flag5.zoom <- 1.20000005;
	this.BackFadeOut(0.00000000, 0.00000000, 0.00000000, 60);
	this.func = [
		function ()
		{
			this.PlaySE(4240);
			this.count = 0;
			this.EraceBackGround();
			this.flag5.haarp = this.SetFreeObject(640, 720, this.direction, this.Climax_HAARP, {}).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 150)
				{
					this.FadeOut(1.00000000, 1.00000000, 1.00000000, 30);
					this.autoCamera = true;
				}

				if (this.count >= 120)
				{
					::camera.SetTarget(640, 360, this.flag5.zoom, false);
					this.flag5.zoom -= 0.00100000;
					::camera.Shake(5.00000000);
					this.AddSpeed_XY(0.00000000, this.va.y > -5.00000000 ? -0.15000001 : -0.50000000);
				}

				if (this.count == 210)
				{
					if (this.flag5.haarp)
					{
						this.flag5.haarp.ReleaseActor();
					}

					this.Spell_Climax_SceneA(null);
					return;
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Spell_Climax_SceneA( t )
{
	this.LabelReset();
	this.HitReset();
	this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 20);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(4901, 1);
	this.target.DamageGrab_Common(308, 0, this.target.direction);
	this.count = 0;
	this.flag5 = {};
	this.flag5.back <- this.SetFreeObject(640, 360, 1.00000000, this.Climax_Screen, {}).weakref();
	this.flag5.clowd <- this.SetFreeObjectDynamic(640, 360, 1.00000000, this.Climax_Clowd, {}).weakref();
	this.flag5.face <- this.SetFreeObject(640, 600, 1.00000000, this.Climax_Cut, {}).weakref();
	this.PlaySE(4241);
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			local t_ = {};
			t_.scale <- 1.00000000;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 190)
		{
			local t_ = {};
			t_.scale <- 1.20000005;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 210)
		{
			local t_ = {};
			t_.scale <- 1.20000005;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 280)
		{
			local t_ = {};
			t_.scale <- 1.50000000;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 320)
		{
			local t_ = {};
			t_.scale <- 2.20000005;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 380)
		{
			local t_ = {};
			t_.scale <- 2.09999990;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 420)
		{
			local t_ = {};
			t_.scale <- 2.79999995;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 425)
		{
			local t_ = {};
			t_.scale <- 2.79999995;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSparkB, t_);
		}

		if (this.count == 450)
		{
			local t_ = {};
			t_.scale <- 3.00000000;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSpark, t_);
		}

		if (this.count == 460)
		{
			local t_ = {};
			t_.scale <- 3.20000005;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSparkB, t_);
		}

		if (this.count == 465)
		{
			local t_ = {};
			t_.scale <- 4.09999990;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSparkB, t_);
		}

		if (this.count >= 475 && this.count % 4 == 1)
		{
			local t_ = {};
			t_.scale <- 4.09999990 + this.count * 0.01000000;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ClowdSparkB, t_);
		}

		if (this.count == 520)
		{
			this.PlaySE(4242);
			this.FadeOut(1.00000000, 1.00000000, 1.00000000, 9);
			this.flag5.face.func[1].call(this.flag5.face);
			this.flag5.clowd.func[1].call(this.flag5.clowd);
		}

		if (this.count == 530)
		{
			this.flag5.clowd.func[0].call(this.flag5.clowd);
			this.flag5.back.func[0].call(this.flag5.back);
			this.flag5.face.func[0].call(this.flag5.face);
			this.Spell_Climax_Finish(null);
			return;
		}
	};
}

function Spell_Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.BackColorFilter(0.80000001, 0, 0, 0, 1);
	this.count = 0;
	this.SetMotion(4901, 2);
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.cycle <- 0;
	this.flag5.hit <- null;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.Warp(640 - 320 * this.direction, this.centerY - 180);
	this.PlaySE(4243);
	this.EraceBackGround(false);
	::camera.ResetTarget();
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};
	this.Warp(this.x, this.y - 75);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 20);
	::camera.Shake(20.00000000);
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag5.hit = this.SetShot(640 - 640 * this.direction, 0, this.direction, this.Climax_HitBox, t_).weakref();
	this.target.DamageGrab_Common(200, 0, this.target.direction);
	this.func = [
		function ()
		{
			this.BackColorFilterOut(0.80000001, 0, 0, 0, 10);
			this.SetMotion(4901, 3);
			this.centerStop = -2;
			this.flag5.hit.func[0].call(this.flag5.hit);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4901, 5);
					this.stateLabel = null;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag5.cycle--;

		if (this.flag5.cycle <= 0)
		{
			::camera.Shake(6.00000000);
			this.flag5.cycle = 2 + this.rand() % 6;
			this.SetFreeObject(this.rand() % 1280, 0, 1.00000000 - this.rand() % 21 * 0.10000000, this.Climax_Lightning, {});
		}

		if (this.count == 180)
		{
			this.func[0].call(this);
		}
	};
}

