function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 5)
	{
		this.BeginBattle_Miko(null);
		return;
	}

	this.BeginBattle(null);
}

function Func_Win()
{
	local r_ = this.rand() % 3;

	switch(r_)
	{
	case 0:
		this.WinA(null);
		break;

	case 1:
		this.WinB(null);
		break;

	case 2:
		this.WinC(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattle( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(1750);
			this.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginBattle_Kasa, {}).weakref());
		},
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function BeginBattle_Miko( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9001, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.Warp(::battle.start_x[this.team.index] - 390 * this.direction, this.centerY - 340);
	this.team.slave.BeginBattle_Slave(null);
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.PlaySE(1767);
			this.SetSpeed_Vec(25, 0,78539813.0, this.direction);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 1;
			this.SetMotion(this.motion, 1);
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
	this.SetMotion(9001, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.Warp(::battle.start_x[this.team.index] - 540 * this.direction, this.centerY - 340);
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.PlaySE(1767);
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
	this.keyAction = [
		function ()
		{
			::camera.shake_radius = 3,00000000.0;
			this.PlaySE(1751);
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

function WinB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.demoObject = [];
	this.flag1 = function ( t_ )
	{
		this.SetMotion(9011, 5 + this.rand() % 2);
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.sx = this.sy = 0,00000000.0;
		this.flag2 = 0,10000000.0 + this.rand() % 15 * 0,01000000.0;
		this.SetSpeed_XY((-1,00000000.0 - this.rand() % 21 * 0,10000000.0) * this.direction, this.rand() % 20 * 0,10000000.0);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(-0,02500000.0 * this.direction, 0,05000000.0);
			this.VX_Brake(0,01000000.0);
			this.count++;
			this.sx = this.sy += (this.flag2 - this.sx) * 0,05000000.0;

			if (this.count >= 25)
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					for( local i = 0; i < this.owner.demoObject.len(); i++ )
					{
						if (this.owner.demoObject[i] == this)
						{
							this.owner.demoObject.remove(i);
							break;
						}
					}

					this.ReleaseActor();
				}
			}
		};
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1752);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 4 == 0)
				{
					this.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.flag1, {}).weakref());
				}

				if (this.count == 120)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinC( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9012, 0);
	this.count = 0;
	this.demoObject = [
		this.SetFreeObject(this.x + 100 * this.direction, this.y - 600, this.direction, function ( t_ )
		{
			this.SetMotion(9012, 4);
			this.DrawActorPriority(180);
			this.SetSpeed_XY(0,00000000.0, 30,00000000.0);
			this.stateLabel = function ()
			{
				if (this.y > this.owner.y - 150)
				{
					this.VY_Brake(7,50000000.0);
				}
			};
			this.func = function ()
			{
				this.stateLabel = function ()
				{
					this.SetSpeed_XY(1,50000000.0 * this.direction * this.cos(this.count * 2 * 0,01745329.0), 0,00000000.0);
					this.count++;
				};
			};
		}, {}).weakref()
	];
	this.keyAction = [
		null,
		function ()
		{
			::camera.shake_radius = 3,00000000.0;
			this.PlaySE(1753);
			this.SetEffect(this.point1_x, this.point1_y, this.direction, this.EF_HitSmashC, {});
			this.demoObject[0].func();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 150)
				{
					this.CommonWin();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.count >= 40)
		{
			this.SetMotion(9012, 1);
			this.stateLabel = null;
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
		if (this.count == 60)
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
	this.SetSpeed_XY(8,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-7,00000000.0 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 8,00000000.0;
	t_.back <- -8,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- -21,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 21;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 8,00000000.0;
	t_.back <- -8,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- -21,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 21,00000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 8,00000000.0;
	t_.back <- -8,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- 21,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 21,00000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 8,00000000.0;
	t_.back <- -8,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- 21,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 21,00000000.0;
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
	if (t == null && this.GetFront())
	{
		this.DashBack_Init(null);
	}
	else
	{
		this.LabelClear();
		this.SetMotion(40, 0);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.count = 0;
		this.stateLabel = function ()
		{
			if (this.command.rsv_k0 && this.command.rsv_x * this.direction > 0)
			{
				this.Atk_LowDash_Init(null);
				this.command.ResetReserve();
				return true;
			}
		};
		this.keyAction = [
			function ()
			{
				this.PlaySE(1600);
				this.SetSpeed_XY(30,00000000.0 * this.direction, 0,00000000.0);
				this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
				this.stateLabel = function ()
				{
				};
			},
			function ()
			{
				if (this.input.x * this.direction > 0)
				{
					this.SetMotion(40, 5);
					this.count = 0;
					this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(this.va.x * this.direction > 8,50000000.0 ? 0,25000000.0 : 0,00000000.0);

						if (this.centerStop * this.centerStop <= 1)
						{
							if (this.input.y > 0)
							{
								this.SlideFall_Init(null);
								return;
							}
							else if (this.input.y < 0)
							{
								this.SlideUp_Init(null);
								return;
							}
						}

						if (this.count >= 60 || this.input.x * this.direction <= 0)
						{
							this.SetMotion(40, 7);
							this.stateLabel = function ()
							{
								this.VX_Brake(0,50000000.0);
							};
						}
					};
				}
				else
				{
					this.count = 0;
					this.SetSpeed_XY(8,00000000.0 * this.direction, 0,00000000.0);

					if (this.GetFront())
					{
						this.SetMotion(40, 4);
					}

					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
				}
			},
			function ()
			{
			},
			function ()
			{
				this.EndtoFreeMove();
			},
			function ()
			{
				this.EndtoFreeMove();
			}
		];
	}
}

function DashFront_Air_Init( t )
{
	if (t == null && this.GetFront())
	{
		this.DashBack_Air_Init(null);
	}
	else
	{
		this.LabelClear();
		this.AjustCenterStop();
		this.dashCount++;
		this.SetMotion(42, 0);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.count = 0;
		this.keyAction = [
			function ()
			{
				this.PlaySE(1600);
				this.SetSpeed_XY(30,00000000.0 * this.direction, 0,00000000.0);
			},
			function ()
			{
				this.count = 0;
				this.SetSpeed_XY(8,00000000.0 * this.direction, 0,00000000.0);
				this.SetMotion(this.motion, 4);
				this.stateLabel = function ()
				{
				};
			},
			null,
			null,
			function ()
			{
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);

					if (this.va.x * this.direction <= 8,00000000.0)
					{
						this.SetSpeed_XY(8,00000000.0 * this.direction, null);
					}

					if (this.y < 50)
					{
						this.CenterUpdate(0,25000000.0, 6,00000000.0);
					}
					else
					{
						this.VY_Brake(0,75000000.0);
					}

					if (this.input.x * this.direction <= 0 && this.count >= 6 || this.count >= 120)
					{
						this.stateLabel = function ()
						{
						};
						this.SetMotion(this.motion, 6);
						return;
					}
				};
			}
		];
	}
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1600);
			this.SetSpeed_XY(-20,00000000.0 * this.direction, 0,00000000.0);
			this.SetEffect(this.x, this.y, -this.direction, this.EF_Dash, {}, this.weakref());
		},
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,85000002.0);
			};
		},
		null,
		function ()
		{
			this.EndtoFreeMove();
		}
	];
}

function DashBack_Air_Init( t )
{
	this.LabelClear();
	this.SetMotion(43, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.AjustCenterStop();
	this.dashCount++;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1600);
			this.SetSpeed_XY(-20,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.va.x * this.direction >= -6,00000000.0)
				{
					this.SetSpeed_XY(-6,00000000.0 * this.direction, null);
				}

				if (this.y < 50)
				{
					this.CenterUpdate(0,25000000.0, 6,00000000.0);
				}
				else
				{
					this.VY_Brake(0,75000000.0);
				}

				if (this.input.x * this.direction >= 0 && this.count >= 6 || this.count >= 180)
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
					this.SetMotion(this.motion, 6);
					return;
				}
			};
		}
	];
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,85000002.0);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1601);
		}
	];
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,85000002.0);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1603);
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
		this.VX_Brake(0,75000000.0);
	};
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,00000000.0 * this.direction, null);
			this.PlaySE(1605);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(4,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);
			};
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
		this.VX_Brake(0,75000000.0);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,25000000.0);
			};
		},
		function ()
		{
			this.PlaySE(1605);
			this.SetSpeed_XY(2,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		},
		function ()
		{
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
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(1619);

			for( local i = 0,00000000.0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.rot <- i * 0,01745329.0;
				this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.AtkAir_Effect, t_));
			}

			this.lavelClearEvent = function ()
			{
				this.flag1.Foreach(function ()
				{
					this.func[0].call(this);
				});
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
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
			this.SetSpeed_XY(30,00000000.0 * this.direction, null);
			this.PlaySE(1607);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(5,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
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
			this.SetSpeed_XY(30,00000000.0 * this.direction, null);
			this.PlaySE(1607);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(5,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;

	if (this.centerStop * this.centerStop >= 4 && this.y > this.centerY)
	{
		this.SetMotion(1214, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1607);
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
				this.SetMotion(1214, 2);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
	}
	else
	{
		this.SetMotion(1212, 0);
		this.SetSpeed_XY(20,00000000.0 * this.direction, -12,50000000.0);
		this.PlaySE(1609);
		this.centerStop = -2;
		this.keyAction = [
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.y > this.centerY)
					{
						this.Warp(this.x, this.centerY);
						this.centerStop = 1;
						this.SetMotion(this.motion, 2);
						this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
						this.HitTargetReset();
						this.PlaySE(1610);
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.AtkHighUnder_Effect, {});
						this.stateLabel = null;
					}
				};
				this.centerStop = 2;
				this.SetSpeed_XY(0,00000000.0, 30,00000000.0);
			},
			null,
			function ()
			{
				this.SetSpeed_XY(-8,00000000.0 * this.direction, -10,00000000.0);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);
					this.AddSpeed_XY(0,00000000.0, 0,60000002.0);
				};
			}
		];
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0,00000000.0, 0,80000001.0);

			if (this.va.y > 0,00000000.0)
			{
				this.SetSpeed_XY(this.va.x, 0,00000000.0);
			}

			this.VX_Brake(1,25000000.0);
		};
	}

	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.flag1 = false;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1613);
			this.centerStop = -2;
			this.SetSpeed_XY(12,00000000.0 * this.direction, -20,00000000.0);
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(2,00000000.0, 2,00000000.0))
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1613);
			this.centerStop = -2;
			this.SetSpeed_Vec(17,50000000.0, -55 * 0,01745329.0, this.direction);
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(1,50000000.0, 4,00000000.0))
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 1,00000000.0);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,00000000.0);

				if (this.y > this.centerY && this.va.y > 0,00000000.0)
				{
					this.SetMotion(1220, 4);
					this.centerStop = 1;
					this.SetSpeed_XY(null, 2,00000000.0);
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
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1222, 0);

	if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
	{
		this.subState = function ()
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(1222, 3);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.AjustCenterStop();
		this.keyAction = [
			function ()
			{
				this.PlaySE(1613);
				this.centerStop = -2;
				this.SetSpeed_Vec(15,00000000.0, -45 * 0,01745329.0, this.direction);
				this.stateLabel = function ()
				{
					if (this.Vec_Brake(2,00000000.0, 4,00000000.0))
					{
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

							if (this.y > this.centerY)
							{
								this.centerStop = 1;
								this.SetSpeed_XY(this.va.x * 0,50000000.0, 3,00000000.0);
								this.SetMotion(1222, 3);
								this.stateLabel = function ()
								{
									this.VX_Brake(0,50000000.0);
								};
							}
						};
					}
				};
			},
			function ()
			{
			},
			function ()
			{
				this.EndtoFallLoop();
			}
		];
		this.stateLabel = function ()
		{
		};
	}
	else
	{
		this.SetMotion(1223, 0);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.keyAction = [
			function ()
			{
				this.centerStop = -2;
				this.SetSpeed_XY(7,50000000.0 * this.direction, -17,50000000.0);
			},
			function ()
			{
				this.PlaySE(1613);
				this.stateLabel = function ()
				{
					if (this.y < this.centerY)
					{
						this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
						this.SetMotion(1223, 4);
						this.stateLabel = function ()
						{
							if (this.centerStop * this.centerStop <= 1)
							{
								this.SetMotion(1223, 6);
								this.stateLabel = function ()
								{
									this.VX_Brake(0,50000000.0);
								};
							}
						};
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
	}

	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
	this.atk_id = 32;
	this.flag1 = 0;
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighUnder_Init(t);
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
	this.SetSpeed_XY(-12,50000000.0 * this.direction, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1621);
			this.SetSpeed_XY(25,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,10000002.0);
				this.CenterUpdate(0,10000000.0, 2,00000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
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
		this.VX_Brake(0,85000002.0);
		this.CenterUpdate(0,10000000.0, 2,00000000.0);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16;
	this.SetMotion(1750, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1629);
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 2,00000000.0 ? 0,75000000.0 : 0,00000000.0);
				this.CenterUpdate(0,10000000.0, 5,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
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
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.GetFront();
			this.combo_func = null;
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
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
	this.SetMotion(1232, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1629);
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 2,00000000.0 ? 0,75000000.0 : 0,00000000.0);
				this.CenterUpdate(0,10000000.0, 5,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1232, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
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
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1232, 3);
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
	this.flag1 = 0;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.SetSpeed_XY(17,50000000.0 * this.direction, null);
	this.hitCount = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
		this.CenterUpdate(0,25000000.0, 6,00000000.0);
	};
	this.SetMotion(1300, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1619);
			this.count = 0;

			for( local i = 0,00000000.0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.rot <- i * 0,01745329.0;
				this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.AtkLowDash_Effect, t_));
			}

			this.lavelClearEvent = function ()
			{
				this.flag2.Foreach(function ()
				{
					this.func[0].call(this);
				});
			};
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.CenterUpdate(0,25000000.0, 6,00000000.0);

				if (this.count % 10 == 1)
				{
					this.PlaySE(1619);
				}

				if (this.hitCount <= 3)
				{
					this.HitCycleUpdate(4);
				}
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,60000002.0);
			};
		}
	];
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1310, 0);
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,50000000.0);
			};
		},
		function ()
		{
			if (this.GetFront())
			{
				this.flag1 = true;
			}
			else
			{
				this.flag1 = false;
			}
		},
		function ()
		{
			this.PlaySE(1621);

			if (!this.flag1)
			{
				this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(1,25000000.0);
				};
			}
			else
			{
				this.SetSpeed_XY(35,00000000.0 * this.direction, 0,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(2,00000000.0);
				};
			}
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
	this.PlaySE(1765);
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
	this.target.DamageGrab_Common(300, 0, -this.direction);
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
	this.flag2 = this.SetFreeObject(this.x + 480 * this.direction, this.centerY - 320, this.direction, this.Atk_Throw_Kane, {}).weakref();

	if (this.flag2.x > ::battle.corner_right)
	{
		this.flag2.Warp(::battle.corner_right, this.flag2.y);
	}

	if (this.flag2.x < ::battle.corner_left)
	{
		this.flag2.Warp(::battle.corner_left, this.flag2.y);
	}

	this.stateLabel = function ()
	{
		this.AddSpeed_XY(1,50000000.0 * this.direction, 0,00000000.0, 20,00000000.0 * this.direction, 0,00000000.0);

		if (this.Atk_Grab_Hit_Update())
		{
			this.flag1.func[0].call(this.flag1);
			this.flag2.func[0].call(this.flag2);
			this.target.autoCamera = true;
			this.Grab_Blocked(null);
			this.Warp(this.x - 25 * this.direction, this.y);
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
	this.count = 0;
	this.target.autoCamera = true;
	this.target.DamageGrab_Common(303, 1, -this.direction);
	this.flag1.stateLabel = function ()
	{
		this.target.Warp(this.initTable.pare.point0_x - (this.target.point0_x - this.target.x), this.initTable.pare.point0_y - (this.target.point0_y - this.target.y));
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(1,50000000.0 * this.direction, 0,00000000.0, 20,00000000.0 * this.direction, 0,00000000.0);

		if (this.va.x > 0,00000000.0 && this.x > this.flag2.x - 120 || this.va.x < 0,00000000.0 && this.x < this.flag2.x + 120)
		{
			this.SetMotion(1802, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.target.DamageGrab_Common(301, 0, -this.direction);
			this.stateLabel = function ()
			{
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
		},
		function ()
		{
			this.target.DamageGrab_Common(310, 0, -this.direction);
			::camera.Shake(10,00000000.0);
			this.flag2.func[1].call(this.flag2);
			this.SetEffect(this.x + 125 * this.direction, this.y - 30, this.direction, this.EF_HitSmashC, {});
			this.PlaySE(1766);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.flag1.func[0].call(this.flag1);
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;
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
			this.SetSpeed_XY(-12,50000000.0 * this.direction, -12,50000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, -3,00000000.0 * this.direction);
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

				if (this.y >= this.centerY && this.va.y > 0,00000000.0)
				{
					this.SetMotion(this.motion, 5);
					this.centerStop = 1;
					this.SetSpeed_XY(this.va.x, 3,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
}

function Atk_Throw_Kane( t )
{
	this.SetMotion(9012, 4);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;
				this.AddSpeed_XY(0,00000000.0, -1,50000000.0, 0,00000000.0, -20,00000000.0);
			};
		},
		function ()
		{
			this.alpha = 2,00000000.0;
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(2,50000000.0, 1,00000000.0 * this.direction);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(0,00000000.0, (this.owner.centerY - 50 - this.y) * 0,25000000.0);
	};
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
	this.flag2 = -10 * 0,01745329.0;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1623);
			local t = {};
			t.rot <- this.flag1;
			t.v <- 12,50000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);

			if (this.shotNum >= 1)
			{
				local t = {};
				t.rot <- this.flag1 + this.flag2;
				t.v <- 11,00000000.0;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			if (this.shotNum >= 2)
			{
				local t = {};
				t.rot <- this.flag1 + this.flag2 * 2,00000000.0;
				t.v <- 9,50000000.0;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.shotNum = 0;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
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
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = -10 * 0,01745329.0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1623);
			local t = {};
			t.rot <- this.flag1;
			t.v <- 12,50000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);

			if (this.shotNum >= 1)
			{
				local t = {};
				t.rot <- this.flag1 + this.flag2;
				t.v <- 11,00000000.0;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			if (this.shotNum >= 2)
			{
				local t = {};
				t.rot <- this.flag1 + this.flag2 * 2,00000000.0;
				t.v <- 9,50000000.0;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			}

			this.shotNum = 0;
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,05000000.0);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.Shot_Normal_Init.call(this, t);
	this.flag1 = -45 * 0,01745329.0;
	this.flag2 = -10 * 0,01745329.0;
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.Shot_Normal_Air_Init.call(this, t);
	this.flag1 = -45 * 0,01745329.0;
	this.flag2 = -10 * 0,01745329.0;
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.Shot_Normal_Init.call(this, t);
	this.flag1 = 45 * 0,01745329.0;
	this.flag2 = 10 * 0,01745329.0;
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.Shot_Normal_Air_Init.call(this, t);
	this.flag1 = 45 * 0,01745329.0;
	this.flag2 = 10 * 0,01745329.0;
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
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, null);
			this.team.AddMP(-200, 90);
			this.PlaySE(1626);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2011, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, null);
			this.team.AddMP(-200, 90);
			this.PlaySE(1626);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,05000000.0);
		}
	};
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;
	this.flag2.rot <- 0,00000000.0;
	this.flag2.pos <- this.Vector3();
	this.flag2.pos.x = 80;
	this.flag2.rotSpeed <- 11 * 0,01745329.0;
	this.flag2.direction <- this.direction;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			if (this.count % 4 == 3)
			{
				this.PlaySE(1623);

				for( local i = 0; i < 3; i++ )
				{
					local t_ = {};
					t_.rot <- this.flag2.rot + i * 120 * 0,01745329.0;
					this.SetShot(this.x + this.flag2.pos.x * this.flag2.direction, this.y + this.flag2.pos.y, this.flag2.direction, this.Shot_Barrage, t_);
					this.flag2.pos.RotateByRadian(120 * 0,01745329.0);
				}

				this.flag2.rot += this.flag2.rotSpeed;
				this.flag2.pos.RotateByRadian(this.flag2.rotSpeed);
			}
		}
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5,50000000.0;
	this.flag2.vy <- 2,50000000.0;
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
	this.hitResult = 1;
	this.SetMotion(2020, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag4 = t.charge;
	this.count = 0;
	this.flag2 = 0;

	if (t.ky == 0)
	{
		this.flag1 = 0,00000000.0;
	}
	else if (t.ky > 0)
	{
		this.flag1 = 20 * 0,01745329.0;
		this.flag2 = 2;
	}
	else
	{
		this.flag1 = -20 * 0,01745329.0;
		this.flag2 = 1;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
		},
		function ()
		{
		},
		function ()
		{
			if (this.flag4)
			{
				local t_ = {};
				t_.rot <- this.flag1;
				t_.keyTake <- this.flag2;
				t_.v <- 30,00000000.0;
				t_.flash <- true;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_FullCharge, t_);
			}
			else
			{
				local t_ = {};
				t_.rot <- this.flag1;
				t_.keyTake <- this.flag2;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_);
			}

			this.PlaySE(1710);
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.atk_id = 524288;
	this.hitCount = 0;
	this.count = 0;
	this.flag1 = 0,50000000.0;
	this.flag2 = this.SetFreeObject(this.x - 17,50000000.0 * 15 * this.direction, this.y, this.direction, this.Okult_DummyBike, {}).weakref();
	this.PlaySE(1754);
	this.airByke = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func[1].call(this.flag2);
		}

		this.flag2 = null;
		this.lavelClearEvent = null;
	};
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(7,50000000.0 * this.direction, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ChargeO, {});
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,20000000.0, 4,00000000.0);
				this.team.AddMP(-2, 120);
				this.team.op_stop = 300;
				this.team.op_stop_max = 300;

				if (this.hitCount < 3)
				{
					this.HitCycleUpdate(10);
				}

				this.AddSpeed_XY(this.va.x * this.direction <= 17,50000000.0 ? this.flag1 * this.direction : 0,00000000.0, 0,00000000.0);

				if (this.va.x * this.direction >= 10,00000000.0)
				{
					if (this.wall == this.direction || this.hitCount >= 3 || this.team.mp <= 0)
					{
						this.Okult_RideOff_Init(false);
						return;
					}

					if (this.input.y < 0)
					{
						this.Okult_RideOff_Init(true);
						return;
					}

					if (this.input.x * this.direction < 0)
					{
						this.HitReset();
						this.hitCount = 0;
						this.SetMotion(2500, 4);
						this.PlaySE(1755);
						this.count = 0;
						this.stateLabel = function ()
						{
							this.team.op_stop = 300;
							this.team.op_stop_max = 300;

							if (this.keyTake == 4 && this.count <= 20)
							{
								this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Okult_BikeSpark, {});
							}

							this.CenterUpdate(0,10000000.0, 1,00000000.0);
							this.team.AddMP(-2, 120);

							if (this.count <= 10)
							{
								this.VX_Brake(0,75000000.0);
							}
							else
							{
								this.AddSpeed_XY(this.va.x * this.direction >= -17,50000000.0 ? -0,75000000.0 * this.direction : 0,00000000.0, 0,00000000.0);
							}
						};
					}
				}
			};
		},
		null,
		function ()
		{
		},
		function ()
		{
			this.SetMotion(2500, 1);
			this.direction = -this.direction;
			this.keyAction[0].call(this);
		},
		function ()
		{
			this.SetMotion(2500, 1);
			this.direction = -this.direction;
			this.keyAction[0].call(this);
		}
	];
	this.stateLabel = function ()
	{
		this.team.op_stop = 300;
		this.team.op_stop_max = 300;

		if (this.count == 15)
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.lavelClearEvent = null;
			this.flag2 = null;
		}
	};
	return true;
}

function Okult_RideOff_Init( t )
{
	this.LabelClear();
	this.SetMotion(2500, 5);

	if (t)
	{
		this.flag1 = true;
	}
	else
	{
		this.flag1 = false;
	}

	this.SetEndMotionCallbackFunction(function ()
	{
		this.EndtoFallLoop();
	});
	local t_ = {};
	t_.vx <- this.va.x;
	t_.enableHit <- false;

	if (this.flag1)
	{
		t_.enableHit = true;
	}

	t_.vy <- -10;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.centerStop = -3;
		this.byke = this.SetShot(this.x, this.y, this.direction, this.OkultShot_Bike, t_).weakref();
		this.SetSpeed_XY(this.Math_MinMax(this.va.x * 0,50000000.0, -6,00000000.0, 6,00000000.0), -13,50000000.0);
	}
	else
	{
		this.centerStop = -3;

		if (this.y > this.centerY)
		{
			t_.vy = -17,50000000.0;
			this.byke = this.SetShot(this.x, this.y, this.direction, this.OkultShot_Bike, t_).weakref();
			this.SetSpeed_XY(this.Math_MinMax(this.va.x * 0,50000000.0, -6,00000000.0, 6,00000000.0), -17,50000000.0);
		}
		else
		{
			this.byke = this.SetShot(this.x, this.y, this.direction, this.OkultShot_Bike, t_).weakref();
			this.SetSpeed_XY(this.Math_MinMax(this.va.x * 0,50000000.0, -6,00000000.0, 6,00000000.0), -13,50000000.0);
		}
	}

	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
}

function SP_Chant( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3009, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = true;
	this.keyAction = [
		function ()
		{
			this.Add_ChantCount();
			this.PlaySE(1740);
			::camera.shake_radius = 2,00000000.0;
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % 25 == 24 && this.chant < 5)
				{
					this.Add_ChantCount();
					this.PlaySE(1740);
					::camera.shake_radius = 2,00000000.0;
				}

				if (this.count >= 10 && !this.flag1 || this.chant >= 5)
				{
					this.SetMotion(3009, 3);
					this.stateLabel = null;
				}

				if (this.count >= 12)
				{
					this.CenterUpdate(0,05000000.0, 5,00000000.0);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.input.b2 == 0)
		{
			this.flag1 = false;
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.count = 0;
	this.flag5 = t.rush;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3000, 0);
	this.Lost_ChantCount();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(15,50000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.PlaySE(1700);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);

				if (this.command.rsv_k2 > 0 || this.flag5 && this.command.rsv_k0 > 0)
				{
					this.SP_A_Init2(null);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function SP_A_Init2( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.SetMotion(3001, 0);
	this.SetSpeed_XY(15,50000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1701);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);

				if (this.command.rsv_k2 > 0 || this.flag5 && this.command.rsv_k0 > 0)
				{
					this.SP_A_Init3(null);
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
				this.VX_Brake(1,50000000.0);
			};
		}
	];
	return true;
}

function SP_A_Init3( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.SetMotion(3002, 0);
	this.SetSpeed_XY(15,50000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,75000000.0, null);
			this.PlaySE(1701);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,50000000.0);
			};
		}
	];
	return true;
}

function SP_A6_Init( t )
{
	this.SetMotion(3003, 0);
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
	this.PlaySE(1600);
	this.atk_id = 1048576;
	this.keyAction = [
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,50000000.0);
			};
		},
		function ()
		{
			if (this.GetFront())
			{
				this.flag1 = true;
			}
			else
			{
				this.flag1 = false;
			}
		},
		function ()
		{
			this.PlaySE(1621);

			if (!this.flag1)
			{
				this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(1,25000000.0);
				};
			}
			else
			{
				this.SetSpeed_XY(35,00000000.0 * this.direction, 0,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(2,00000000.0);
				};
			}
		}
	];
	return true;
}

function SP_A2_Init( t )
{
	this.SetMotion(3004, 0);
	this.SetSpeed_XY(27,50000000.0 * this.direction, -17,50000000.0);
	this.PlaySE(1609);
	this.atk_id = 1048576;
	this.centerStop = -2;
	this.keyAction = [
		function ()
		{
			this.stateLabel = null;
			this.centerStop = 2;
			this.SetSpeed_XY(0,00000000.0, 30,00000000.0);
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.HitTargetReset();
			this.PlaySE(1610);
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_A, {});
		},
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, -15,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,80000001.0);

		if (this.va.y > 0,00000000.0)
		{
			this.SetSpeed_XY(this.va.x, 0,00000000.0);
		}

		this.VX_Brake(1,25000000.0);
	};
	return true;
}

function SP_A8_Init( t )
{
	this.SetMotion(3005, 0);
	this.atk_id = 1048576;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1613);
			this.centerStop = -2;
			this.SetSpeed_XY(12,00000000.0 * this.direction, -20,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(2,00000000.0, 2,00000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3010, 0);
	this.Lost_ChantCount();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 8;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1704);
			::camera.shake_radius = 4,00000000.0;
			local t_ = {};
			t_.k <- this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
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
		this.VX_Brake(0,20000000.0);
	};
	return true;
}

function SP_B_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3011, 0);
	this.Lost_ChantCount();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 8;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1704);
			::camera.shake_radius = 4,00000000.0;
			local t_ = {};
			t_.k <- this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
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

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 4194304;
	this.Lost_ChantCount();
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.flag1 = 6;
	this.SetMotion(3020, 0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1706);
			local t_ = {};
			t_.vy <- 0,50000000.0;

			switch(this.flag1)
			{
			case 6:
				t_.count <- 10;
				break;

			case 4:
				t_.count <- 60;
				break;

			default:
				t_.count <- 20;
				break;
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C_Core, t_);
		},
		function ()
		{
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
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(this.va.x * this.va.x > 1,00000000.0 ? 0,25000000.0 : 0,01000000.0);
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8388608;
	this.Lost_ChantCount();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = true;
	this.flag2 = 40,00000000.0;
	this.flag3 = 0;
	this.flag5 = t.rush;
	this.subState = function ()
	{
		if (this.flag1 && (this.input.b2 == 0 && this.flag5 == false || this.input.b0 == 0 && this.flag5))
		{
			this.flag1 = false;
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.team.AddMP(-200, 120);
			this.PlaySE(1708);
			this.flag1 = this.x;
			this.SetSpeed_XY(this.flag2 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.hitResult & 13)
				{
					this.SetSpeed_XY(25,00000000.0 * this.direction, 0,00000000.0);
				}

				this.SetFreeObject(this.x, this.y, this.direction, this.BossB_Trail, {});
			};
		},
		function ()
		{
			this.direction = -this.direction;
			this.SetSpeed_XY(-25,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(2,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.SetMotion(3030, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 5)
				{
					this.PlaySE(1742);
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_F, {});
				}

				if (this.count >= 4 && !this.flag1 || this.count >= 30)
				{
					if (this.count > 4)
					{
						this.flag2 = 45;
						this.flag3 = 1;
					}

					if (this.count >= 30)
					{
						this.flag2 = 50;
						this.flag3 = 2;
					}

					this.func[0].call(this);
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.count >= 4 && this.hitResult & 13)
				{
					this.count = 0;
					this.direction = -this.direction;
					this.SetSpeed_XY(-25,00000000.0 * this.direction, 0,00000000.0);
					local t_ = {};
					t_.type <- this.flag3;
					this.SetShot(this.target.x, this.target.y, this.direction, this.SPShot_D, t_);
					this.SetMotion(3030, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(2,50000000.0);
					};
					return;
				}

				if (this.count >= 20)
				{
					this.count = 0;
					this.direction = -this.direction;
					this.SetSpeed_XY(-25,00000000.0 * this.direction, 0,00000000.0);
					this.SetMotion(3032, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(2,50000000.0);
					};
					return;
				}
			};
		}
	];
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.atk_id = 16777216;
	this.Lost_ChantCount();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();

	if (this.y < this.centerY)
	{
		this.SetMotion(3050, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1712);
				this.SetSpeed_XY(0,00000000.0, -20,00000000.0);
				this.centerStop = -2;
			},
			function ()
			{
				this.SetSpeed_XY(0,00000000.0, this.va.y * 0,50000000.0);
				this.stateLabel = function ()
				{
					this.VY_Brake(0,50000000.0);
				};
			},
			function ()
			{
				this.PlaySE(1713);
				this.team.AddMP(-200, 120);
				this.SetSpeed_XY(25,00000000.0 * this.direction, 20,00000000.0);
				this.centerStop = 2;
				this.stateLabel = function ()
				{
					if (this.y > this.centerY)
					{
						this.SetMotion(3050, 4);
						this.SetSpeed_XY(this.va.x * 0,34999999.0, this.va.y * 0,34999999.0);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,15000001.0);
						};
					}
				};
			},
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0,30000001.0, this.va.y * 0,30000001.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
					this.VX_Brake(0,05000000.0);
				};
			},
			function ()
			{
			}
		];
	}
	else
	{
		this.SetMotion(3051, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1712);
				this.SetSpeed_XY(0,00000000.0, 20,00000000.0);
				this.centerStop = 2;
			},
			function ()
			{
				this.SetSpeed_XY(0,00000000.0, this.va.y * 0,50000000.0);
				this.stateLabel = function ()
				{
					this.VY_Brake(0,50000000.0);
				};
			},
			function ()
			{
				this.PlaySE(1713);
				this.team.AddMP(-200, 120);
				this.SetSpeed_XY(20,00000000.0 * this.direction, -20,00000000.0);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					if (this.y < this.centerY)
					{
						this.SetMotion(3051, 4);
						this.SetSpeed_XY(this.va.x * 0,34999999.0, this.va.y * 0,34999999.0);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,15000001.0);
						};
					}
				};
			},
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0,30000001.0, this.va.y * 0,30000001.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
					this.VX_Brake(0,05000000.0);
				};
			},
			function ()
			{
			}
		];
	}

	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 33554432;
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.SetMotion(3064, 0);
	this.flag1 = 30;
	this.flag2 = 35;
	this.flag4 = this.chant;
	this.Lost_ChantCount();
	this.Lost_ChantCount();
	this.Lost_ChantCount();
	this.Lost_ChantCount();
	this.Lost_ChantCount();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(1742);
			this.flag5 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_F, {}).weakref();
			this.armor = 2;
			this.lavelClearEvent = function ()
			{
				this.baseBuff = null;
				this.DamageBuffAjust();
			};
			this.baseBuff = function ()
			{
				this.defRate *= 0,50000000.0;
			};
			this.armorEvent = function ()
			{
				this.count = this.flag1;
			};
			this.DamageBuffAjust();
			this.stateLabel = function ()
			{
				this.armor = 2;

				if (this.flag5)
				{
					this.flag5.Warp(this.point0_x, this.point0_y);
				}

				this.VX_Brake(this.centerStop == 0 ? 0,75000000.0 : 0,10000000.0);
				this.CenterUpdate(0,25000000.0, 2,00000000.0);

				if (this.count % 9 == 1)
				{
					this.SetFreeObject(this.x, this.y + 75, this.rand() % 100 >= 50 ? 1,00000000.0 : -1,00000000.0, this.SPShot_F_Aura, {});
				}

				if (this.count > this.flag1)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.armor = 2;

						if (this.flag5)
						{
							this.flag5.Warp(this.point0_x, this.point0_y);
						}

						this.VX_Brake(this.centerStop == 0 ? 0,75000000.0 : 0,10000000.0);
						this.CenterUpdate(0,25000000.0, 2,00000000.0);
					};
				}
			};
		},
		null,
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1743);
			::camera.shake_radius = 3,00000000.0;
			this.SetSpeed_XY(15,00000000.0 * this.direction, null);
			local t_ = {};
			t_.scale <- 0,87500000.0;

			if (this.flag4 <= 1)
			{
				t_.scale = 0,75000000.0;
			}

			if (this.flag4 >= 4)
			{
				t_.scale = 1,00000000.0;
			}

			this.flag3 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F_Main, t_).weakref();
			this.stateLabel = function ()
			{
				if (this.chant > 0)
				{
					this.armor = 2;
				}

				if (this.flag3)
				{
					this.flag3.Warp(this.point0_x, this.point0_y);
				}

				this.VX_Brake(1,00000000.0);
				this.CenterUpdate(0,10000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.count = 0;
			this.lavelClearEvent = null;
			this.baseBuff = null;
			this.DamageBuffAjust();
			this.stateLabel = function ()
			{
				if (this.flag3)
				{
					this.flag3.Warp(this.point0_x, this.point0_y);
				}

				this.VX_Brake(1,00000000.0);
				this.CenterUpdate(0,10000000.0, 0,50000000.0);

				if (this.count > this.flag2)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
					};
				}
			};
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
		this.VX_Brake(this.centerStop == 0 ? 0,75000000.0 : 0,10000000.0);
		this.CenterUpdate(0,25000000.0, 2,00000000.0);
		this.armor = 2;
	};
	return true;
}

function SP_G_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1073741824;
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
	this.AjustCenterStop();
	this.SetMotion(3070, 0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.Lost_ChantCount();
			this.count = 0;
			this.PlaySE(1762);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_G, {});
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
		this.CenterUpdate(0,05000000.0, 2,00000000.0);
	};
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4000, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.count = 0;
			this.PlaySE(1715);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_).weakref();
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		if (this.keyTake == 3 && this.count >= 30)
		{
			if (this.hitResult == 1 && this.target.team.life > 0)
			{
				this.Spell_A_Lock(null);
			}
		}
	};
	return true;
}

function Spell_A_Lock( t )
{
	this.LabelReset();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 67108864;
	this.SetMotion(4001, 0);
	this.flag2 = 0;
	this.flag3 = false;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1719);
			this.freeMap = true;
			this.SetSpeed_XY(40,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.Warp(this.target.x - 200 * this.direction, this.target.y);

			if (this.y > this.centerY)
			{
				this.centerStop = 2;
			}

			if (this.y < this.centerY)
			{
				this.centerStop = -2;
			}

			this.SetSpeed_XY(40,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(2,00000000.0);
			};
		},
		function ()
		{
			this.PlaySE(1717);
			this.stateLabel = function ()
			{
				this.VX_Brake(2,00000000.0);

				if (this.hitResult & 1 && this.target.team.life > 0)
				{
					this.target.DamageGrab_Common(301, 1, this.target.direction);
					this.flag3 = true;
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(2,00000000.0);

				if (this.count >= 30)
				{
					if (this.flag3)
					{
						this.Spell_A_LockB(null);
						return;
					}
					else
					{
						this.SetMotion(4001, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
}

function Spell_A_LockB( t )
{
	this.atk_id = 67108864;
	this.LabelReset();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.target.DamageGrab_Common(301, 1, this.target.direction);
	this.SetMotion(4002, 0);
	this.GetFront();
	this.flag2 = 0;
	this.target.team.master.enableKO = false;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = false;
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(1719);
			this.freeMap = true;
			this.SetSpeed_XY(30,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.Warp(this.target.x, this.target.y);
			this.cameraPos.x = this.target.x;
			this.cameraPos.y = this.target.y;
			this.autoCamera = false;
			this.flag1 = 20;
			this.stateLabel = function ()
			{
				if (this.count >= 5)
				{
					if (this.count % 4 == 1 && this.flag1 > 0)
					{
						local t_ = {};
						t_.rot <- this.rand() % 360 * 0,01745329.0;
						t_.rot2 <- t_.rot;
						t_.rot2 += (10 - this.rand() % 21) * 0,01745329.0;
						this.SetFreeObject(this.target.x + 400 * this.cos(t_.rot2 + 3,14159203.0) * this.direction, this.target.y + 400 * this.sin(t_.rot2 + 3,14159203.0), this.direction, this.SpellShot_A2, t_);
						::camera.shake_radius = 2,00000000.0;
						this.KnockBackTarget(this.direction);
						this.SetEffect(this.target.x + 75 - this.rand() % 150, this.target.y + 75 - this.rand() % 150, this.direction, this.EF_HitSmashC, {});
						this.PlaySE(1719);
						this.PlaySE(1720);
						this.flag1--;
					}
				}

				if (this.flag1 <= 0)
				{
					this.autoCamera = true;
					this.SetMotion(4002, 4);
					this.centerStop = -2;
					this.GetFront();
					this.SetSpeed_XY(-8,00000000.0 * this.direction, -18,00000000.0);
					this.Warp(this.target.x - 50 * this.direction, this.target.y - 0);
					this.stateLabel = function ()
					{
						this.Vec_Brake(1,50000000.0, 1,00000000.0);
					};
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.count = 0;
			::camera.shake_radius = 7,00000000.0;
			this.BackFadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 1);
			this.PlaySE(1721);
			this.DrawActorPriority(this.drawPriority);
			this.Warp(this.target.x + 0 * this.direction, this.target.y + 0);
			this.SetSpeed_Vec(1,00000000.0, 45 * 0,01745329.0, this.direction);
			this.KnockBackTarget(-this.direction);
			this.stateLabel = function ()
			{
				if (this.count == 50)
				{
				}

				if (this.count >= 60)
				{
					this.SetSpeed_Vec(20,00000000.0, 45 * 0,01745329.0, this.direction);
					this.centerStop = 2;
					this.SetMotion(4002, 7);
					this.atk_id = 67108864;
					this.target.team.master.enableKO = true;

					if (this.target.team.slave)
					{
						this.target.team.slave.enableKO = true;
					}

					this.KnockBackTarget(-this.direction);
					this.freeMap = false;
					this.BackFadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 1);
					this.stateLabel = function ()
					{
						this.Vec_Brake(1,50000000.0, 1,00000000.0);
					};
				}
			};
		}
	];
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
	this.PlaySE(1724);
	this.SetSpeed_XY(this.centerStop == 0 ? 0,00000000.0 : this.va.x * 0,10000000.0, this.va.y * 0,10000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,05000000.0, 1,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.flag1 = this.Vector3();
			this.flag1.x = this.va.x;
			this.flag1.y = this.va.y;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.UseSpellCard(60, -this.team.sp_max);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.flag1.x, this.flag1.y);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,05000000.0, 1,50000000.0);

				if (this.hitResult & 16)
				{
					this.Spell_B_Catch(null);
					return;
				}
				else if (this.hitResult & 256)
				{
					this.Spell_B_Catch(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	return true;
}

function Spell_B_Catch( t )
{
	this.LabelReset();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(4011, 0);
	this.PlaySE(1724);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetTimeStop(60);
	this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 10);
	this.PlaySE(1725);
	this.SetFreeObject(this.x, this.point0_y, this.direction, this.SpellShot_B, {});
	this.flag1 = true;

	if (this.damageTarget && this.damageTarget.owner == this)
	{
		this.flag1 = false;
	}

	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 30);
		},
		function ()
		{
			this.PlaySE(1726);
			this.count = 0;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			t_.type <- this.flag1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B_Beam, t_);

			for( local i = 90; i >= -90; i = i - 30 )
			{
				local t_ = {};
				t_.rot <- i * 0,01745329.0;
				this.SetFreeObject(this.x, this.point0_y, this.direction, this.SpellShot_B_Wing, t_);
			}

			this.SetFreeObject(this.x, this.point0_y, this.direction, this.SpellShot_B_Back, {});
			this.stateLabel = function ()
			{
				::camera.shake_radius = 7,00000000.0;

				if (this.count >= 120)
				{
					this.SetMotion(this.motion, 3);
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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.count = 0;
			::camera.shake_radius = 6,00000000.0;
			this.hitResult = 1;
			this.PlaySE(1745);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.x + 280 * this.direction, ::battle.scroll_top - 300, this.direction, this.SpellShot_C, t_).weakref();
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

function ClimaxEffect_DashSpark( t )
{
	this.SetMotion(4909, 2);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;
				this.blue = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,25000000.0;
	};
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.flag1 = -3,00000000.0;
	this.flag2 = null;
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–‚P‚O‚OƒLƒ‚\x253c‹ó‚ð‹ì‚¯‚ëI–");
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;

				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}
			};
		},
		function ()
		{
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
			this.count = 0;
			this.PlaySE(1730);
			this.SetSpeed_XY(40,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1 && this.target.damageTarget == this)
				{
					this.Climax_Hit(null);
					return;
				}
				else if (this.hitResult & 8 || this.hitResult & 4 || this.wall == this.direction || this.count >= 30)
				{
					this.SetMotion(this.motion, 5);

					if (this.flag2)
					{
						this.flag2.func[0].call(this.flag2);
					}

					this.SetSpeed_XY(7,00000000.0 * this.direction, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,25000000.0);
					};
				}
			};
		},
		function ()
		{
			this.flag2 = this.SetFreeObject(this.point0_x, this.point0_y, -this.direction, this.ClimaxEffect_DashSpark, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(4,00000000.0);
		this.SetSpeed_XY(this.va.x + this.flag1 * this.direction, 0,00000000.0);
		this.flag1 += 0,10000000.0;

		if (this.flag1 > 0)
		{
			this.flag1 = 0,00000000.0;
		}
	};
	return true;
}

function Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 4);
	this.SetSpeed_XY(0,00000000.0 * this.direction, 0,00000000.0);
	::battle.enableTimeUp = false;
	this.freeMap = true;
	this.target.attackTarget = this.weakref();
	this.target.enableStandUp = false;
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.SetSpeed_XY(40,00000000.0 * this.direction, 0,00000000.0);
		}

		if (this.count >= 90 && (this.x < ::battle.scroll_left - 200 || this.x > ::battle.scroll_right + 200))
		{
			this.flag2.func[0].call(this.flag2);
			this.Climax_Cut(null);
		}
	};
	return true;
}

function Climax_Cut( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4900, 0);
	this.SetTimeStop(600);
	this.PlaySE(1760);
	::camera.SetTarget(640, 360, 1,00000000.0, true);
	this.EraceBackGround();
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.back <- this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Back, {}).weakref();
	this.flag5.main <- this.SetFreeObject(1280, 500, 1,00000000.0, this.Climax_Actor, {}).weakref();
	this.flag1.Add(this.flag5.back);
	this.flag1.Add(this.flag5.main);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 50)
		{
		}

		if (this.count == 60)
		{
			this.PlaySE(1757);
			this.flag5.back.func[1].call(this.flag5.back);
			this.flag5.main.func[1].call(this.flag5.main);
		}

		if (this.count == 110)
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.EraceBackGround(false);
			this.Climax_Finish(null);
		}
	};
}

function Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetTimeStop(1);
	this.SetMotion(4901, 2);
	this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 30);
	this.PlaySE(1758);
	this.direction = -this.direction;
	this.SetSpeed_XY(50,00000000.0 * this.direction, 0,00000000.0);
	this.target.x = 640 - 360 * this.direction;
	this.target.y = this.centerY;
	this.target.attackTarget = null;
	this.target.enableStandUp = true;
	this.x = this.target.x - 400 * this.direction;
	this.y = this.centerY;
	this.target.SetMotion(200, 0);
	this.target.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	::camera.ResetTarget();
	::camera.shake_radius = 30,00000000.0;
	this.hitCount = 0;
	this.stateLabel = function ()
	{
		if (this.x > ::battle.scroll_right + 1800 || this.x < ::battle.scroll_left - 1800)
		{
			this.direction = -this.direction;
			this.SetMotion(4901, 3);
			::battle.enableTimeUp = true;
			this.freeMap = false;
			this.x = 640 - 380 * this.direction;
			this.y = this.centerY;
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.lavelClearEvent = function ()
			{
				::battle.enableTimeUp = true;
				this.lastword.Deactivate();
			};
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	};
}

