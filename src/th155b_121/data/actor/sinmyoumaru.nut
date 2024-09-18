function Func_BeginBattle()
{
	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.BeginBattle(null);
		break;

	case 1:
		this.BeginBattle(null);
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

function BeginBattle( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.x = 640 + 480 * this.direction;
	this.direction = -this.direction;
	this.y = this.centerY + 50;
	this.func = [
		function ()
		{
			this.PlaySE(3486);
			this.count = 0;
			this.centerStop = -2;
			this.SetSpeed_XY(25.00000000 * this.direction, -2.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, -0.30000001);
				this.VX_Brake(0.30000001);

				if (this.count == 60)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);

					if (this.team.index == 0)
					{
						this.direction = 1.00000000;
						this.x = ::battle.start_x[0];
					}
					else
					{
						this.direction = -1.00000000;
						this.x = ::battle.start_x[1];
					}

					this.y = 0;
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.69999999, 15.00000000);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(9000, 1);
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		}
	];
	this.keyAction = [
		null,
		null,
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
			this.func[0].call(this);
		}
	};
}

function WinA( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(9010, 0);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (::battle.state == 32 && (this.count % 48 == 8 || this.count % 48 == 32))
				{
					this.flag1++;
					this.PlaySE(3487);
				}

				if (this.count == 150)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinB( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(9011, 0);
	this.count = 0;
	this.flag1 = this.y;
	this.func = [
		function ()
		{
			this.PlaySE(3488);
			this.SetSpeed_XY(2.00000000 * this.direction, -7.00000000);
		},
		function ()
		{
			this.PlaySE(3488);
			this.SetSpeed_XY(-4.00000000 * this.direction, -8.50000000);
		},
		function ()
		{
			this.PlaySE(3489);
			this.SetSpeed_XY(0.00000000, -28.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.CommonWin();
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.75000000);

				if (this.y > this.flag1)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.y = this.flag1;
				}

				if (this.count == 5)
				{
					this.func[0].call(this);
				}

				if (this.count == 25)
				{
					this.func[1].call(this);
				}

				if (this.count == 50)
				{
					this.func[2].call(this);
				}
			};
		}
	];
}

function Lose( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 16 == 1)
				{
					this.PlaySE(3490);
				}

				if (this.count == 90)
				{
					this.CommonLose();
				}
			};
		}
	];
}

function Stand_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.Stand;
	this.SetMotion(0, 0);
}

function WalkSprash( t )
{
	this.SetMotion(9050, 0);
	this.keyAction = this.ReleaseActor;
}

function MoveFront_Init( t )
{
	this.LabelClear();
	this.count = 0;
	this.subState = function ()
	{
		if (this.count % 30 == 22)
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
		}
	};
	this.stateLabel = this.MoveFront;
	this.SetMotion(1, 0);
	this.SetSpeed_XY(6.00000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.count = 0;
	this.subState = function ()
	{
		if (this.count % 30 == 10)
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
		}
	};
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-6.00000000 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- -17.00000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 17.00000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- -16.00000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 17.00000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- 17.00000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 17.00000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- 17.00000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 17.00000000;
	this.C_SlideFall_Common(t_);
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
	t_.speed <- 8.50000000;
	t_.addSpeed <- 0.34999999;
	t_.maxSpeed <- 16.00000000;
	t_.wait <- 120;
	this.DashFront_Common(t_);
	this.subState = function ()
	{
		if (this.count % 12 == 10)
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
		}
	};
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 9.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0.12500000;
	t_.maxSpeed <- 14.00000000;
	this.DashFront_Air_Common(t_);
	this.subState = function ()
	{
		if (this.count % 12 == 10)
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
		}
	};
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.y > this.centerY && this.va.y > 0.00000000)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2.50000000);
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -8.50000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 30;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 13.00000000;
	this.DashBack_Air_Common(t_);
	this.subState = function ()
	{
		if (this.count % 12 == 10)
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WalkSprash, {});
		}
	};
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3400);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3402);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(5.00000000 * this.direction, null);
			this.PlaySE(3404);
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, null);
			this.PlaySE(3406);
		}
	];
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;
	this.SetMotion(1110, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3404);
		},
		null,
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
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
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
	this.flag1 = true;
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(8.50000000 * this.direction, -8.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 0.50000000 : 0.01000000);
				this.AddSpeed_XY(0.00000000, 1.50000000);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.PlaySE(3408);
					this.centerStop = 1;
					this.SetMotion(this.motion, 2);
					this.SetSpeed_XY(null, 5.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.33000001);
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(1.00000000 * this.direction, 10.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.25000000);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(this.motion, 3);
					this.SetSpeed_XY(null, 3.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.33000001);
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

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, -8.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 0.50000000 : 0.01000000);
				this.AddSpeed_XY(0.00000000, 0.94999999);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.PlaySE(3410);
					this.centerStop = 1;
					this.SetMotion(this.motion, 2);
					this.SetSpeed_XY(null, 5.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.33000001);
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(1.00000000 * this.direction, 10.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.25000000);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(this.motion, 3);
					this.SetSpeed_XY(null, 3.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.33000001);
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

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.flag1 = true;
	this.SetMotion(1211, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3408);
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
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1211, 2);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
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
	this.SetMotion(1220, 0);
	this.PlaySE(3477);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3412);
			this.SetSpeed_Vec(14.00000000, -30.00000000 * 0.01745329, this.direction);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.75000000, 2.00000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.75000000 : 0.05000000);
				this.AddSpeed_XY(0.00000000, 0.75000000);

				if (this.va.y > 0.00000000 && this.y >= this.centerY)
				{
					this.SetMotion(this.motion, 3);
					this.SetSpeed_XY(null, 3.00000000);
					this.centerStop = 1;
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
				this.VX_Brake(0.75000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.PlaySE(3477);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3414);
			this.SetSpeed_Vec(14.00000000, -30.00000000 * 0.01745329, this.direction);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.75000000, 2.00000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.75000000 : 0.05000000);
				this.AddSpeed_XY(0.00000000, 0.75000000);

				if (this.va.y > 0.00000000 && this.y >= this.centerY)
				{
					this.SetMotion(this.motion, 3);
					this.SetSpeed_XY(null, 3.00000000);
					this.centerStop = 1;
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
				this.VX_Brake(0.75000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.PlaySE(3477);
	this.func = function ()
	{
		this.SetMotion(1221, 3);
		this.SetSpeed_XY(null, 4.00000000);
		this.centerStop = 1;
		this.stateLabel = function ()
		{
			this.VX_Brake(0.75000000);
		};
	};
	this.keyAction = [
		function ()
		{
			this.flag1 = this.y;
			this.PlaySE(3412);
			this.SetSpeed_Vec(14.00000000, -30.00000000 * 0.01745329, this.direction);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.75000000, 2.00000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.75000000 : 0.05000000);
				this.AddSpeed_XY(0.00000000, 0.75000000);

				if (this.va.y > 0.00000000 && this.y >= this.flag1)
				{
					this.SetMotion(this.motion, 3);
					this.SetSpeed_XY(null, 3.00000000);
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
				this.VX_Brake(0.75000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.00000000);
		this.CenterUpdate(0.00000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.SetSpeed_XY(null, 3.00000000);
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
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1730, 0);
	this.PlaySE(3478);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(15.50000000 * this.direction, null);
			this.PlaySE(3418);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 3.00000000 ? 1.25000000 : 0.25000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.60000002);
	};
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1740, 0);
	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1230, 0);
	this.PlaySE(3478);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, null);
			this.PlaySE(3416);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 3.00000000 ? 1.25000000 : 0.25000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.60000002);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.Atk_HighUpper_Air_Init(t);
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 4);
			this.GetFront();
			this.combo_func = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
	return true;
}

function Atk_RushB_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16;
	this.SetMotion(1741, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3408);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1741, 2);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
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
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 4);
			this.GetFront();
			this.combo_func = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
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
	this.SetMotion(1231, 0);
	this.PlaySE(3478);
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1231, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3416);
			this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.34999999, 3.00000000);
				this.subState();
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				this.subState();
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.75000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1300, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.PlaySE(3420);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.50000000, 0.00000000);
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
	this.atk_id = 8192;
	this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
	};
	this.SetMotion(1310, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(3483);
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(4);

				if (this.count >= 25)
				{
					this.SetSpeed_XY(11.00000000 * this.direction, 0.00000000);
					this.HitTargetReset();
					this.SetMotion(1310, 2);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
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
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
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
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3495);
			this.count = 0;
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.flag1.func[0].call(this.flag1);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 16 == 4)
				{
					this.PlaySE(3493);
					::camera.Shake(4.00000000);
					this.SetEffect(this.x + 40 - this.rand() % 81, this.y - 20 + this.rand() % 40, this.direction, this.EF_HitSmashB, {});
				}

				if (this.count == 64)
				{
					this.SetMotion(this.motion, 4);
					this.target.DamageGrab_Common(301, 0, -this.direction);
					this.target.Warp(this.point0_x - (this.target.point0_x - this.target.x), this.point0_y - (this.target.point0_y - this.target.y));
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(3494);
			this.target.Warp(this.point0_x, this.point0_y);
			::camera.Shake(6.00000000);
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;
			this.HitReset();
			this.hitResult = 1;
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
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.34999999);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3430);
			this.count = 0;
			local t = {};
			t.v <- 12.50000000;
			t.rot <- -8.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -15.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 4)
				{
					local t = {};
					t.v <- 11.50000000;
					t.rot <- -1.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 6)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -6.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 8)
				{
					local t = {};
					t.v <- 11.00000000;
					t.rot <- -4.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				this.CenterUpdate(0.10000000, null);
				this.VX_Brake(0.10000000);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
}

function Shot_Normal_Air_Init( t )
{
	this.Shot_Normal_Init(t);
	this.SetMotion(2001, 0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3430);
			this.count = 0;
			local t = {};
			t.v <- 12.50000000;
			t.rot <- -8.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -15.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 4)
				{
					local t = {};
					t.v <- 11.50000000;
					t.rot <- -1.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 6)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -6.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 8)
				{
					local t = {};
					t.v <- 11.00000000;
					t.rot <- -4.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				this.CenterUpdate(0.10000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.10000000);
				}
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
				else
				{
					this.VX_Brake(0.10000000);
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
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
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.34999999);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3430);
			this.count = 0;
			local t = {};
			t.v <- 12.50000000;
			t.rot <- 42.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- 35.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 4)
				{
					local t = {};
					t.v <- 11.50000000;
					t.rot <- 49.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 6)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- 44.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 8)
				{
					local t = {};
					t.v <- 11.00000000;
					t.rot <- 46.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				this.CenterUpdate(0.10000000, null);
				this.VX_Brake(0.10000000);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
}

function Shot_Normal_Under_Air_Init( t )
{
	this.Shot_Normal_Under_Init(t);
	this.SetMotion(2001, 0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3430);
			this.count = 0;
			local t = {};
			t.v <- 12.50000000;
			t.rot <- 42.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- 35.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 4)
				{
					local t = {};
					t.v <- 11.50000000;
					t.rot <- 49.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 6)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- 44.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 8)
				{
					local t = {};
					t.v <- 11.00000000;
					t.rot <- 46.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				this.CenterUpdate(0.10000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.10000000);
				}
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
				else
				{
					this.VX_Brake(0.10000000);
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
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
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.34999999);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3430);
			this.count = 0;
			local t = {};
			t.v <- 12.50000000;
			t.rot <- -58.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -65.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 4)
				{
					local t = {};
					t.v <- 11.50000000;
					t.rot <- -51.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 6)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -56.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 8)
				{
					local t = {};
					t.v <- 11.00000000;
					t.rot <- -54.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				this.CenterUpdate(0.10000000, null);
				this.VX_Brake(0.10000000);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.Shot_Normal_Upper_Init(t);
	this.AjustCenterStop();
	this.SetMotion(2001, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3430);
			this.count = 0;
			local t = {};
			t.v <- 12.50000000;
			t.rot <- -58.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -65.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 4)
				{
					local t = {};
					t.v <- 11.50000000;
					t.rot <- -51.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 6)
				{
					local t = {};
					t.v <- 12.00000000;
					t.rot <- -56.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.count == 8)
				{
					local t = {};
					t.v <- 11.00000000;
					t.rot <- -54.00000000 * 0.01745329;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.10000000);
				}
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
				else
				{
					this.VX_Brake(0.10000000);
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.flag1 = 4;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3432);
			this.count = 0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.Shot_Front, {});
		},
		function ()
		{
			if (this.flag1 <= 0)
			{
				this.SetMotion(this.motion, 3);
			}
		},
		function ()
		{
			if (this.flag1 > 0)
			{
				this.flag1--;
				this.PlaySE(3432);
				this.SetMotion(this.motion, 1);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			}
			else
			{
				this.SetMotion(this.motion, 3);
			}
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.SetMotion(2011, 0);
	this.count = 0;
	this.flag1 = 4;
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3432);
			this.count = 0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.Shot_Front, {});
		},
		function ()
		{
			if (this.flag1 <= 0)
			{
				this.SetMotion(this.motion, 3);
			}
		},
		function ()
		{
			if (this.flag1 > 0)
			{
				this.flag1--;
				this.PlaySE(3432);
				this.SetMotion(this.motion, 1);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			}
			else
			{
				this.SetMotion(this.motion, 3);
			}
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
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.25000000);
		}
	};
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5.00000000;
	this.flag2.vy <- 3.00000000;
	this.subState = function ()
	{
	};
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();

	if (t.charge)
	{
		this.SetMotion(2021, 0);
	}
	else
	{
		this.SetMotion(2020, 0);
	}

	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.count = 0;
	this.flag3 = true;
	this.flag4 = t.charge;
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.hitResult = 1;

			if (this.flag4)
			{
				local t_ = {};
				t_.charge <- 0;
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull, t_).weakref();
				this.PlaySE(3434);
			}
			else
			{
				local t_ = {};
				t_.charge <- 0;
				t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				t_.rot = this.Math_MinMax(t_.rot, -0.52359873, 0.52359873);
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_).weakref();
				this.PlaySE(3434);
			}
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
		this.Vec_Brake(0.50000000);
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			if (this.count % 4 == 1)
			{
				this.PlaySE(3496);
			}

			if (this.count % 2 == 1)
			{
				local t_ = {};
				t_.rot <- this.rand() % 360 * 0.01745329;
				t_.v <- 4.00000000 + this.rand() % 6;
				this.SetShot(this.x - 45 + this.rand() % 91, this.y - this.rand() % 20, this.direction, this.Shot_Barrage, t_);
				this.SetShot(this.x - 45 + this.rand() % 91, this.y + 20 - this.rand() % 20, this.direction, this.Shot_Barrage_DummyBack, t_);
				this.SetShot(this.x - 45 + this.rand() % 91, this.y + 20 - this.rand() % 20, this.direction, this.Shot_Barrage_Dummy, t_);
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
	this.SetMotion(2500, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag2[0].x = 2.00000000;
	this.flag2[0].y = -5.19999981;
	this.flag2[1].x = -1.00000000;
	this.flag2[1].y = -7.50000000;
	this.flag2[2].x = 0.50000000;
	this.flag2[2].y = -6.50000000;
	this.flag2[3].x = -2.09999990;
	this.flag2[3].y = -5.50000000;
	this.flag2[4].x = 1.50000000;
	this.flag2[4].y = -4.50000000;
	this.flag2[5].x = -0.80000001;
	this.flag2[5].y = -6.50000000;
	this.flag2[6].x = 0.75000000;
	this.flag2[6].y = -8.50000000;
	this.flag3 = 5;
	this.kobito.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.kobito.Clear();
	this.keyAction = [
		function ()
		{
			this.HitReset();
			this.hitResult = 1;
			this.count = 0;
			this.PlaySE(3437);
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);

				if (this.count % 4 == 1 && this.flag1 < this.flag3)
				{
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2[this.flag1].x * this.direction;
					t_.v.y = this.flag2[this.flag1].y;
					this.kobito.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Occult, t_));
					this.flag1++;
				}

				if (this.count >= 24)
				{
					this.SetMotion(this.motion, this.keyTake + 1);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
}

function OkultAir_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.flag1 = 0;
	this.flag2 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag2[0].x = 2.00000000;
	this.flag2[0].y = -5.19999981;
	this.flag2[1].x = -1.00000000;
	this.flag2[1].y = -7.50000000;
	this.flag2[2].x = 0.50000000;
	this.flag2[2].y = -6.50000000;
	this.flag2[3].x = -2.09999990;
	this.flag2[3].y = -5.50000000;
	this.flag2[4].x = 1.50000000;
	this.flag2[4].y = -4.50000000;
	this.flag2[5].x = -0.80000001;
	this.flag2[5].y = -6.50000000;
	this.flag2[6].x = 0.75000000;
	this.flag2[6].y = -8.50000000;
	this.flag3 = 5;
	this.kobito.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.kobito.Clear();
	this.keyAction = [
		function ()
		{
			this.HitReset();
			this.hitResult = 1;
			this.count = 0;
			this.PlaySE(3437);
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);

				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.01000000);
				}

				if (this.count % 4 == 1 && this.flag1 < this.flag3)
				{
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2[this.flag1].x * this.direction;
					t_.v.y = this.flag2[this.flag1].y;
					this.kobito.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Occult, t_));
					this.flag1++;
				}

				if (this.count >= 24)
				{
					this.SetMotion(this.motion, this.keyTake + 1);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.10000000, null);

						if (this.centerStop * this.centerStop <= 0)
						{
							this.VX_Brake(0.50000000);
						}
						else
						{
							this.VX_Brake(0.01000000);
						}
					};
				}
			};
		},
		null,
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.01000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 0)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.01000000);
		}
	};
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.atk_id = 16384;
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.flag3 = 6.00000000 * this.direction;

	if (this.centerStop * this.centerStop >= 4 && this.y > this.centerY)
	{
		this.flag4 = -1;
		this.SetMotion(3001, 0);
	}
	else
	{
		this.flag4 = -1;
		this.SetMotion(3000, 0);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
					this.flag2 = null;
				}
			};
			this.team.AddMP(-200, 120);
			this.PlaySE(3440);
			this.count = 0;

			if (this.flag4 == 1)
			{
				this.SetSpeed_XY(this.flag3, 12.50000000);
				this.centerStop = 2;
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(15);
					this.AddSpeed_XY(0.00000000, -0.50000000);

					if (this.va.y < -4.00000000 && this.y < this.centerY)
					{
						if (this.flag2)
						{
							this.flag2.func[0].call(this.flag2);
							this.flag2 = null;
						}

						this.lavelClearEvent = null;
						this.centerStop = 1;
						this.SetSpeed_XY(null, -3.00000000);
						this.SetMotion(3000, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			}
			else
			{
				this.SetSpeed_XY(this.flag3, -12.50000000);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(15);

					if (this.y <= this.centerY + 75)
					{
						this.AddSpeed_XY(0.00000000, 0.50000000);
					}

					if (this.va.y > 4.00000000 && this.y > this.centerY)
					{
						if (this.flag2)
						{
							this.flag2.func[0].call(this.flag2);
							this.flag2 = null;
						}

						this.lavelClearEvent = null;
						this.centerStop = 1;
						this.SetSpeed_XY(null, 3.00000000);
						this.SetMotion(3000, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			}
		}
	];
	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.atk_id = 2097152;
	this.HitReset();
	this.SetMotion(3010, 0);
	this.count = 0;
	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3442);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1 && this.target.team.life > 0)
				{
					this.SP_B_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.hitResult & 1 && this.target.team.life > 0)
				{
					this.SP_B_Hit(null);
					return;
				}

				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 2.00000000 : 0.02500000);
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
		this.VX_Brake(this.va.x * this.direction <= -2.00000000 ? 1.00000000 : 0.05000000);
	};
	return true;
}

function SP_B_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3012, 0);
	this.count = 0;
	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3442);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1 && this.target.team.life > 0)
				{
					this.SP_B_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.hitResult & 1 && this.target.team.life > 0)
				{
					this.SP_B_Hit(null);
					return;
				}

				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 2.00000000 : 0.02500000);
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
		this.VX_Brake(this.va.x * this.direction <= -2.00000000 ? 1.00000000 : 0.05000000);
		this.CenterUpdate(0.10000000, null);
	};
	return true;
}

function SP_B_Hit( t )
{
	this.LabelClear();
	this.SetMotion(3011, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.target.DamageGrab_Common(301, 2, -this.direction);
	this.target.x = this.point0_x;
	this.target.y = this.point0_y;
	this.target.SetParent(this, this.target.x - this.x, this.target.y - this.y);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3444);
			this.target.DamageGrab_Common(311, 0, -this.direction);
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B_Core, {});
		},
		function ()
		{
			this.PlaySE(3444);
			local t_ = {};
			t_.take <- 1;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B2_Core, {});
		},
		function ()
		{
			this.PlaySE(3444);
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B3_Core, {});
			this.target.SetParent(null, 0, 0);

			if (this.target.y <= this.centerY)
			{
				this.target.centerStop = -2;
			}
			else
			{
				this.target.centerStop = 2;
			}

			this.KnockBackTarget(-this.direction);
			this.AjustCenterStop();
		}
	];
	this.stateLabel = function ()
	{
		if (this.target.wall)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}

		this.VX_Brake(1.50000000);

		if (this.count == 25)
		{
			this.SetMotion(3011, 1);
			this.stateLabel = null;
		}
	};
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.team.AddMP(-200, 120);
	this.flag1 = 0;
	this.flag2 = 0.50000000;
	this.flag3 = -20 * 0.01745329;
	this.flag4 = 75;
	this.flag5 = {};
	this.flag5.b <- 0;
	this.flag5.rush <- t.rush;
	this.flag5.v <- this.Vector3();
	this.flag5.v.x = 50.00000000;
	this.flag5.v.RotateByRadian(this.flag3);
	this.SetMotion(3020, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.input.x == 0)
				{
					this.SetSpeed_XY(0.00000000, null);
				}
				else
				{
					this.SetSpeed_XY(this.input.x > 0 ? 1.00000000 : -1.00000000, null);
				}

				if ((this.input.b2 == 1 && !this.flag5.rush || this.input.b0 == 1 && this.flag5.rush) && ::battle.state == 8)
				{
					this.flag5.b = 15;
				}

				this.flag5.b--;
				this.CenterUpdate(0.10000000, 1.50000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.25000000);
				}
			};
			this.PlaySE(3445);
			local t_ = {};
			t_.rot <- -5 * 0.01745329;
			t_.scale <- 1.50000000;
			t_.priority <- 200;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
			this.flag2 += 0.05000000;
			this.flag4 += 2;
			this.flag3 -= (120 + this.rand() % 15) * 0.01745329;
		},
		function ()
		{
			this.PlaySE(3445);
			local t_ = {};
			t_.rot <- 150 * 0.01745329;
			t_.scale <- 1.50000000;
			t_.priority <- 200;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
			this.flag2 += 0.05000000;
			this.flag4 += 2;
			this.flag3 -= (120 + this.rand() % 15) * 0.01745329;
		},
		function ()
		{
			this.PlaySE(3445);
			local t_ = {};
			t_.rot <- -160 * 0.01745329;
			t_.scale <- 1.50000000;
			t_.priority <- 180;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
			this.flag2 += 0.05000000;
			this.flag4 += 2;
			this.flag3 -= (120 + this.rand() % 15) * 0.01745329;
		},
		function ()
		{
			this.flag1++;

			if (this.flag1 <= 3 && this.flag5.b > 0 || this.flag1 <= 0)
			{
				this.SetMotion(3020, 1);
				this.PlaySE(3445);
				local t_ = {};
				t_.rot <- -5 * 0.01745329;
				t_.scale <- 1.50000000;
				t_.priority <- 200;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
				this.flag2 += 0.05000000;
				this.flag4 += 2;
				this.flag3 -= (120 + this.rand() % 15) * 0.01745329;
			}
			else
			{
			}
		},
		function ()
		{
			this.PlaySE(3445);
			local t_ = {};
			t_.rot <- -10 * 0.01745329;
			t_.scale <- 2.00000000;
			t_.priority <- 200;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C2, t_);
			this.flag2 += 0.05000000;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 1.50000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.25000000);
		}
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.flag1 = 0;
	this.SetMotion(3030, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3447);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(8.00000000 * this.direction, 0.00000000);
			local t_ = {};
			t_.rot <- 0.00000000;
			this.flag5 = this.SetShot(this.x + 45 * this.direction, this.y - 105, this.direction, this.SPShot_D, t_).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag5)
				{
					this.flag5.func[2].call(this.flag5);
				}
			};
			this.stateLabel = function ()
			{
				this.VX_Brake(0.33000001);
				this.CenterUpdate(0.10000000, 1.00000000);
			};
		},
		function ()
		{
			this.PlaySE(3449);
			this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);

			if (this.flag5)
			{
				this.flag5.func[0].call(this.flag5);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
				this.CenterUpdate(0.10000000, 1.00000000);
			};
		},
		function ()
		{
			this.lavelClearEvent = null;
			this.PlaySE(3450);

			if (this.flag5)
			{
				this.flag5.func[1].call(this.flag5);
			}

			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
				this.CenterUpdate(0.34999999, 8.00000000);
			};
		}
	];
	return true;
}

function SP_D_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = null;
	this.SetMotion(3031, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3447);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(8.00000000 * this.direction, 0.00000000);
			local t_ = {};

			if (this.y <= this.centerY)
			{
				t_.rot <- 20.00000000 * 0.01745329;
			}
			else
			{
				t_.rot <- -20.00000000 * 0.01745329;
			}

			this.flag5 = this.SetShot(this.x + 45 * this.direction, this.y - 105, this.direction, this.SPShot_D, t_).weakref();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.33000001);
				this.CenterUpdate(0.10000000, 1.00000000);
			};
			this.lavelClearEvent = function ()
			{
				if (this.flag5)
				{
					this.flag5.func[2].call(this.flag5);
				}
			};
		},
		function ()
		{
			this.PlaySE(3449);
			this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);

			if (this.flag5)
			{
				this.flag5.func[0].call(this.flag5);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
				this.CenterUpdate(0.10000000, 1.00000000);
			};
		},
		function ()
		{
			this.lavelClearEvent = null;
			this.PlaySE(3450);

			if (this.flag5)
			{
				this.flag5.func[1].call(this.flag5);
			}

			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
				this.CenterUpdate(0.10000000, null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);
	};
	return true;
}

function SP_D_Hit( t )
{
	this.LabelClear();
	this.SetMotion(3031, 0);
	this.SetSpeed_XY(-5.00000000 * this.direction, -10.00000000);
	this.centerStop = -2;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);
	};
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.flag1 = true;
	this.PlaySE(3452);
	this.SetMotion(3040, 0);
	this.centerStop = -2;
	this.SetSpeed_XY(4.00000000 * this.direction, -9.00000000);
	this.flag2 = this.y;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);
				this.AddSpeed_XY(null, this.va.y < -0.25000000 ? 0.50000000 : 0.05000000);

				if (this.count >= 10)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(null, 0.89999998);

						if (this.y >= this.flag2)
						{
							this.team.AddMP(-200, 120);
							this.centerStop = 2;
							this.SetSpeed_XY(null, 4.00000000);
							this.SetMotion(3040, 2);
							this.stateLabel = function ()
							{
								this.VX_Brake(0.10000000);
								this.AddSpeed_XY(null, this.va.y < -0.25000000 ? 0.50000000 : 0.05000000);
							};
							this.PlaySE(3453);

							for( local i = 0; i < 18; i++ )
							{
								local t_ = {};
								t_.rot <- i * 20 * 0.01745329;
								this.SetShot(this.x + 75 * this.direction * this.cos(t_.rot), this.y + 75 * this.sin(t_.rot), this.direction, this.SPShot_E, t_);
							}
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
				if (this.Vec_Brake(0.50000000))
				{
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.10000000, 5.00000000);
					};
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.10000000);
		this.AddSpeed_XY(null, this.va.y < -0.25000000 ? 0.50000000 : 0.05000000);
	};
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.atk_id = 33554432;
	this.HitReset();
	this.hitCount = 0;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.y <= this.centerY)
	{
		this.SetMotion(3050, 0);
		this.centerStop = 2;
		this.flag1 = 0.78539813;
	}
	else
	{
		this.SetMotion(3051, 0);
		this.centerStop = -2;
		this.flag1 = -0.78539813;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_Vec(17.50000000, this.flag1, this.direction);
			this.PlaySE(3491);
			this.stateLabel = function ()
			{
				if (this.hitCount <= 2)
				{
					this.HitCycleUpdate(3);
				}

				if (this.va.y < 0.00000000 && this.y < this.centerY || this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.SetSpeed_XY(this.va.x * 0.34999999, this.va.y * 0.34999999);
					this.SetMotion(this.motion, 2);
					this.HitTargetReset();
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.50000000, null);
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
	};
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.atk_id = 67108864;
	this.HitReset();
	this.SetMotion(4000, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = 0;
	this.flag2 = 0;
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
		},
		function ()
		{
			this.invinObject = 6;
			this.count = 0;
			this.flag1 = 0;
			this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
			this.PlaySE(3464);
			this.SetFreeObject(this.x + 123 * this.direction, this.y - 16, this.direction, this.SpellShot_A_Flash, {});

			for( local i = 0; i < 8; i++ )
			{
				this.SetFreeObject(this.x + 123 * this.direction, this.y - 16, this.direction, this.SpellShot_A, {});
			}

			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x + 123 * this.direction, this.y - 16, this.direction, this.SpellShotA_ShotBaria, t_);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);

				if (this.count % 12 == 0)
				{
					this.flag2++;

					if (this.flag2 < 4)
					{
						this.PlaySE(3464);
					}

					this.SetFreeObject(this.x + 123 * this.direction, this.y - 16, this.direction, this.SpellShot_A_Flash, {});
					this.HitTargetReset();

					for( local i = 0; i < 8; i++ )
					{
						this.SetFreeObject(this.x + 123 * this.direction, this.y - 16, this.direction, this.SpellShot_A, {});
					}

					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x + 123 * this.direction, this.y - 16, this.direction, this.SpellShotA_ShotBaria, t_);
				}

				if (this.count >= 48)
				{
					this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.25000000);
						this.CenterUpdate(0.10000000, null);
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(17.50000000 * this.direction, 0.00000000);
		},
		function ()
		{
			this.SetSpeed_XY(17.50000000 * this.direction, 0.00000000);
			this.HitTargetReset();
			this.PlaySE(3466);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);
				this.VX_Brake(0.69999999);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.atk_id = 67108864;
	this.HitReset();
	this.SetMotion(4010, 0);
	this.count = 0;
	this.ResetSpeed();
	this.AjustCenterStop();
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(3455);
			this.SetEffect(this.x + 46 * this.direction, this.y - 62, this.direction, this.EF_HitSmashA, {});
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(3456);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B_Small, {}).weakref();
		},
		function ()
		{
			this.count = 0;

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				if (this.count == 25)
				{
					this.Spell_B_Mini(null);
				}
			};
		}
	];
	return true;
}

function Spell_B_End_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.flag2 = this.Vector3();
	this.flag2.x = this.va.x;
	this.flag2.y = this.va.y;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(4011, 1);
	this.count = 0;
	this.PlaySE(3456);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B_SmallEnd, {}).weakref();
	this.keyAction = [
		null,
		function ()
		{
			this.count = 0;

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				if (this.count == 5)
				{
					if (this.centerStop * this.centerStop >= 4)
					{
						this.SetSpeed_XY(this.flag2.x, this.flag2.y);
					}

					this.EndtoFreeMove();
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Spell_B_BigEnd_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.flag2 = this.Vector3();
	this.flag2.x = this.va.x;
	this.flag2.y = this.va.y;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(4011, 3);
	this.count = 0;
	this.PlaySE(3456);
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B2_SmallEnd, {}).weakref();
			this.count = 0;

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.sx = this.sy = 0.10000000;
			this.lavelClearEvent = function ()
			{
				this.sx = this.sy = 1.00000000;
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.40000001;

				if (this.sx >= 2.00000000)
				{
					this.stateLabel = function ()
					{
						this.sx = this.sy += (1.00000000 - this.sx) * 0.25000000;

						if (this.sx <= 1.00000000)
						{
							this.sx = this.sy = 1.00000000;
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Spell_B_Mini( t )
{
	this.LabelReset();
	this.SetEndMotionCallbackFunction(function ()
	{
		this.func[0].call(this);
	});
	this.count = 0;
	this.flag1 = this.centerY;
	this.flag2 = 0;
	this.flag3 = 0;
	this.subState = function ()
	{
		if (this.flag2 <= 697)
		{
			this.team.AddSP(-3);
			this.flag2 += 6;
		}
		else
		{
			this.team.AddSP(this.flag2 - 700);
			this.flag2 = 700;
		}

		if (this.flag2 >= 700 || this.target.team.life <= 0)
		{
			this.Spell_B_End_Init(null);
			return true;
		}

		if (this.command.rsv_k0 > 0 || this.command.rsv_k1 > 0 || this.command.rsv_k2 > 0)
		{
			this.Spell_B_BigEnd_Init(null);
			return true;
		}

		return false;
	};
	this.func = [
		function ()
		{
			this.keyAction = null;
			this.SetMotion(4011, 0);
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.GetFront();
				this.VX_Brake(1.50000000);

				if (this.centerStop * this.centerStop == 0)
				{
					if (this.input.y > 0)
					{
						local x_ = this.input.x;
						x_ = this.Math_MinMax(x_, -1, 1);
						this.func[4].call(this, x_);
						return;
					}

					if (this.input.y < 0)
					{
						local x_ = this.input.x;
						x_ = this.Math_MinMax(x_, -1, 1);
						this.func[3].call(this, x_);
						return;
					}
				}

				if (this.input.x * this.direction > 0)
				{
					this.func[1].call(this);
					return;
				}

				if (this.input.x * this.direction < 0)
				{
					this.func[2].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.keyAction = null;
			this.SetMotion(4012, 0);
			this.HitReset();
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				if (this.hitResult & 1)
				{
					this.Spell_B_Hit(null);
					return;
				}

				if (this.centerStop * this.centerStop == 0)
				{
					if (this.input.y > 0)
					{
						local x_ = this.input.x;
						x_ = this.Math_MinMax(x_, -1, 1);
						this.func[4].call(this, x_);
						return;
					}

					if (this.input.y < 0)
					{
						local x_ = this.input.x;
						x_ = this.Math_MinMax(x_, -1, 1);
						this.func[3].call(this, x_);
						return;
					}
				}

				this.AddSpeed_XY(2.50000000 * this.direction, 0.00000000);

				if (this.va.x * this.direction >= 8.00000000)
				{
					this.SetSpeed_XY(8.00000000 * this.direction, null);
				}

				this.GetFront();

				if (this.input.x * this.direction <= 0)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.keyAction = null;
			this.SetMotion(4013, 0);
			this.HitReset();
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				if (this.hitResult & 1)
				{
					this.Spell_B_Hit(null);
					return;
				}

				if (this.centerStop * this.centerStop == 0)
				{
					if (this.input.y > 0)
					{
						local x_ = this.input.x;
						x_ = this.Math_MinMax(x_, -1, 1);
						this.func[4].call(this, x_);
						return;
					}

					if (this.input.y < 0)
					{
						local x_ = this.input.x;
						x_ = this.Math_MinMax(x_, -1, 1);
						this.func[3].call(this, x_);
						return;
					}
				}

				this.AddSpeed_XY(-2.50000000 * this.direction, 0.00000000);

				if (this.va.x * this.direction <= -8.00000000)
				{
					this.SetSpeed_XY(-8.00000000 * this.direction, null);
				}

				this.GetFront();

				if (this.input.x * this.direction >= 0)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		function ( x_ )
		{
			this.HitReset();
			this.flag1 = x_;
			this.SetMotion(4014, 0);
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.VX_Brake(0.50000000);
			};
			this.keyAction = [
				function ()
				{
					this.PlaySE(3457);
					this.centerStop = -3;
					this.SetSpeed_XY(8.00000000 * this.flag1, -15.00000000);
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							return;
						}

						if (this.hitResult & 1)
						{
							this.Spell_B_Hit(null);
							return;
						}

						if (this.va.y > -5.00000000)
						{
							this.SetMotion(4014, 3);
							this.stateLabel = function ()
							{
								if (this.subState())
								{
									return;
								}

								if (this.hitResult & 1)
								{
									this.Spell_B_Hit(null);
									return;
								}

								if (this.centerStop * this.centerStop <= 1)
								{
									this.SetMotion(4014, 5);
									this.stateLabel = function ()
									{
										if (this.subState())
										{
											return;
										}

										this.VX_Brake(0.50000000);
									};
								}
							};
						}
					};
				}
			];
		},
		function ( x_ )
		{
			this.HitReset();
			this.flag1 = x_;
			this.SetMotion(4015, 0);
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.VX_Brake(0.50000000);
			};
			this.keyAction = [
				function ()
				{
					this.PlaySE(3457);
					this.centerStop = 3;
					this.SetSpeed_XY(8.00000000 * this.flag1, 15.00000000);
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							return;
						}

						if (this.hitResult & 1)
						{
							this.Spell_B_Hit(null);
							return;
						}

						if (this.va.y < 5.00000000)
						{
							this.SetMotion(4015, 3);
							this.stateLabel = function ()
							{
								if (this.subState())
								{
									return;
								}

								if (this.hitResult & 1)
								{
									this.Spell_B_Hit(null);
									return;
								}

								if (this.centerStop * this.centerStop <= 1)
								{
									this.SetMotion(4015, 5);
									this.stateLabel = function ()
									{
										if (this.subState())
										{
											return;
										}

										this.VX_Brake(0.50000000);
									};
								}
							};
						}
					};
				}
			];
		}
	];
	this.func[0].call(this);
}

function Spell_B_Hit( t )
{
	this.LabelReset();
	this.SetEndMotionCallbackFunction(this.EndtoFreeMove);
	this.SetMotion(4016, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.target.DamageGrab_Common(300, 2, -this.direction);
	this.count = 0;
	this.flag1 = this.Vector3();
	this.flag5 = {};
	this.flag5.list <- [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag5.motionList <- [
		300,
		301,
		304,
		302,
		301,
		300
	];
	this.flag5.list[0].x = 40;
	this.flag5.list[0].y = -20;
	this.flag5.list[1].x = -60;
	this.flag5.list[1].y = -40;
	this.flag5.list[2].x = 30;
	this.flag5.list[2].y = 80;
	this.flag5.list[3].x = -50;
	this.flag5.list[3].y = -75;
	this.flag5.list[4].x = 70;
	this.flag5.list[4].y = -20;
	this.flag5.list[5].x = -20;
	this.flag5.list[5].y = 30;
	this.flag5.listNum <- 0;
	this.subState = function ()
	{
	};
	this.func = [
		function ( x_, y_, motion_ )
		{
			this.target.team.master.enableKO = false;

			if (this.target.team.slave)
			{
				this.target.team.slave.enableKO = false;
			}

			this.PlaySE(3458);
			::camera.shake_radius = 2.00000000;
			this.flag1.x = this.x + x_ * this.direction;
			this.flag1.y = this.y + y_;

			if (this.target.x > this.flag1.x)
			{
				this.target.direction = 1.00000000;
			}

			if (this.target.x < this.flag1.x)
			{
				this.target.direction = -1.00000000;
			}

			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashB, {});
			this.target.SetMotion(motion_, 0);
			this.KnockBackTarget(this.target.direction);
			this.subState = function ()
			{
				this.target.x += (this.flag1.x - this.target.x) * 0.25000000;
				this.target.y += (this.flag1.y - this.target.y) * 0.25000000;
			};
		},
		function ()
		{
			this.target.team.master.enableKO = true;

			if (this.target.team.slave)
			{
				this.target.team.slave.enableKO = true;
			}

			this.SetMotion(4016, 2);
			this.atk_id = 67108864;
			this.PlaySE(3459);
			::camera.shake_radius = 8.00000000;
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.KnockBackTarget(-this.direction);
			this.count = 0;
			this.sx = this.sy = 0.10000000;
			this.y = this.centerY - 60;
			this.centerStop = -2;
			this.SetSpeed_XY(-6.00000000 * this.direction, -9.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.05000000;

				if (this.sx > 1.00000000)
				{
					this.sx = this.sy = 1.00000000;
				}

				this.AddSpeed_XY(0.00000000, 0.25000000);

				if (this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(4016, 3);
					this.SetSpeed_XY(null, 3.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		function ()
		{
			this.SetMotion(4016, 2);
			this.sx = this.sy = 0.10000000;
		}
	];
	this.x = this.target.x;
	this.y = this.target.y;
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.count = 0;
			local t_ = {};
			t_.count <- 150;
			t_.priority <- 210;
			this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % 6 == 1)
				{
					this.func[0].call(this, this.flag5.list[this.flag5.listNum].x, this.flag5.list[this.flag5.listNum].y, this.flag5.motionList[this.flag5.listNum]);
					this.flag5.listNum++;

					if (this.flag5.listNum > 5)
					{
						this.flag5.listNum = 0;
					}
				}

				if (this.count == 120)
				{
					this.func[1].call(this);
				}
			};
		}
	};
}

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4020, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
			};
		},
		function ()
		{
			local t_ = {};
			t_.rot <- 40 * 0.01745329;
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Spell_C_Shot, t_);
			this.PlaySE(3460);
		},
		function ()
		{
		},
		function ()
		{
			this.hitResult = 1;
			this.team.spell_enable_end = false;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			local x_ = this.x + (50 + (::battle.scroll_bottom - this.y)) * this.direction;
			x_ = this.Math_MinMax(x_, -100, 1380);
			this.SetShot(x_, ::battle.scroll_bottom + 100, this.direction, this.Spell_C_ShotB, t_);
			this.PlaySE(3461);
			this.centerStop = -2;
			this.SetSpeed_XY(-15.00000000 * this.direction, -9.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
				this.AddSpeed_XY(0.00000000, 0.50000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 3.00000000);
			this.stateLabel = null;
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseClimaxSpell(60, "–—\x256c‚\x2560‹l‚æA‚¨‚¨‚«‚­‚\x255a‚ê‚æI–");
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}

				this.lastword.Deactivate();
			};
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.SetMotion(4900, 2);
					this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
					this.stateLabel = null;
				}
			};
		},
		function ()
		{
			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
		},
		function ()
		{
			this.PlaySE(3470);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Koduchi, t_).weakref();
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;

			if (this.flag2)
			{
				this.PlaySE(3472);
				this.flag2.func[1].call(this.flag2);
			}

			this.stateLabel = function ()
			{
				if (this.flag2 && this.flag2.flag2)
				{
					this.target.DamageGrab_Common(304, 0, -this.direction);
					this.target.SetParent(this.flag2, this.target.x - this.flag2.x, this.target.y - (this.flag2.y + 75));
					this.Spell_Climax_Hit(null);
					return;
				}

				if (this.count >= 75)
				{
					this.SetMotion(4900, 7);
					this.stateLabel = null;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 0);
	this.count = 0;
	::battle.enableTimeUp = false;
	this.stateLabel = function ()
	{
		if (this.count == 40)
		{
			if (this.flag2)
			{
				this.BackColorFilter(0.50000000, 0.00000000, 0.00000000, 0.00000000, 40);
				this.flag2.func[2].call(this.flag2);
			}
		}

		if (this.count == 150)
		{
			this.FadeOut(1.00000000, 1.00000000, 1.00000000, 30);
		}

		if (this.count == 180)
		{
			this.flag2.func[3].call(this.flag2);
			this.Spell_Climax_Cut(null);
			return;
		}
	};
}

function Spell_Climax_Cut( t )
{
	this.LabelReset();
	this.HitReset();
	this.flag5 = {};
	this.flag5.back <- null;
	this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 1);
	this.BackFadeOut(0.00000000, 0.00000000, 0.00000000, 1);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 10);
	this.flag5.back = this.SetFreeObject(640, 360, this.direction, this.Climax_Back, {}).weakref();
	this.flag5.cut <- null;
	this.flag5.giant <- null;
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 20)
		{
			this.flag5.cut = this.SetFreeObject(640, 360, this.direction, this.Climax_Cut, {}).weakref();
		}

		if (this.count == 80)
		{
			this.PlaySE(3475);
			this.flag5.giant = this.SetFreeObject(640, 360, this.direction, this.Climax_Giant, {}).weakref();
		}

		if (this.count == 150)
		{
			this.FadeOut(1.00000000, 1.00000000, 1.00000000, 25);
		}

		if (this.count == 175)
		{
			this.flag5.back.func[0].call(this.flag5.back);
			this.flag5.cut.func[0].call(this.flag5.cut);
			this.flag5.giant.func[0].call(this.flag5.giant);
			this.Climax_Finish(null);
		}
	};
}

function Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
	this.count = 0;
	this.SetSpeed_XY(-12.00000000 * this.direction, -6.50000000);
	this.centerStop = -2;
	this.SetMotion(4901, 1);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 15);
	this.BackFadeIn(1.00000000, 1.00000000, 1.00000000, 15);
	this.count = 0;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag5 = this.SetShot(this.target.x, ::battle.scroll_top - 360, this.direction, this.Climax_GiantFoot, t_).weakref();
	this.func = [
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction < -2.00000000 ? 0.25000000 : 0.01000000);
		this.AddSpeed_XY(null, this.va.y < 1.00000000 ? 0.40000001 : 0.01000000);

		if (this.count == 50)
		{
			::battle.enableTimeUp = true;
			this.SetMotion(4901, 3);
			this.stateLabel = function ()
			{
			};
		}
	};
}

