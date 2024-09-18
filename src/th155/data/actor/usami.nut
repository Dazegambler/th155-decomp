function Func_BeginBattle()
{
	this.BeginBattle(null);
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

function BeginBattle_Card( t )
{
	this.SetMotion(9000, 4);
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.alpha = this.red = this.green -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
}

function BeginBattle( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(3688);
			this.count = 0;
			this.demoObject.append(this.SetFreeObject(this.x, this.y, this.direction, this.BeginBattle_Card, {}).weakref());
		},
		function ()
		{
			this.PlaySE(3689);
			this.count = 0;
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
}

function BeginStory( t )
{
	this.SetMotion(0, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();

	if (this.team.index == 2)
	{
		this.Warp(::battle.start_x[1], this.centerY);
		this.direction = -1.00000000;
	}
	else
	{
		this.Warp(::battle.start_x[0], this.centerY);
		this.direction = 1.00000000;
	}

	this.count = 0;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.BeginStory_Ball, {}).weakref();
	this.stateLabel = function ()
	{
		if (this.count == 300)
		{
			this.masterRed = this.masterGreen = this.masterBlue = 0.00000000;
			this.flag1.func[0].call(this.flag1);
			this.isVisible = true;
			this.EndtoFreeMove();
		}
	};
}

function BeginStoryFlash( t )
{
	this.SetMotion(9002, 2);
	this.PlaySE(3671);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.01500000;
	};
}

function BeginStoryFlash2( t )
{
	this.SetMotion(9002, 4);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.80000001;
		this.blue = this.green -= 0.10000000;
	};
}

function BeginStory_Ball( t )
{
	this.SetMotion(9009, 0);
	this.sx = this.sy = 0.00000000;
	this.DrawActorPriority(180);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = 0;
	this.PlaySE(201);
	this.func = [
		function ()
		{
			this.PlaySE(202);
			::camera.shake_radius = 10.00000000;
			this.FadeIn(1.00000000, 1.00000000, 1.00000000, 40);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 12 == 1)
				{
					local t_ = {};
					t_.scale <- this.sx * 0.10000000 + 0.50000000;
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.BeginStory_Spark, t_));
				}

				this.sx = this.sy += (10.00000000 - this.sx) * 0.10000000;
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		::camera.shake_radius = 2.00000000;
		local s_ = (2.00000000 - this.sx) * 0.02500000;

		if (s_ < 0.01000000)
		{
			s_ = 0.01000000;
		}

		this.sx = this.sy += s_;
		this.count++;
		this.flag2--;

		if (this.flag2 <= 0)
		{
			this.flag2 = 10 + this.rand() % 15;
			local t_ = {};
			t_.scale <- this.sx * 0.25000000 + 0.50000000;
			this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.BeginStory_Spark, t_));
		}

		if (this.count == 30)
		{
			this.flag1.Add(this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.owner.BeginStory_Aura, {}));
		}
	};
}

function BeginStory_Spark( t )
{
	this.SetMotion(9009, 2);
	this.DrawActorPriority(169);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = t.scale + this.rand() % 25 * 0.01000000;
	this.keyAction = this.ReleaseActor;
}

function BeginStory_Aura( t )
{
	this.SetMotion(9009, 1);
	this.DrawActorPriority(170);
	this.alpha = 0.00000000;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 256;
	this.anime.vertex_alpha1 = 0.00000000;
	this.anime.vertex_blue1 = 0.00000000;
	this.anime.vertex_red1 = 0.50000000;
	this.anime.vertex_green1 = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top -= 0.50000000;
				this.anime.left -= 0.10000000;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.anime.top -= 3.00000000;
		this.alpha += 0.02500000;
		this.sx = this.sy += 0.00500000;
	};
}

function WinA( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3692);
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, function ( t_ )
			{
				this.SetMotion(9010, 4);
				this.keyAction = this.ReleaseActor;
				this.stateLabel = function ()
				{
					this.sx = this.sy *= 0.50000000;
					this.alpha -= 0.25000000;
				};
			}, {});
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function BattleWinObject_B( t )
{
	this.SetMotion(9011, 3 + this.rand() % 4);
	this.DrawActorPriority(180);
	this.SetSpeed_XY((-1.00000000 + this.rand() % 51 * 0.10000000) * this.direction, -1.00000000 - this.rand() % 3);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.05000000 * this.direction, -0.15000001);

		if (this.IsScreen(100))
		{
			this.ReleaseActor();
		}
	};
}

function WinB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.demoObject = [];
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(3693);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 120)
				{
					this.CommonWin();
				}

				this.flag1--;

				if (this.flag1 <= 0)
				{
					this.flag1 = 5 + this.rand() % 6;
					this.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BattleWinObject_B, {}).weakref());
				}
			};
		},
		function ()
		{
		}
	];
}

function Lose_Tab( t )
{
	this.SetMotion(9020, 3);
	this.SetSpeed_XY(2.00000000 * this.direction, 2.00000000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.rz += (60 * 0.01745329 - this.rz) * 0.05000000;
		this.AddSpeed_XY(0.00000000, 0.50000000);
	};
}

function Lose( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(3691);
			this.count = 0;
			this.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Lose_Tab, {}).weakref());
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					this.CommonLose();
				}
			};
		},
		function ()
		{
		}
	];
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 20)
		{
			this.PlaySE(3690);
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
	this.SetSpeed_XY(4.75000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-4.00000000 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 7.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- -14.00000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 14.00000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 7.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- -14.00000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 14.00000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 7.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- 14.00000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 14.00000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 7.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- 14.00000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 14.00000000;
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
	t_.speed <- 5.00000000;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 9.00000000;
	t_.wait <- 180;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 5.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 120;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 8.00000000;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-8.00000000 * this.direction, -4.25000000);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.40000001);

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
	local t_ = {};
	t_.speed <- -5.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 8.00000000;
	this.DashBack_Air_Common(t_);
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AAA;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(6.00000000 * this.direction, null);
			this.PlaySE(3602);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.50000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(6.00000000 * this.direction, null);
			this.PlaySE(3604);
			this.HitTargetReset();
		}
	];
	return true;
}

function Atk_RushA_Init( t )
{
	this.Atk_RushB_Init(t);
	this.atk_id = 1;
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
	this.flag1 = 10.00000000;
	this.flag2 = 7.00000000;
	this.keyAction = [
		function ()
		{
			this.lavelClearEvent = function ()
			{
				this.SetSpeed_XY(this.flag2 * this.direction, null);
			};
			this.SetSpeed_XY((this.flag1 + 7.00000000) * this.direction, null);
			this.PlaySE(3608);
			this.stateLabel = function ()
			{
				this.flag1 -= 2.50000000;
				this.flag2 -= 0.50000000;

				if (this.flag1 < 0.00000000)
				{
					this.flag1 = 0.00000000;
				}

				if (this.flag2 < 0.00000000)
				{
					this.flag2 = 0.00000000;
				}

				this.SetSpeed_XY((this.flag1 + this.flag2) * this.direction, null);
			};
		},
		function ()
		{
		}
	];
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
	this.flag1 = 10.00000000;
	this.flag2 = 7.00000000;
	this.keyAction = [
		function ()
		{
			this.lavelClearEvent = function ()
			{
				this.SetSpeed_XY(this.flag2 * this.direction, null);
			};
			this.SetSpeed_XY((this.flag1 + 7.00000000) * this.direction, null);
			this.PlaySE(3606);
			this.stateLabel = function ()
			{
				this.flag1 -= 2.50000000;
				this.flag2 -= 0.50000000;

				if (this.flag1 < 0.00000000)
				{
					this.flag1 = 0.00000000;
				}

				if (this.flag2 < 0.00000000)
				{
					this.flag2 = 0.00000000;
				}

				this.SetSpeed_XY((this.flag1 + this.flag2) * this.direction, null);
			};
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
			this.PlaySE(3606);
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
				this.VX_Brake(0.50000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1704, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, null);
			this.PlaySE(1052);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		null,
		function ()
		{
			this.HitTargetReset();
		}
	];
	this.stateLabel = function ()
	{
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

function Atk_High_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1200, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(10.00000000 * this.direction, null);
			this.PlaySE(1052);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		null,
		function ()
		{
			this.HitTargetReset();
		}
	];
	this.stateLabel = function ()
	{
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

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.PlaySE(3672);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3616);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1210, 0);
	this.PlaySE(3672);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3614);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1211, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.33000001);
	this.PlaySE(3672);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3614);
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1211, 3);
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
					this.VX_Brake(0.75000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1211, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
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
	this.PlaySE(3672);
	this.keyAction = [
		null,
		function ()
		{
			this.HitTargetReset();
			::camera.shake_radius = 2.00000000;
			this.PlaySE(3618);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
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
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.PlaySE(3672);
	this.keyAction = [
		null,
		function ()
		{
			this.HitTargetReset();
			::camera.shake_radius = 2.00000000;
			this.PlaySE(3621);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
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

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.PlaySE(3672);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.33000001);
	this.keyAction = [
		null,
		function ()
		{
			this.HitTargetReset();
			::camera.shake_radius = 2.00000000;
			this.PlaySE(3618);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
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
					this.SetMotion(1221, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
			this.AjustCenterStop();
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
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1221, 4);
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
	this.PlaySE(3672);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3612);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
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

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1740, 0);
	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.PlaySE(3672);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.33000001);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1221, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			::camera.shake_radius = 2.00000000;
			this.PlaySE(3618);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
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
					this.SetMotion(1221, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		function ()
		{
			this.AjustCenterStop();
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
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 3);
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

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1230, 0);
	this.PlaySE(3672);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3610);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
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

function Atk_HighFront_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetMotion(1231, 0);
	this.PlaySE(3672);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3610);
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.AjustCenterStop();
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
		this.VX_Brake(0.75000000);
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.25000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1231, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
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
	this.count = 0;
	this.flag1 = this.SetFreeObject(this.x, ::battle.scroll_bottom + 200, this.direction, this.Atk_LowDash_ObjectA, {}).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func[0].call(this.flag1);
			this.flag1 = null;
		}
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.PlaySE(3673);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);

				if (this.hitResult & 13)
				{
					this.SetSpeed_XY(this.va.x * 0.75000000, 0.00000000);
					this.SetMotion(1300, 2);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
					return;
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.75000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		},
		function ()
		{
			this.SetFreeObject(this.x + 25 * this.direction, this.y, this.direction, this.Atk_LowDash_Object, {});
			this.centerStop = -3;
			this.SetSpeed_XY(-4.00000000 * this.direction, -4.00000000);
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
		if (this.count == 15)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(null, -5.00000000);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
				this.flag1 = null;
			}

			this.lavelClearEvent = null;
		}
	};
	return true;
}

function Atk_LowDash_ObjectA( t )
{
	this.SetMotion(1309, 0);
	this.rz = 90 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.rz += (60 * 0.01745329 - this.rz) * 0.05000000;
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((this.owner.x - this.x) * 0.20000000, (this.owner.y - this.y) * 0.20000000);
		this.rz += -this.rz * 0.25000000;
	};
}

function Atk_LowDash_Object( t )
{
	this.SetMotion(1309, 0);
	this.SetSpeed_XY(this.owner.va.x, 0.00000000);
	this.rz = 10 * 0.01745329;
	this.stateLabel = function ()
	{
		this.rz += (60 * 0.01745329 - this.rz) * 0.05000000;
		this.AddSpeed_XY(0.00000000, 0.60000002);
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1320, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.PlaySE(3694);
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
		this.target.Warp(this.initTable.pare.point0_x - (this.target.point0_x - this.target.x), this.initTable.pare.y);
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
	this.keyAction = [
		null,
		function ()
		{
			this.count = 0;
			this.target.autoCamera = true;
			this.flag1.func[0].call(this.flag1);
			this.PlaySE(3718);
			::camera.Shake(6.00000000);
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashB, {});
			this.target.DamageGrab_Common(311, 0, -this.direction);
			this.target.SetSpeed_XY(-8.00000000 * this.target.direction, -15.00000000);
			this.target.stateLabel = function ()
			{
				this.Vec_Brake(0.75000000, 0.25000000);
			};
		},
		function ()
		{
			this.PlaySE(3718);
			::camera.Shake(6.00000000);
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashB, {});
			this.target.DamageGrab_Common(304, 0, -this.direction);
			this.target.SetSpeed_XY(-10.00000000 * this.target.direction, 20.00000000);
			this.target.stateLabel = function ()
			{
				this.Vec_Brake(0.75000000, 0.25000000);
			};
		},
		function ()
		{
			this.PlaySE(3719);
			this.count = 0;
			this.target.autoCamera = true;
			::camera.Shake(10.00000000);
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
			};
		}
	];
}

function Shot_OkultCollectBall( t )
{
	this.SetMotion(2509, 0);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultCollectBallAura, {}).weakref();
	this.flag1.SetParent(this, 0, 0);
	local t_ = {};
	t_.priority <- this.drawPriority;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultCollectLight, t_);
	a_.SetParent(this, 0, 0);
	this.subState = function ()
	{
		if (this.owner.IsDamage() || this.owner.motion == 2500 && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.func = [
		function ()
		{
			local t_ = {};
			t_.priority <- this.drawPriority;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultCollectLight, t_);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.ReleaseActor();
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.alpha = 1.00000000;
			}
		},
		function ( count_ )
		{
			this.SetSpeed_XY(0.00000000, -17.50000000);
			this.count = 0;
			this.flag2 = count_;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.count++;
				this.VY_Brake(1.00000000);

				if (this.count >= this.flag2 + 15)
				{
					this.PlaySE(3685);
					this.DrawActorPriority(200);
					local t_ = {};
					t_.priority <- this.drawPriority;
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultCollectLight, t_);
					a_.SetParent(this, 0, 0);
					this.SetSpeed_XY(0.00000000, 0.00000000);

					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.target = this.owner.target.weakref();
					this.flag5 = this.SetCommonTrail(190, 3, 10 + this.rand() % 6, 30 + this.rand() % 11).weakref();
					this.SetMotion(2509, 7);
					this.flag4 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction) + (-10 + this.rand() % 21) * 0.01745329;
					this.cancelCount = 3;
					this.SetSpeed_Vec(1.25000000, this.flag4, this.direction);
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							return;
						}

						this.AddSpeed_Vec(1.25000000, null, 25.00000000, this.direction);

						if (this.IsScreen(200))
						{
							this.ReleaseActor();
							return;
						}

						if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
						{
							for( local i = 0; i < 2; i++ )
							{
								this.SetCommonFreeObject(this.x, this.y, this.direction, this.Occult_Power, {});
							}

							this.ReleaseActor();
							return;
						}

						this.TargetHoming(this.target, 0.75000000 * 0.01745329, this.direction);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Shot_OkultCore( t )
{
	this.SetMotion(2509, 2);
	this.flag1 = [];
	this.flag2 = null;
	this.flag4 = 0;
	this.flag5 = {};
	this.flag5.pos <- [];
	local r_ = 360 / 7.00000000;

	for( local i = 0; i < 7; i++ )
	{
		local pos_ = this.Vector3();
		pos_.x = 200.00000000;
		pos_.RotateByDegree(r_ * i);
		this.flag5.pos.append(pos_);
	}

	this.flag5.rotSpeed <- 4.00000000;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.ReleaseActor();
		},
		function ()
		{
			local l_ = this.flag1.len();

			if (l_ >= 7)
			{
				return true;
			}

			this.flag1.append(this.SetShot(this.x + this.flag5.pos[l_].x * this.direction, this.y + this.flag5.pos[l_].y * 0.20000000, this.direction, this.Shot_OkultCollectBall, {}).weakref());
			l_++;
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				foreach( a in this.flag5.pos )
				{
					if (a)
					{
						a.Mul(0.98000002);
					}
				}

				this.flag5.rotSpeed += 0.25000000;
				this.AddSpeed_XY(0.00000000, -0.40000001);
				this.subState();
				this.count++;

				if (this.count >= 20)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						this.count++;

						if (this.count == 10)
						{
							this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultCoreLight, {}).weakref();
							this.flag2.SetParent(this, 0, 0);
						}

						this.flag5.rotSpeed += 0.25000000;

						foreach( a in this.flag5.pos )
						{
							if (a)
							{
								a.Mul(0.94000000);
							}
						}

						this.VY_Brake(0.50000000);

						if (this.count == 40)
						{
							this.func[3].call(this);
							return;
						}

						this.subState();
					};
				}
			};
		},
		function ()
		{
			this.PlaySE(3648);
			this.SetCommonFreeObject(this.x, this.y, this.direction, this.Shot_OkultBall, {});

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.count = 0;

			foreach( val, a in this.flag1 )
			{
				if (a)
				{
					a.func[2].call(a, val * 2);
				}
			}

			this.ReleaseActor();
			return;
		}
	];
	this.subState = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.flag4++;

		foreach( a in this.flag5.pos )
		{
			if (a)
			{
				a.RotateByDegree(this.flag5.rotSpeed);
			}
		}

		for( local i = 0; i < this.flag1.len(); i++ )
		{
			if (this.flag1[i])
			{
				if (this.flag4 >= 10)
				{
					this.flag1[i].func[1].call(this.flag1[i]);
				}

				local pos_ = this.Vector3();
				pos_.x = this.flag5.pos[i].x;
				pos_.y = this.flag5.pos[i].y * 0.30000001;
				pos_.RotateByDegree(20.00000000);
				this.flag1[i].x = this.x + pos_.x * this.direction;
				this.flag1[i].y = this.y + pos_.y;

				if (this.flag1[i].drawPriority == 200)
				{
					if (this.flag1[i].y < this.y)
					{
						this.flag1[i].DrawActorPriority(180);

						if (this.flag1[i].flag1)
						{
							this.flag1[i].flag1.DrawActorPriority(180);
						}
					}
				}
				else if (this.flag1[i].y >= this.y)
				{
					this.flag1[i].DrawActorPriority(200);

					if (this.flag1[i].flag1)
					{
						this.flag1[i].flag1.DrawActorPriority(200);
					}
				}
			}
		}

		if (this.flag4 > 12)
		{
			this.flag4 = 0;
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.SetEffect(this.x, this.y - 30, this.direction, this.EF_ChargeO, {});
			this.hitResult = 1;
			this.PlaySE(3717);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.team.AddMP(-200, 120);
			this.doppel = this.SetObject(this.x, this.y, this.direction, this.Shot_OkultDoppel_A, {}).weakref();
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Okult_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.count = 0;

	if (this.y <= this.centerY)
	{
		this.flag1 = -1;
	}
	else
	{
		this.flag1 = 1;
	}

	this.keyAction = [
		function ()
		{
			this.SetEffect(this.x, this.y - 30, this.direction, this.EF_ChargeO, {});
			this.hitResult = 1;
			this.PlaySE(3717);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.team.AddMP(-200, 120);

			if (this.flag1 == -1)
			{
				this.doppel = this.SetObject(this.x, this.y, this.direction, this.Shot_OkultDoppel_B, {}).weakref();
			}
			else
			{
				this.doppel = this.SetObject(this.x, this.y, this.direction, this.Shot_OkultDoppel_C, {}).weakref();
			}
		},
		null,
		null,
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
		this.CenterUpdate(0.05000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function OkultB_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2502, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.count = 0;
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;

			if (::game.occultBall && ::game.occultBall.flag5.usamiState == null)
			{
				::game.occultBall.func[5].call(::game.occultBall, this);
			}
		},
		function ()
		{
			this.AjustCenterStop();
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
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
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3675);
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 10.00000000;
			t_.rot <- 0 * 0.01745329;
			t_.vx <- -5.00000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -5 * 0.01745329;
			t_.vx <- -1.00000000 * this.direction;
			t_.vy <- 0.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 3 * 0.01745329;
			t_.vx <- 2.50000000 * this.direction;
			t_.vy <- -1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -4.50000000 * 0.01745329;
			t_.vx <- 5.50000000 * this.direction;
			t_.vy <- 2.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 2.50000000 * 0.01745329;
			t_.vx <- 0.50000000 * this.direction;
			t_.vy <- -0.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 12.00000000;
			t_.rot <- 6.50000000 * 0.01745329;
			t_.vx <- -3.50000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
		},
		null,
		function ()
		{
			this.PlaySE(3676);
			this.team.AddMP(-200, 90);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
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
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.subState = function ()
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
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3675);
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 10.00000000;
			t_.rot <- 0 * 0.01745329;
			t_.vx <- -5.00000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -5 * 0.01745329;
			t_.vx <- -1.00000000 * this.direction;
			t_.vy <- 0.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 3 * 0.01745329;
			t_.vx <- 2.50000000 * this.direction;
			t_.vy <- -1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -4.50000000 * 0.01745329;
			t_.vx <- 5.50000000 * this.direction;
			t_.vy <- 2.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 2.50000000 * 0.01745329;
			t_.vx <- 0.50000000 * this.direction;
			t_.vy <- -0.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 12.00000000;
			t_.rot <- 6.50000000 * 0.01745329;
			t_.vx <- -3.50000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
		},
		null,
		function ()
		{
			this.PlaySE(3676);
			this.team.AddMP(-200, 90);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
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
		this.CenterUpdate(0.40000001, 1.00000000);
		this.subState();
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
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3675);
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 10.00000000;
			t_.rot <- -45 * 0.01745329;
			t_.vx <- -5.00000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -50 * 0.01745329;
			t_.vx <- -1.00000000 * this.direction;
			t_.vy <- 0.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- -47 * 0.01745329;
			t_.vx <- 2.50000000 * this.direction;
			t_.vy <- -1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -49.50000000 * 0.01745329;
			t_.vx <- 5.50000000 * this.direction;
			t_.vy <- 2.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- -42.50000000 * 0.01745329;
			t_.vx <- 0.50000000 * this.direction;
			t_.vy <- -0.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 12.00000000;
			t_.rot <- -39.50000000 * 0.01745329;
			t_.vx <- -3.50000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
		},
		null,
		function ()
		{
			this.PlaySE(3676);
			this.team.AddMP(-200, 90);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
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
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.subState = function ()
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
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3675);
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 10.00000000;
			t_.rot <- -45 * 0.01745329;
			t_.vx <- -5.00000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -50 * 0.01745329;
			t_.vx <- -1.00000000 * this.direction;
			t_.vy <- 0.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- -47 * 0.01745329;
			t_.vx <- 2.50000000 * this.direction;
			t_.vy <- -1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- -49.50000000 * 0.01745329;
			t_.vx <- 5.50000000 * this.direction;
			t_.vy <- 2.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- -42.50000000 * 0.01745329;
			t_.vx <- 0.50000000 * this.direction;
			t_.vy <- -0.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 12.00000000;
			t_.rot <- -39.50000000 * 0.01745329;
			t_.vx <- -3.50000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
		},
		null,
		function ()
		{
			this.PlaySE(3676);
			this.team.AddMP(-200, 90);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
		},
		function ()
		{
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
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 1.00000000);
		this.subState();
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
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3675);
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 10.00000000;
			t_.rot <- 30 * 0.01745329;
			t_.vx <- -5.00000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- 25 * 0.01745329;
			t_.vx <- -1.00000000 * this.direction;
			t_.vy <- 0.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 33 * 0.01745329;
			t_.vx <- 2.50000000 * this.direction;
			t_.vy <- -1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- 25.50000000 * 0.01745329;
			t_.vx <- 5.50000000 * this.direction;
			t_.vy <- 2.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 32.50000000 * 0.01745329;
			t_.vx <- 0.50000000 * this.direction;
			t_.vy <- -0.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 12.00000000;
			t_.rot <- 36.50000000 * 0.01745329;
			t_.vx <- -3.50000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
		},
		null,
		function ()
		{
			this.PlaySE(3676);
			this.team.AddMP(-200, 90);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
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
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.subState = function ()
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
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(3675);
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 10.00000000;
			t_.rot <- 30 * 0.01745329;
			t_.vx <- -5.00000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- 25 * 0.01745329;
			t_.vx <- -1.00000000 * this.direction;
			t_.vy <- 0.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 33 * 0.01745329;
			t_.vx <- 2.50000000 * this.direction;
			t_.vy <- -1.50000000;
			this.flag2.Add(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 9.00000000;
			t_.rot <- 25.50000000 * 0.01745329;
			t_.vx <- 5.50000000 * this.direction;
			t_.vy <- 2.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 11.00000000;
			t_.rot <- 32.50000000 * 0.01745329;
			t_.vx <- 0.50000000 * this.direction;
			t_.vy <- -0.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
			local t_ = {};
			t_.type <- this.rand() % 5 * 2;
			t_.v <- 12.00000000;
			t_.rot <- 36.50000000 * 0.01745329;
			t_.vx <- -3.50000000 * this.direction;
			t_.vy <- 1.50000000;
			this.flag2.Add(this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t_));
		},
		null,
		function ()
		{
			this.PlaySE(3676);
			this.team.AddMP(-200, 90);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
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
		this.CenterUpdate(0.40000001, 1.00000000);
		this.subState();
	};
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2010, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.count = 0;
			this.hitResult = 1;
			this.PlaySE(3678);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2011, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.count = 0;
			this.hitResult = 1;
			this.PlaySE(3678);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			this.SetSpeed_XY(0.00000000, 0.00000000);
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
		this.CenterUpdate(0.20000000, 2.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.LabelClear();
	this.atk_id = 131072;
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.SetMotion(2020, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.flag1 = this.SetCommonObjectDynamic(this.x, this.y, 1.00000000, this.ChargeShot_Aura, {}, this.weakref()).weakref();
	this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeRing, {}).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func[0].call(this.flag1);
		}

		if (this.flag2)
		{
			this.flag2.func[0].call(this.flag2);
		}
	};
	this.team.AddMP(-200, 120);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(3680);
		}
	];
	this.stateLabel = function ()
	{
		if (this.keyTake == 1)
		{
			local t_ = {};
			t_.kx <- this.input.x;
			t_.ky <- this.input.y;
			t_.charge <- this.count >= 120;

			if (this.count >= 8 && (this.input.b1 == 0 || ::battle.state != 8))
			{
				this.Shot_Charge_Fire(t_);
				return;
			}

			if (this.input.b4 > 0 && this.input.x * this.direction < 0 && this.input.y == 0 || this.command.Check(this.N4N4))
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					if (this.motion != 41)
					{
						this.DashBack_Init(null);
						return true;
					}
				}
				else if (this.dashCount <= 1 && this.motion != 43)
				{
					this.DashBack_Air_Init(null);
					return true;
				}
			}
		}

		this.GetFront();

		if (this.count % 30 == 1)
		{
			this.PlaySE(828);
		}

		this.CenterUpdate(0.40000001, 3.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
	this.AjustCenterStop();
	return true;
}

function Shot_Charge_Head( t )
{
	this.SetMotion(2029, 0);
	this.SetSpeed_XY(8.00000000 * this.direction, -16.00000000);
	this.stateLabel = function ()
	{
		this.rz += 6.00000000 * 0.01745329;
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.IsScreen(50))
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Charge_Fire( t )
{
	this.LabelReset();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.SetMotion(2020, 2);
	this.lavelClearEvent = null;
	this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);

	if (this.flag1)
	{
		this.flag1.func[0].call(this.flag1);
	}

	if (this.flag2)
	{
		this.flag2.func[1].call(this.flag2);
		this.PlaySE(3681);
	}

	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Charge_Head, {});
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 3.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;
	this.flag2.debri <- ::manbow.Actor2DProcGroup();
	this.flag2.num <- 0;
	this.lavelClearEvent = function ()
	{
		this.PlaySE(3681);
		this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Effect, {});
		this.flag2.debri.Foreach(function ()
		{
			this.func[1].call(this);
		});
	};
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			if (this.count % 4 == 1 || this.count <= 20)
			{
				local t_ = {};
				t_.type <- this.rand() % 4 * 3;

				if (this.flag2.num < 3)
				{
					this.flag2.num++;
					t_.type = 0;
				}
				else
				{
					this.flag2.num = 0;
				}

				this.flag2.debri.Add(this.SetShot(this.x + (-80 + this.rand() % 401) * this.direction, this.y + 100 + this.rand() % 321, this.direction, this.Shot_Barrage, t_));
			}
		}
	};
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(3000, 0);
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.PlaySE(3624);
			this.SetMotion(3000, 2);
			this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
			this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					if (this.flag1)
					{
						if (this.flag1 > 0)
						{
							this.SetSpeed_XY(35.00000000, 0.00000000);
						}
						else
						{
							this.SetSpeed_XY(-30.00000000, 0.00000000);
						}
					}
					else
					{
						this.SetSpeed_XY(30.00000000 * this.direction, 0.00000000);
					}
				}

				if (this.count == 10)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
				}

				if (this.count == 15)
				{
					this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
					this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});

					if ((this.input.x || this.input.y) && this.team.mp >= 200 && this.input.b2 > 0)
					{
						this.flag3 += 10;
						this.flag1 = this.input.x;
						this.flag2 = this.input.y;
						this.keyAction[0].call(this);
						return;
					}

					this.SetMotion(3000, 3);
					this.stateLabel = null;
				}
			};
		},
		null,
		null,
		function ()
		{
			if (this.flag3 == 0)
			{
				this.GetFront();
				this.SetMotion(3000, 5);
			}
			else
			{
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.count >= this.flag3)
					{
						this.GetFront();
						this.SetMotion(3000, 5);
						this.stateLabel = function ()
						{
						};
					}
				};
			}
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SPShot_A( t )
{
	this.SetMotion(3009, 0);
	this.sx = 1.75000000;
	this.stateLabel = function ()
	{
		this.sx *= 0.69999999;
		this.count++;

		if (this.count >= 15)
		{
			this.alpha = this.green = this.blue -= 0.07500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_A2( t )
{
	this.SetMotion(3009, 1);
	this.sx = this.sy = 0.50000000;
	this.flag1 = 12.00000000 * 0.01745329;
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0.92000002;
		this.sx = this.sy += (3.00000000 - this.sx) * 0.20000000;
		this.alpha = this.green = this.blue -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3010, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.centerStop = -2;
			this.SetSpeed_XY(-7.50000000 * this.direction, -2.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction < -2.50000000 ? 0.20000000 : 0.01000000);
				this.AddSpeed_XY(0.00000000, 0.10000000);
			};
		},
		function ()
		{
			local vec_ = this.Vector3();
			vec_.x = 75;
			vec_.RotateByDegree(110);
			this.PlaySE(3625);

			for( local i = 0; i < 7; i++ )
			{
				local t_ = {};
				t_.rot <- (110 - i * 15) * 0.01745329;
				this.SetShot(this.point0_x + vec_.x * this.direction, this.point0_y + vec_.y, this.direction, this.SPShot_B, t_);
				vec_.RotateByDegree(-15);
			}
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = null;
	this.SetMotion(3020, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			::camera.shake_radius = 2.00000000;
			this.PlaySE(3627);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.skillC_pole = this.SetShot(this.x + 220 * this.direction, ::battle.scroll_bottom, this.direction, this.SPShot_C, {}).weakref();
			}
			else
			{
				this.skillC_pole = this.SetShot(this.x + 200 * this.direction, ::battle.scroll_bottom, this.direction, this.SPShot_C, {}).weakref();
			}
		},
		function ()
		{
			::camera.shake_radius = 5.00000000;
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 20)
				{
					this.SetMotion(3020, 5);
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

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3030, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.flag2 = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.lavelClearEvent = function ()
	{
		this.flag1.Foreach(function ()
		{
			this.func[0].call(this);
		});
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3630);
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 2.00000000);

				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0.75000000);
				}

				if (this.count <= 20 && this.count % 2 == 1)
				{
					local t_ = {};
					t_.type <- this.flag2 % 4;
					t_.pos <- this.flag2 % 8;
					this.flag1.Add(this.SetShot(this.x, this.y + 300, this.direction, this.SPShot_D, t_));
					this.flag2++;
				}

				if (this.count >= 120 || this.count >= 35 && this.input.b2 <= 0)
				{
					this.PlaySE(3631);
					this.SetMotion(this.motion, 2);
					this.flag1.Foreach(function ()
					{
						this.func[1].call(this, false);
					});
					this.flag1.Clear();
					this.lavelClearEvent = null;
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);

		if (this.centerStop * this.centerStop <= 0)
		{
			this.VX_Brake(0.75000000);
		}
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag5 = t.rush;

	if (this.skillE_shot)
	{
		this.SetMotion(3042, 0);
		this.keyAction = [
			function ()
			{
				if (this.skillE_shot)
				{
					this.PlaySE(3635);
					this.skillE_shot.func[2].call(this.skillE_shot);
					this.skillE_shot = null;
				}
			}
		];
	}
	else
	{
		this.SetMotion(3040, 0);
		this.PlaySE(3633);
		local t_ = {};
		t_.rot <- 20.00000000 * 0.01745329;
		this.skillE_shot = this.SetShot(this.point0_x, this.point0_y + 300, this.direction, this.SPShot_E, t_).weakref();
		this.lavelClearEvent = function ()
		{
			if (this.skillE_shot)
			{
				this.skillE_shot.func[0].call(this.skillE_shot);
			}
		};
		this.keyAction = [
			function ()
			{
				this.PlaySE(3634);
				this.team.AddMP(-200, 120);

				if (this.skillE_shot)
				{
					this.skillE_shot.func[1].call(this.skillE_shot);
				}

				this.lavelClearEvent = null;
				this.stateLabel = function ()
				{
					if (this.skillE_shot && this.keyTake >= 3 && this.team.mp >= 200 && (this.command.rsv_k2 > 0 || this.flag5 && this.command.rsv_k0 > 0))
					{
						local t_ = {};
						t_.rush <- false;
						this.SP_E_Init(t_);
						return;
					}
				};
			}
		];
	}

	return true;
}

function SP_E_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.flag5 = t.rush;

	if (this.skillE_shot)
	{
		this.SetMotion(3042, 0);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.AjustCenterStop();
		this.keyAction = [
			function ()
			{
				if (this.skillE_shot)
				{
					this.PlaySE(3635);
					this.skillE_shot.func[2].call(this.skillE_shot);
					this.skillE_shot = null;
				}
			}
		];
	}
	else
	{
		this.SetMotion(3041, 0);
		this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
		this.AjustCenterStop();
		this.PlaySE(3633);
		local t_ = {};
		t_.rot <- 30 * 0.01745329;

		if (this.y > this.centerY)
		{
			t_.rot <- 10.00000000 * 0.01745329;
		}

		this.skillE_shot = this.SetShot(this.point0_x, this.point0_y + 300, this.direction, this.SPShot_E, t_).weakref();
		this.lavelClearEvent = function ()
		{
			if (this.skillE_shot)
			{
				this.skillE_shot.func[0].call(this.skillE_shot);
			}
		};
		this.keyAction = [
			function ()
			{
				this.PlaySE(3634);
				this.team.AddMP(-200, 120);

				if (this.skillE_shot)
				{
					this.skillE_shot.func[1].call(this.skillE_shot);
				}

				this.lavelClearEvent = null;
				this.stateLabel = function ()
				{
					if (this.skillE_shot && this.keyTake >= 3 && this.team.mp >= 200 && (this.command.rsv_k2 > 0 || this.flag5 && this.command.rsv_k0 > 0))
					{
						local t_ = {};
						t_.rush <- false;
						this.SP_E_Init(t_);
						return;
					}

					this.CenterUpdate(0.10000000, null);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0.50000000);
					}
				};
			},
			null,
			null,
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0.50000000);
					}

					if (this.skillE_shot && this.keyTake >= 3 && this.team.mp >= 200 && (this.command.rsv_k2 > 0 || this.flag5 && this.command.rsv_k0 > 0))
					{
						local t_ = {};
						t_.rush <- false;
						this.SP_E_Init(t_);
						return;
					}
				};
			}
		];
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.10000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.VX_Brake(0.50000000);
			}
		};
	}

	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(3050, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3637);
			this.team.AddMP(-200, 120);
			this.SetShot(this.direction == 1.00000000 ? ::camera.camera2d.right + 100 : ::camera.camera2d.left - 100, 860, -this.direction, this.SPShot_F, {});
		}
	];
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
			this.PlaySE(3640);
		},
		function ()
		{
			this.PlaySE(3641);
			this.hitResult = 1;
			local t_ = {};
			t_.rot <- 0.00000000;
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_);
			this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		null,
		function ()
		{
		}
	];
	return true;
}

function Spell_A_Gun( t )
{
	this.SetMotion(4009, 2);
	this.flag1 = this.Vector3();
	this.flag1.x = -1.00000000 * this.direction;
	this.flag1.y = 1.00000000;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.flag1.y += 0.50000000;
		this.rz -= (90 * 0.01745329 - this.rz) * 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4010, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = null;
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
			this.PlaySE(3643);
			this.hitResult = 1;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B, t_).weakref();
			this.count = 0;
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
			this.stateLabel = function ()
			{
				if (this.count >= 120)
				{
					this.PlaySE(3645);
					this.lavelClearEvent = null;

					if (this.flag1)
					{
						this.flag1.func[1].call(this.flag1);
					}

					this.SetMotion(4010, 3);
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
	this.SetMotion(4020, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.team.spell_enable_end = false;
			this.hitResult = 1;
			local t_ = {};
			t_.rot <- 0.00000000;
			t_.rate <- this.atkRate_Pat;
			t_.tower <- true;
			this.SetShot(640 + 1160 * this.direction, ::battle.scroll_bottom + 260, -this.direction, this.SpellShot_C, t_);
			this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
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
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–Œ\x2562Ž‹‚\x2563‚æI@ˆ\x2518¢ŠE‚\x2560‹\x2562‹C‚\x2261–");
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
			};
		},
		function ()
		{
			this.PlaySE(3652);
			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
			::camera.shake_radius = 5.00000000;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(640, 0, this.direction, this.SpellShot_ClimaxBrake, t_).weakref();
			this.SetShot(640, 0, this.direction, this.SpellShot_ClimaxBrakeB, t_);
			this.stateLabel = function ()
			{
				if (this.flag1 && this.flag1.hitResult & 1)
				{
					this.Spell_Climax_Hit(null);
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
	};
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.SetMotion(4901, 0);
	this.target.DamageGrab_Common(300, 2, this.target.direction);
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.count = 19;
	::battle.enableTimeUp = false;
	this.stateLabel = function ()
	{
		if (this.count == 20)
		{
			this.flag1.Add(this.SetFreeObject(640, 0, this.direction, this.ClimaxEffect_BallLight, {}));
		}

		if (this.count == 40)
		{
			this.flag1.Add(this.SetFreeObject(580, -100, this.direction, this.ClimaxEffect_BallRay, {}));
		}

		if (this.count == 50)
		{
			this.flag1.Add(this.SetFreeObject(800, -150, this.direction, this.ClimaxEffect_BallRay, {}));
		}

		if (this.count == 65)
		{
			this.flag1.Add(this.SetFreeObject(480, -200, this.direction, this.ClimaxEffect_BallRay, {}));
		}

		if (this.count == 80)
		{
			this.flag1.Add(this.SetFreeObject(720, -300, this.direction, this.ClimaxEffect_BallRay, {}));
		}

		if (this.count == 90)
		{
			this.flag1.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.FadeOut(1.00000000, 1.00000000, 1.00000000, 60);
		}

		if (this.count == 125)
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.Spell_Climax_SceneA(null);
		}
	};
}

function Spell_Climax_SceneA( t )
{
	this.LabelReset();
	this.PlaySE(3654);
	this.SetMotion(4901, 1);
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 60);
	this.EraceBackGround();
	this.target.DamageGrab_Common(308, 0, this.target.direction);
	this.flag5 = {};
	this.flag5.sumireko <- null;
	::camera.SetTarget(640, 360, 1.00000000, true);
	this.flag1.Add(this.SetFreeObject(640, 360, 1.00000000, this.ClimaxEffect_SceneA_Back, {}));
	this.flag1.Add(this.SetFreeObject(800, 360, 1.00000000, this.ClimaxEffect_SceneA_LightPilarA, {}));
	this.flag1.Add(this.SetFreeObject(800, 360, 1.00000000, this.ClimaxEffect_SceneA_LightPilarB, {}));
	this.flag5.sumireko = this.SetFreeObject(800, 360, 1.00000000, this.ClimaxEffect_SceneA_Sumireko, {});
	this.flag1.Add(this.flag5.sumireko);
	this.flag1.Add(this.SetFreeObjectDynamic(500, -200, 1.00000000, this.ClimaxEffect_SceneA_Vortex, {}));
	this.stateLabel = function ()
	{
		if (this.count == 180)
		{
			this.PlaySE(3687);
			this.flag1.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.flag2 = 1.00000000;
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 2 == 1)
				{
					this.flag2 += (25.00000000 - this.flag2) * 0.02500000;
					::camera.SetTarget(this.flag5.sumireko.point0_x, this.flag5.sumireko.point0_y, this.flag2, false);
				}

				if (this.count == 25)
				{
					this.flag1.Foreach(function ()
					{
						this.func[0].call(this);
					});
					this.flag5.sumireko = null;
					this.Spell_Climax_SceneB(null);
					return;
				}
			};
		}
	};
}

function Spell_Climax_SceneB( t )
{
	this.LabelReset();
	this.PlaySE(3655);
	this.SetMotion(4901, 1);
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 2);
	this.BackFadeOut(0.20000000, 0.00000000, 0.20000000, 1);
	this.flag1.Add(this.SetFreeObject(640, 360, 1.00000000, this.ClimaxCut_A, {}));
	this.stateLabel = function ()
	{
		if (this.count == 40)
		{
			this.flag1.Add(this.SetFreeObject(640, 360, 1.00000000, this.ClimaxCut_Flash, {}));
		}

		if (this.count == 70)
		{
			this.FadeOut(1.00000000, 1.00000000, 1.00000000, 60);
			this.flag1.Foreach(function ()
			{
				this.func[1].call(this);
			});
		}

		if (this.count == 140)
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.Spell_Climax_Finish(null);
		}
	};
}

function Spell_Climax_Finish( t )
{
	this.LabelReset();
	this.PlaySE(3656);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 20);
	this.BackFadeIn(1.00000000, 1.00000000, 1.00000000, 40);
	this.EraceBackGround(false);
	this.count = 0;
	this.SetMotion(4902, 0);
	::camera.shake_radius = 10.00000000;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag1.Add(this.SetShot(this.target.x, ::battle.scroll_top, this.direction, this.Climax_ShotLaser, t_));
	this.autoCamera = true;
	this.freeMap = false;
	::camera.ResetTarget();
	this.stateLabel = function ()
	{
		if (this.count == 150)
		{
			::battle.enableTimeUp = true;
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.SetMotion(4902, 1);
			this.stateLabel = null;
		}
	};
}

