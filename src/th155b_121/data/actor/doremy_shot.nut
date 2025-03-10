function Hammock( t )
{
	this.SetMotion(1221, 4);
	this.DrawActorPriority(189);
	this.keyAction = this.ReleaseActor;
}

function Mukon_Sprash( t )
{
	this.SetMotion(1210, 4);
	this.keyAction = this.ReleaseActor;
}

function Mukon_AirAtk( t )
{
	this.SetMotion(1110, 5);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.flag1 = this.Vector3();
	this.flag1.x = 1.00000000;
	this.flag1.RotateByDegree(t.rot);
	this.flag2 = this.Vector3();
	this.flag2.x = this.flag1.x * 75.00000000;
	this.flag2.y = this.flag1.y * 33;
	this.flag2.RotateByRadian(0.52359873);
	this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);
	this.stateLabel = function ()
	{
		this.flag2.x = this.flag1.x * 75.00000000;
		this.flag2.y = this.flag1.y * 33;
		this.flag2.RotateByRadian(0.52359873);
		this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);

		if (this.owner.hitStopTime == 0)
		{
			this.flag1.RotateByDegree(8.00000000);
		}
	};
}

function Mukon_AirDash( t )
{
	this.SetMotion(1300, 4);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.flag1 = this.Vector3();
	this.flag1.x = 1.00000000;
	this.flag1.RotateByDegree(t.rot);
	this.flag2 = this.Vector3();
	this.flag2.x = this.flag1.x * 75.00000000;
	this.flag2.y = this.flag1.y * 33;
	this.flag2.RotateByRadian(0.52359873);
	this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);
	this.stateLabel = function ()
	{
		this.flag2.x = this.flag1.x * 75.00000000;
		this.flag2.y = this.flag1.y * 33;
		this.flag2.RotateByRadian(0.52359873);
		this.Warp(this.owner.point0_x + this.flag2.x * this.direction, this.owner.point0_y + this.flag2.y);

		if (this.owner.hitStopTime == 0)
		{
			this.flag1.RotateByDegree(8.00000000);
		}
	};
}

function Mukon_StockBall( t )
{
	this.SetMotion(2508, 6);
	this.DrawActorPriority(170);
	this.sx = this.sy = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.10000000;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.alpha <= 0.00000000;
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.20000000;
	};
}

function Set_Mukon( x_, y_, type_ = 0 )
{
	switch(type_)
	{
	case 2:
		this.SetShot(x_, y_, 1.00000000, this.Mukon_Item_AutoGet, {});
		break;

	case 1:
		this.owner.mukon.Add(this.SetShot(x_, y_, 1.00000000, this.Mukon_Item_Mid, {}));
		break;

	default:
		this.owner.mukon.Add(this.SetShot(x_, y_, 1.00000000, this.Mukon_Item, {}));
		break;
	}
}

function Mukon_Item( t )
{
	this.SetMotion(2508, 0);
	this.alpha = 0.00000000;
	this.SetTeamSelfPlayerShot();
	this.sx = this.sy = 2.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;
		this.sx = this.sy -= 0.10000000;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 2);
			this.owner.Mukon_Charge(1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;

				if (this.sx > 1.95000005)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.team.current.x - this.x) * 0.25000000, (this.team.current.y - 30 - this.y) * 0.25000000);
						this.sx = this.sy -= 0.10000000;

						if (this.sx <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot, {});
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0.00000000, -3.00000000 - this.rand() % 61 * 0.10000000);
		this.flag1 = this.rand() % 360 * 0.01745329;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.VY_Brake(0.20000000, -1.00000000);
			this.SetSpeed_XY(1.50000000 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0.08726646;
		};
	};
}

function Reset_Mukon_Item( t )
{
	this.SetMotion(2508, 0);
	this.HitReset();
	this.owner.mukon.Add(this);
	this.SetTeamSelfPlayerShot();
	this.sx = this.sy = 2.00000000;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.10000000;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 2);
			this.owner.Mukon_Charge(1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;

				if (this.sx > 1.95000005)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.team.current.x - this.x) * 0.25000000, (this.team.current.y - 30 - this.y) * 0.25000000);
						this.sx = this.sy -= 0.10000000;

						if (this.sx <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot, {});
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(2508, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[1] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = function ()
	{
		this.flag1 = this.rand() % 360 * 0.01745329;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			if (this.count >= 120)
			{
				this.func[2].call(this);
				return;
			}

			this.count++;
			this.VY_Brake(0.20000000, -1.00000000);
			this.SetSpeed_XY(1.50000000 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0.08726646;
		};
	};
}

function Mukon_Item_AutoGet( t )
{
	this.SetMotion(2508, 0);
	this.SetTeamSelfPlayerShot();
	this.alpha = 0.00000000;
	this.sx = this.sy = 2.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;
		this.sx = this.sy -= 0.10000000;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 2);
			this.owner.Mukon_Charge(1);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;

				if (this.sx > 1.95000005)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.team.current.x - this.x) * 0.25000000, (this.team.current.y - 30 - this.y) * 0.25000000);
						this.sx = this.sy -= 0.10000000;

						if (this.sx <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.SetSpeed_XY((this.team.current.x - this.x) * 0.10000000, (this.team.current.y - this.y) * 0.10000000);
		};
	};
}

function Mukon_Item_Mid( t )
{
	this.SetMotion(2508, 3);
	this.alpha = 0.00000000;
	this.SetTeamSelfPlayerShot();
	this.sx = this.sy = 2.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;
		this.sx = this.sy -= 0.10000000;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 5);
			this.owner.Mukon_Charge(5);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;

				if (this.sx > 1.95000005)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.team.current.x - this.x) * 0.25000000, (this.team.current.y - 30 - this.y) * 0.25000000);
						this.sx = this.sy -= 0.10000000;

						if (this.sx <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot_Mid, {});
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0.00000000, -6.00000000);
		this.flag1 = this.rand() % 360 * 0.01745329;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.VY_Brake(0.20000000, -1.00000000);
			this.SetSpeed_XY(1.50000000 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0.08726646;
		};
	};
}

function Reset_Mukon_Item_Mid( t )
{
	this.SetMotion(2508, 3);
	this.HitReset();
	this.owner.mukon.Add(this);
	this.SetTeamSelfPlayerShot();
	this.sx = this.sy = 2.00000000;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.10000000;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 5);
			this.owner.Mukon_Charge(5);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;

				if (this.sx > 1.95000005)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.team.current.x - this.x) * 0.25000000, (this.team.current.y - 30 - this.y) * 0.25000000);
						this.sx = this.sy -= 0.10000000;

						if (this.sx <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot_Mid, {});
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(2508, 5);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[1] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = function ()
	{
		this.flag1 = this.rand() % 360 * 0.01745329;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			if (this.count >= 120)
			{
				this.func[2].call(this);
				return;
			}

			this.count++;
			this.VY_Brake(0.20000000, -1.00000000);
			this.SetSpeed_XY(1.50000000 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0.08726646;
		};
	};
}

function Mukon_Item_ChargeShot( t )
{
	this.SetMotion(2508, 3);
	this.owner.mukon.Add(this);
	this.alpha = 0.00000000;
	this.SetTeamSelfPlayerShot();
	this.SetSpeed_Vec(6.00000000, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;
		this.Vec_Brake(0.20000000);
	};
	this.func = [
		function ()
		{
			this.SetMotion(2508, 5);
			this.owner.Mukon_Charge(5);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;

				if (this.sx > 1.95000005)
				{
					this.stateLabel = function ()
					{
						this.SetSpeed_XY((this.team.current.x - this.x) * 0.25000000, (this.team.current.y - 30 - this.y) * 0.25000000);
						this.sx = this.sy -= 0.10000000;

						if (this.sx <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.x, this.y, this.direction, this.Mukon_Vucume_Shot_Mid, {});
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0.00000000, -6.00000000);
		this.flag1 = this.rand() % 360 * 0.01745329;
		this.stateLabel = function ()
		{
			if (this.IsScreen(100))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0)
			{
				this.func[0].call(this);
				return;
			}

			this.alpha += 0.10000000;
			this.VY_Brake(0.20000000, -1.00000000);
			this.SetSpeed_XY(1.50000000 * this.sin(this.flag1), this.va.y);
			this.flag1 += 0.08726646;
		};
	};
}

function Mukon_Vucume_Shot( t )
{
	this.SetMotion(3009, 1);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.cancelCount = 1;
	this.atk_id = 1048576;
	this.flag1 = null;
	this.flag2 = 5.00000000;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.flag1 = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.owner.mukon_se == 0)
			{
				this.PlaySE(4031);
				this.owner.mukon_se = 3;
			}

			this.owner.Mukon_Charge(1);
			this.func[0].call(this);
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.flag1 = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.vec.x = this.team.current.point0_x - this.x;
		this.vec.y = this.team.current.point0_y - this.y;

		if (this.vec.Length() <= 25)
		{
			this.func[1].call(this);
			return;
		}

		this.vec.Normalize();
		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
	this.keyAction = function ()
	{
		this.flag1 = this.SetTrail(this.motion, 4);

		if (this.va.x > 0.00000000)
		{
			this.direction = 1.00000000;
		}

		if (this.va.x < 0.00000000)
		{
			this.direction = -1.00000000;
		}

		this.func[2] = function ()
		{
			this.subState = function ()
			{
				if (this.Vec_Brake(0.25000000))
				{
					this.func[0].call(this);
				}
			};
		};
		this.subState = function ()
		{
			this.vec.x = this.team.current.point0_x - this.x;
			this.vec.y = this.team.current.point0_y - this.y;

			if (this.vec.Length() <= 25)
			{
				this.func[1].call(this);
				return;
			}

			this.vec.Normalize();
			this.flag2 += 1.00000000;

			if (this.flag2 > 25.00000000)
			{
				this.flag2 = 25.00000000;
			}

			this.SetSpeed_XY(this.vec.x * this.flag2, this.vec.y * this.flag2);
		};
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if ((this.owner.motion == 3000 || this.owner.motion == 3001) && (this.owner.keyTake == 1 || this.owner.keyTake == 2))
		{
			this.subState();
		}
		else
		{
			this.flag2 -= 0.75000000;

			if (this.flag2 <= 0.00000000)
			{
				this.flag2 = 0.00000000;
			}

			if (this.Vec_Brake(0.75000000))
			{
				if (this.hitResult)
				{
					this.func[0].call(this);
				}
				else
				{
					if (this.flag1)
					{
						this.flag1.ReleaseActor();
					}

					this.flag1 = null;
					this.Reset_Mukon_Item(null);
				}

				return;
			}
		}
	};
}

function Mukon_Vucume_Shot_Mid( t )
{
	this.SetMotion(3009, 5);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.cancelCount = 3;
	this.atk_id = 1048576;
	this.flag1 = null;
	this.flag2 = 5.00000000;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.flag1 = null;
			this.SetMotion(this.motion, 7);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(4031);
			this.owner.Mukon_Charge(5);
			this.func[0].call(this);
		}
	];
	this.subState = function ()
	{
		this.vec.x = this.owner.point0_x - this.x;
		this.vec.y = this.owner.point0_y - this.y;

		if (this.vec.Length() <= 25)
		{
			this.func[1].call(this);
			return;
		}

		this.vec.Normalize();
		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
	this.keyAction = function ()
	{
		this.flag1 = this.SetTrail(this.motion, 8);

		if (this.va.x > 0.00000000)
		{
			this.direction = 1.00000000;
		}

		if (this.va.x < 0.00000000)
		{
			this.direction = -1.00000000;
		}

		this.subState = function ()
		{
			this.vec.x = this.owner.point0_x - this.x;
			this.vec.y = this.owner.point0_y - this.y;

			if (this.vec.Length() <= 25)
			{
				this.func[1].call(this);
				return;
			}

			this.vec.Normalize();
			this.flag2 += 0.50000000;

			if (this.flag2 > 20.00000000)
			{
				this.flag2 = 20.00000000;
			}

			this.SetSpeed_XY(this.vec.x * this.flag2, this.vec.y * this.flag2);
		};
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if ((this.owner.motion == 3000 || this.owner.motion == 3001) && (this.owner.keyTake == 1 || this.owner.keyTake == 2))
		{
			this.subState();
		}
		else
		{
			this.flag2 -= 0.40000001;

			if (this.flag2 <= 0.00000000)
			{
				this.flag2 = 0.00000000;
			}

			if (this.Vec_Brake(0.40000001))
			{
				if (this.hitResult)
				{
					this.func[0].call(this);
				}
				else
				{
					if (this.flag1)
					{
						this.flag1.ReleaseActor();
					}

					this.flag1 = null;
					this.Reset_Mukon_Item_Mid(null);
				}

				return;
			}
		}
	};
}

function Shot_Normal_Sub( t )
{
	this.SetMotion(2009, 0);
	this.atk_id = 16384;
	this.func = [
		function ()
		{
			this.SetMotion(2009, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.94999999;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.owner.target.team.current.SetCommonFreeObject(this.x, this.y, this.direction, this.Occult_Power, {});
			this.func[0].call(this);
		},
		function ()
		{
			this.Set_Mukon(this.x, this.y);
			this.func[0].call(this);
		}
	];
}

function Shot_Normal( t )
{
	this.flag1 = [];
	this.flag2 = this.Vector3();
	this.flag2.x = 1.00000000;
	this.flag3 = 2.00000000;
	this.atk_id = 16384;
	this.cancelCount = 5;

	for( local i = 0; i < 12; i++ )
	{
		this.flag1.append(this.SetShot(this.x, this.y, this.direction, this.Shot_Normal_Sub, {}).weakref());
	}

	foreach( a in this.flag1 )
	{
		a.hitOwner = this;
	}

	this.func = [
		function ()
		{
			if (this.hitResult & 13)
			{
				foreach( a in this.flag1 )
				{
					a.func[2].call(a);
					a.hitOwner = null;
				}
			}
			else
			{
				foreach( a in this.flag1 )
				{
					a.func[0].call(a);
					a.hitOwner = null;
				}
			}

			this.ReleaseActor();
		}
	];
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.func[0].call(this);
			return;
		}

		if (this.owner.IsDamage())
		{
			foreach( a in this.flag1 )
			{
				a.func[1].call(a);
				a.hitOwner = null;
			}

			this.ReleaseActor();
			return;
		}

		if (this.hitCount >= 3 || this.cancelCount <= 0 || this.grazeCount > 5)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(1);
		this.rz += 0.03490658;
		this.flag2.RotateByRadian(-0.10471975);
		this.flag3 += (150 - this.flag3) * 0.01500000;
		this.AddSpeed_Vec(0.15000001, null, 15.00000000, this.direction);

		foreach( a in this.flag1 )
		{
			this.flag2.RotateByRadian(0.52359873);
			local v_ = this.Vector3();
			v_.x = this.flag2.x * this.flag3;
			v_.y = this.flag2.y * this.flag3 * 0.33000001;
			v_.RotateByRadian(this.rz);
			a.Warp(this.x + v_.x * this.direction, this.y + v_.y);
		}
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.cancelCount = 2;
	this.atk_id = 65536;
	this.flag1 = this.y + 100;
	this.SetSpeed_XY(6.00000000 * this.direction, -2.50000000);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2.00000000 + this.rand() % 10 * 0.10000000;
			this.flag2 = 0.10471975 + this.rand() % 12 * 0.01745329;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.flag1 - this.sx) * 0.15000001;
				this.flag2 *= 0.93000001;
				this.rz += this.flag2;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(75.00000000) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0)
		{
			this.Set_Mukon(this.x, this.y, 1);
			this.func[0].call(this);
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.89999998);

		if (this.keyTake == 0 && this.va.y > 0)
		{
			this.SetMotion(this.motion, 1);
		}

		if (this.va.y > 0 && this.y >= this.flag1)
		{
			this.PlaySE(4026);
			this.SetMotion(this.motion, 0);
			this.SetSpeed_XY(17.50000000 * this.direction, -14.50000000);
		}
	};
}

function Shot_BarrageFire( t )
{
	this.SetMotion(2026, 2);
	this.stateLabel = function ()
	{
		this.alpha = this.blue = this.green -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_BarrageFire, {});
	this.atk_id = 262144;
	this.SetSpeed_Vec(5.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.92000002;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.keyAction = this.func;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 0);
	this.SetSpeed_XY(17.50000000 * this.direction, -6.50000000);
	this.va.RotateByRadian(t.rot * this.direction);
	this.ConvertTotalSpeed();
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.flag1 = 0.52359873;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.hitCount > 0)
			{
				for( local i = 0; i < 6; i++ )
				{
					local t_ = {};
					t_.rot <- i * 1.04719746;
					this.SetShot(this.x, this.y, this.direction, this.Mukon_Item_ChargeShot, t_);
				}
			}

			this.HitReset();
			this.PlaySE(4028);
			this.SetMotion(2028, 0);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.cancelCount = 3;
			this.keyAction = this.ReleaseActor;
			this.rz = 0.00000000;
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 10) || this.IsScreenB(100) || this.y < -200)
		{
			this.ReleaseActor();
			return;
		}

		this.count++;
		this.rz += this.flag1;
		this.VX_Brake(0.40000001, 4.00000000 * this.direction);
		this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 0.50000000 : 0.50000000);

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 30)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.cancelCount = 1;
	this.atk_id = 536870912;
	this.flag1 = this.y + 100;
	this.flag2 = 0;
	this.SetSpeed_XY(6.00000000 * this.direction, -12.50000000);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 2);
			this.flag1 = 2.00000000 + this.rand() % 10 * 0.10000000;
			this.flag2 = 0.10471975 + this.rand() % 12 * 0.01745329;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.flag1 - this.sx) * 0.15000001;
				this.flag2 *= 0.93000001;
				this.rz += this.flag2;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(150.00000000) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0)
		{
			this.Set_Mukon(this.x, this.y, 0);
			this.func[0].call(this);
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.89999998);

		if (this.keyTake == 0 && this.va.y > 0)
		{
			this.SetMotion(this.motion, 1);
		}

		this.count++;

		if (this.count >= 33)
		{
			if (this.flag2 >= 4)
			{
				this.func[0].call(this);
				return;
			}
			else
			{
				this.count = 0;
				this.PlaySE(4026);
				this.SetMotion(this.motion, 0);
				local r_ = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
				r_ = this.Math_MinMax(r_, -1.04719746, 1.04719746);
				this.SetSpeed_Vec(6.00000000, r_, this.direction);
				this.flag2++;
				this.AddSpeed_XY(0.00000000, -14.50000000);
			}
		}
	};
}

function SPShot_Vuccum( t )
{
	this.DrawActorPriority(189);
	this.SetMotion(3009, 0);
	this.atk_id = 1048576;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = 0.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.flag1 += 0.50000000;

		if (this.flag1 >= 7.50000000)
		{
			this.flag1 = 7.50000000;
		}

		local d_ = this.owner.target.x - this.x;

		if (d_ * this.direction >= 0)
		{
			this.owner.target.vf.x = -d_ * 0.10000000;
			this.owner.target.vf.x = this.Math_MinMax(this.owner.target.vf.x, -this.flag1, this.flag1);
			this.owner.target.ConvertTotalSpeed();
		}
	};
}

function SPShot_Bound_Fire( t )
{
	this.SetMotion(3019, 5);
	this.keyAction = this.ReleaseActor;
}

function SPShot_Bound_Main( t )
{
	this.SetMotion(3019, 2);
	this.SetTaskAddRotation(0, 0, -0.08726646);
	this.rz = 0.01745329 * (this.rand() % 360);
	this.SetSpeed_Vec(13.00000000, t.rot, this.direction);
	this.Warp(this.x + this.va.x * 6, this.y + this.va.y * 6);
	this.cancelCount = 2;
	this.atk_id = 2097152;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.SetSpeed_XY(-this.va.x, -4.50000000);
			this.SetTaskAddRotation(0, 0, -0.08726646);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.20000000);
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0)
		{
			this.Set_Mukon(this.x, this.y, 1);
			this.func[0].call(this);
			return;
		}

		if (this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function SPShot_Bound_Big( t )
{
	this.SetMotion(3019, 6);
	this.rz = 0.01745329 * (this.rand() % 360);
	this.SetSpeed_Vec(17.50000000, t.rot, this.direction);
	this.Warp(this.x + this.va.x * 5, this.y + this.va.y * 5);
	this.cancelCount = 3;
	this.atk_id = 2097152;
	this.sx = this.sy = 0.75000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0.75000000, 1.00000000))
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0.00000000, 0.20000000);
						this.alpha -= 0.02500000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}

				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.Vec_Brake(0.75000000, 1.00000000))
		{
			this.subState = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.20000000);
			};
		}

		this.sx = this.sy += (2.50000000 - this.sx) * 0.15000001;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 6))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.cancelCount <= 0 || this.count >= 12)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function SPShot_B_Mukon( t )
{
	this.SetMotion(3019, 4);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.SetMotion(3019, 4);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.10000000;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > this.owner.centerY)
		{
			this.AddSpeed_XY(0.00000000, -0.75000000, 0.00000000, -15.00000000);

			if (this.y + this.va.y <= this.owner.centerY)
			{
				this.Warp(this.x, this.owner.centerY);
				this.SetSpeed_XY(0.00000000, 0.00000000);
			}
		}
		else
		{
			this.AddSpeed_XY(0.00000000, 0.75000000, 0.00000000, 15.00000000);

			if (this.y + this.va.y >= this.owner.centerY)
			{
				this.Warp(this.x, this.owner.centerY);
				this.SetSpeed_XY(0.00000000, 0.00000000);
			}
		}
	};
}

function SPShot_Bomb_Sub( t )
{
	this.SetMotion(3029, 1);
	this.SetParent(t.pare, 0, 0);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha += 0.03300000;
			};
		},
		function ()
		{
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
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
	};
}

function SPShot_Bomb_Main( t )
{
	this.SetMotion(3029, 0);
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_Bomb_Sub, {}, this.weakref()).weakref();
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(25.00000000, t.rot, this.direction);
	this.flag1 = 0.26179937;
	this.atk_id = 4194304;
	this.subState = function ()
	{
		this.Vec_Brake(1.00000000, 6.00000000);
	};
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.subState = function ()
			{
				this.Vec_Brake(0.15000001);
			};

			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
			}
		},
		function ()
		{
			this.PlaySE(4037);
			this.sx = this.sy = 2.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);

			if (this.flag2)
			{
				this.flag2.func[2].call(this.flag2);
			}

			this.SetMotion(this.motion, 2);
			this.cancelCount = 3;
			this.alpha = 1.25000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.50000000 - this.sx) * 0.20000000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
		this.count++;

		if (this.count == 30)
		{
			this.func[1].call(this);
		}

		if (this.count == 90)
		{
			this.func[2].call(this);
			return;
		}

		this.rz += this.flag1;
		this.flag1 *= 0.99000001;

		if (this.va.x > 0 && this.x > ::camera.camera2d.right || this.va.x < 0 && this.x < ::camera.camera2d.left)
		{
			this.va.x *= -1.00000000;
		}

		if (this.va.y < 0 && this.y < ::camera.camera2d.top || this.va.y > 0 && this.y > ::camera.camera2d.bottom)
		{
			this.va.y *= -1.00000000;
		}

		this.ConvertTotalSpeed();
	};
}

function SPShot_Bed_Fire( t )
{
	this.SetMotion(3039, 1);
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
}

function SPShot_Bed_Canon( t )
{
	this.SetMotion(3039, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0.10000000;
	this.atk_id = 8388608;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.sx = this.sy = 1.00000000;
			this.SetMotion(3039, 1);
			this.stateLabel = null;
		},
		function ()
		{
			this.PlaySE(4040);
			this.SetParent(null, 0, 0);
			this.rz = this.atan2(this.target.y - 20 - this.y, (this.target.x - this.x) * this.direction);
			this.rz = this.Math_MinMax(this.rz, -0.34906584, 0.34906584);
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_Bed_Fire, t_);
			this.SetMotion(3039, 2);
			this.cancelCount = 1;
			this.SetSpeed_Vec(25.00000000, this.rz, this.direction);
			this.stateLabel = function ()
			{
				if (this.IsScreen(300) || this.Damage_ConvertOP(this.x, this.y, 5))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0)
				{
					this.func[2].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(3039, 4);
			this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.20000000);
				this.alpha = this.red = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += 0.25000000;

		if (this.sx > 1.00000000)
		{
			this.subState = function ()
			{
				this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function SPShot_Balloon( t )
{
	this.SetMotion(3049, 0);
	this.sx = this.sy = 0.33000001;
	this.flag1 = 1.00000000;
	this.atk_id = 16777216;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.PlaySE(4043);
			::camera.shake_radius = 4.00000000;

			if (this.owner.flag1 == this)
			{
				this.owner.flag1 = null;
			}

			if (this.hitResult & 1)
			{
				for( local i = 0; i < 4; i++ )
				{
					this.Set_Mukon(this.point0_x, this.point0_y, 0);
					this.Set_Mukon(this.point1_x, this.point1_y, 0);
					this.Set_Mukon(this.point2_x, this.point2_y, 0);
				}
			}

			this.ReleaseActor();
		},
		function ()
		{
			local t_ = {};
			t_.rot <- -15 * 0.01745329;
			t_.take <- 5;
			t_.scale <- this.sx;
			t_.vx <- this.owner.va.x * 0.92000002;
			t_.vy <- this.owner.va.y * 0.92000002;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_BalloonFree, t_);
			local t_ = {};
			t_.rot <- 0 * 0.01745329;
			t_.take <- 6;
			t_.scale <- this.sx;
			t_.vx <- this.owner.va.x * 0.95999998;
			t_.vy <- this.owner.va.y * 0.95999998;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.SPShot_BalloonFree, t_);
			local t_ = {};
			t_.rot <- 15 * 0.01745329;
			t_.take <- 7;
			t_.scale <- this.sx;
			t_.vx <- this.owner.va.x;
			t_.vy <- this.owner.va.y;
			this.SetShot(this.point2_x, this.point2_y, this.direction, this.SPShot_BalloonFree, t_);
			this.ReleaseActor();
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (this.flag1 - this.sx) * 0.10000000;

		if (this.sx >= 1.00000000 && this.keyTake == 0)
		{
			this.SetMotion(this.motion, 1);
		}

		this.flag1 += 0.01000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	};
}

function SPShot_BalloonFree( t )
{
	this.SetMotion(3049, t.take);
	this.owner.balloon.Add(this);
	this.sx = this.sy = t.scale;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.SetSpeed_XY(t.vx, t.vy);
	this.cancelCount = 1;
	this.atk_id = 16777216;
	this.func = [
		function ()
		{
			if (this.hitResult & 1)
			{
				for( local i = 0; i < 4; i++ )
				{
					this.Set_Mukon(this.x, this.y, 0);
				}
			}

			this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashB, {});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, -0.10000000);
	};
}

function Occult_Back( t )
{
	this.SetMotion(2509, 0);
	this.anime.is_equal = true;
	this.DrawActorPriority(10);
	this.stateLabel = function ()
	{
		this.sx = this.sy = 1.00000000 / ::camera.zoom;
		this.Warp((::camera.camera2d.left + ::camera.camera2d.right) * 0.50000000 - (::camera.target_x - 640) * 0.10000000, (::camera.camera2d.bottom + ::camera.camera2d.top) * 0.50000000 - (::camera.target_y - 360) * 0.10000000);
	};
}

function Occult_Mukon( t )
{
	this.SetMotion(2509, 4);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 1;
	this.atk_id = 524288;
	this.func = [
		function ()
		{
			this.SetMotion(2509, 6);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.10000000);
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += 0.10000000;

		if (this.sx >= 1.00000000)
		{
			this.SetMotion(2509, 5);
			this.subState = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.10000000);

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 32 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.subState();
	};
}

function Occult_Hole( t )
{
	this.SetMotion(2509, 1);
	this.DrawActorPriority(9);
	this.anime.is_write = true;
	this.anime.stencil = this.owner.back_park;
	this.flag1 = t.scale;
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.Occult_HoleRing, {}).weakref();
	this.flag3 = 0;
	this.flag5 = {};
	this.flag5.range <- 88;
	this.flag5.point <- this.Vector3();
	this.flag5.shotRot <- 90.00000000;
	this.flag5.shotRotSpeed <- -30;
	this.flag5.shotPos <- this.Vector3();
	this.flag5.shotPos.y = 1.00000000;
	this.flag5.damage <- false;
	this.sx = this.sy = 0.10000000;
	this.func = [
		function ()
		{
			foreach( val, a in this.owner.back_hole )
			{
				if (a == this)
				{
					this.owner.back_hole.remove(val);
				}
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					if (this.owner.back_hole.len() == 0 && this.owner.back_park != null)
					{
						this.owner.back_park.ReleaseActor();
						this.owner.back_park = null;
					}

					this.ReleaseActor();
				}
			};
		},
		function ( root_ )
		{
			local t_ = {};
			t_.scale <- this.flag1;
			this.flag4 = root_.weakref();
			this.SetFreeObject(this.x, this.y, this.direction, this.Occult_ReactRing, t_);
			this.PlaySE(4046);
			this.flag5.shotRot = 90;
			this.flag3 = 0;
			this.subState = function ()
			{
				this.flag3++;

				if (this.flag3 == 20)
				{
					foreach( a in this.owner.back_hole )
					{
						if (a && a != this && a != this.flag4)
						{
							this.flag5.point.x = a.x - this.x;
							this.flag5.point.y = a.y - this.y;

							if (this.flag5.point.Length() <= this.flag5.range * this.flag1 + a.flag5.range * a.flag1)
							{
								a.func[1].call(a, this);
							}
						}
					}
				}

				if (this.flag5.damage == false)
				{
					if (this.owner.team.current.IsDamage())
					{
						this.flag5.damage = true;
					}

					if (this.flag3 >= 25 && this.count % 3 == 1)
					{
						if (this.flag5.shotRot == 90.00000000 || this.flag5.shotRot == -90.00000000)
						{
							this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
						}
						else
						{
							this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
							this.SetShot(this.x - this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
						}

						if (this.flag5.shotRot <= -90.00000000)
						{
							this.func[0].call(this);
							return;
						}

						this.flag5.shotRot += this.flag5.shotRotSpeed;
						this.flag5.shotPos.RotateByDegree(this.flag5.shotRotSpeed);
					}
				}
				else
				{
					this.func[0].call(this);
					return;
				}
			};

			foreach( val, a in this.owner.back_hole )
			{
				if (a == this)
				{
					this.owner.back_hole.remove(val);
				}
			}
		},
		function ()
		{
			local t_ = {};
			t_.scale <- this.flag1;
			this.SetFreeObject(this.x, this.y, this.direction, this.Occult_ReactRing, t_);
			this.PlaySE(4046);
			this.flag5.damage = false;
			this.subState = function ()
			{
				if (this.count >= 1200)
				{
					this.func[0].call(this);
					return;
				}

				this.flag3++;

				if (this.flag3 == 25)
				{
					foreach( a in this.owner.back_hole )
					{
						if (a && a != this)
						{
							this.flag5.point.x = a.x - this.x;
							this.flag5.point.y = a.y - this.y;

							if (this.flag5.point.Length() <= this.flag5.range * this.flag1 + a.flag5.range * a.flag1)
							{
								a.func[1].call(a, this);
							}
						}
					}
				}

				if (this.flag5.damage == false)
				{
					if (this.owner.team.current.IsDamage())
					{
						this.flag5.damage = true;
					}

					if (this.flag3 >= 25 && this.count % 3 == 1)
					{
						if (this.flag5.shotRot >= -90.00000000)
						{
							if (this.flag5.shotRot == 90.00000000 || this.flag5.shotRot == -90.00000000)
							{
								this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
							}
							else
							{
								this.SetShot(this.x + this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
								this.SetShot(this.x - this.flag5.shotPos.x * this.flag5.range * this.flag1, this.y + this.flag5.shotPos.y * this.flag5.range * this.flag1, this.direction, this.Occult_Mukon, {});
							}

							this.flag5.shotRot += this.flag5.shotRotSpeed;
							this.flag5.shotPos.RotateByDegree(this.flag5.shotRotSpeed);
						}
					}
				}
			};
		}
	];

	switch(t.level)
	{
	case 4:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -6.00000000;
		break;

	case 3:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -10.00000000;
		break;

	case 2:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -15.00000000;
		break;

	case 1:
		this.func[2].call(this);
		this.flag5.shotRotSpeed = -22.50000000;
		break;

	default:
		this.subState = function ()
		{
			if (this.count >= 1200)
			{
				this.func[0].call(this);
			}
		};
		break;
	}

	this.stateLabel = function ()
	{
		if (::battle.state != 8)
		{
			this.func[0].call(this);
			return;
		}

		local x_ = this.flag1 + 0.05000000 * this.sin(this.count * 0.05235988);
		this.sx = this.sy += (x_ - this.sx) * 0.15000001;

		if (this.flag2)
		{
			this.flag2.sx = this.flag2.sy = this.sx;
		}

		this.count++;
		this.subState();
	};
}

function Occult_HoleRing( t )
{
	this.SetMotion(2509, 3);
	this.DrawActorPriority(10);
	this.sx = this.sy = 0.10000000;
	this.stateLabel = function ()
	{
		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_ReactRing( t )
{
	this.SetMotion(2509, 3);
	this.DrawActorPriority(10);
	this.alpha = 0.00000000;
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.alpha += 0.05000000;

		if (this.alpha >= 1.00000000)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Occult_Stump( t )
{
	this.SetMotion(2509, 2);
	this.DrawActorPriority(189);
	this.keyAction = this.ReleaseActor;
}

function SpellShot_A( t )
{
	this.SetMotion(4009, 0);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
	this.cancelCount = 10;
	this.atk_id = 67108864;
	this.target = this.owner.target.weakref();
	this.flag1 = this.Vector3();
	this.sx = this.sy = 0.15000001;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.func = [
		function ()
		{
			this.team.spell_enable_end = true;
			this.SetKeyFrame(1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0.75000000 - this.sx) * 0.07500000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.count++;

		if (this.count % 15 == 1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.SS_A_Wave, {}, this.weakref());
		}

		this.flag1.x = this.team.target.x - this.x;
		this.flag1.y = this.team.target.y - this.y;

		if (this.flag1.Length() <= 10)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}
		else
		{
			this.flag1.SetLength(3.00000000);
			this.SetSpeed_XY(this.flag1.x, this.flag1.y);
		}

		this.HitCycleUpdate(5);

		if (this.count >= 210 || this.hitCount >= 10 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SS_A_Wave( t )
{
	this.SetMotion(4009, 2);
	this.SetParent(t.pare, 0, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.alpha = 0.00000000;
	this.SetTaskAddScaling(0.05000000, 0.05000000);
	this.stateLabel = function ()
	{
		this.alpha += 0.05000000;

		if (this.alpha >= 1.00000000)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B( t )
{
	this.atk_id = 67108864;
	this.func = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.func[0].call(a);
			}

			this.ReleaseActor();
		},
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.func[1].call(a);
			}

			this.stateLabel = function ()
			{
				this.flag2 -= 1.25000000;

				if (this.flag2 <= 0)
				{
					this.func[2].call(this);
					return;
				}

				this.flag1[0].Warp(this.x, this.y - this.flag2);
				this.flag1[1].Warp(this.x, this.y + this.flag2);
				this.flag1[0].rx += 0.12500000 * 0.01745329;
				this.flag1[1].rx -= 0.12500000 * 0.01745329;
			};
		},
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.ReleaseActor();
			}

			this.SetMotion(4019, 3);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.10000000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.flag1 = [
		this.SetShotStencil(this.x, this.y - 350, this.direction, this.SS_B_Vortex, {}).weakref(),
		this.SetShotStencil(this.x, this.y + 350, this.direction, this.SS_B_Vortex, {}).weakref()
	];
	this.flag1[0].rx = 80 * 0.01745329;
	this.flag1[1].rx = 100 * 0.01745329;
	this.flag2 = 350;
	this.stateLabel = function ()
	{
		local y_ = (125 - this.flag2) * 0.20000000;

		if (y_ > -0.50000000)
		{
			y_ = -0.50000000;
		}

		this.flag2 += y_;
		this.flag1[0].Warp(this.x, this.y - this.flag2);
		this.flag1[1].Warp(this.x, this.y + this.flag2);
	};
}

function SS_B_Back( t )
{
	this.SetMotion(4019, 4);
	this.anime.is_equal = true;
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function SS_B_VortexSub( t )
{
	this.SetMotion(4019, 2);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.rz += 0.05235988;
				this.alpha -= 0.10000000;
				this.sx = this.sy -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SS_B_Vortex( t )
{
	this.SetMotion(4019, 0);
	this.atk_id = 67108864;
	this.DrawActorPriority(180);
	this.anime.is_write = true;
	this.flag1 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.SS_B_Back, {}).weakref();
	this.flag1.anime.stencil = this;
	this.flag1.SetParent(this, 0, 0);
	this.flag2 = null;
	this.alpha = 0.00000000;
	this.sx = this.sy = 0.50000000;
	this.func = [
		function ()
		{
			this.alpha = 1.00000000;
			this.SetMotion(4019, 0);

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.flag2 = null;
			this.stateLabel = function ()
			{
				this.rz += 0.05235988;
				this.alpha -= 0.10000000;
				this.sx = this.sy -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4019, 1);
			this.cancelCount = 3;
			this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.SS_B_VortexSub, {}).weakref();
			this.flag2.SetParent(this, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
				this.rz += 0.34906584;
				this.HitCycleUpdate(4);

				if (this.flag2)
				{
					this.flag2.rx = this.rx;
					this.flag2.sx = this.flag2.sy = this.sx;
					this.flag2.rz -= 0.10471975;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
		this.alpha += 0.10000000;
		this.rz += 0.05235988;
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 5);
	this.DrawActorPriority(189);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rz = t.rot;
	this.cancelCount = 1;
	this.atk_id = 67108864;
	this.flag1 = 0.03490658;
	this.func = [
		function ()
		{
			if (this.hitResult & 1)
			{
				this.Set_Mukon(this.x, this.y, 2);
			}

			this.DrawActorPriority(200);
			this.SetMotion(4029, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.alpha = 1.50000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1.70000005 - this.sx) * 0.15000001;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.IsScreenB(200) || this.y < -360)
		{
			this.func[0].call(this);
			return;
		}

		this.TargetHoming(this.team.target, this.flag1, this.direction);
		this.flag1 -= 0.01000000 * 0.01745329;

		if (this.flag1 < 0)
		{
			this.flag1 = 0;
		}

		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	};
}

function SpellShot_C_PartA( t )
{
	this.SetMotion(4028, 0);
	this.DrawActorPriority(180);
	this.SetSpeed_Vec(10, -0.17453292, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0.75000000 - this.sx) * 0.20000000;
		this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha = this.red = this.blue = this.green -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_PartB( t )
{
	this.SetMotion(4028, 1);
	this.DrawActorPriority(180);
	this.SetSpeed_Vec(10, -160 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0.80000001 - this.sx) * 0.20000000;
		this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha = this.red = this.blue = this.green -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_PartC( t )
{
	this.SetMotion(4028, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.75000000 - this.sx) * 0.20000000;
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_PartD( t )
{
	this.SetMotion(4028, 3);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2.00000000 - this.sx) * 0.20000000;
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Circle( t )
{
	this.SetMotion(4905, 1);
	this.SetParent(this.owner, 0, 0);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.anime.radius0 = t.size;
	this.anime.radius1 = t.size;
	this.anime.length = t.size;
	this.anime.vertex_alpha1 = 1.00000000;
	this.anime.vertex_blue1 = 1.00000000;
	this.anime.vertex_red1 = 1.00000000;
	this.anime.vertex_green1 = 1.00000000;
	this.rx = (-90 + this.rand() % 181) * 0.01745329;
	this.ry = (-90 + this.rand() % 181) * 0.01745329;
	this.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.anime.length *= 0.89999998;
		this.count++;
		this.anime.radius0 = this.anime.radius1 += 0.50000000;
		this.rz -= 15 * 0.01745329;
		this.anime.length *= 0.94999999;

		if (this.anime.length <= 5)
		{
			this.alpha -= 0.10000000;
		}
		else
		{
			this.alpha += (1.00000000 - this.alpha) * 0.25000000;
		}

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Shot( t )
{
	this.SetMotion(4905, 2);
	this.SetParent(this.owner, 0, 0);
	this.atk_id = 134217728;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(10);
	};
}

function Climax_Seat( t )
{
	this.SetMotion(4909, 1);
	this.DrawScreenActorPriority(100);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
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
		this.alpha += 0.05000000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
			};
		}
	};
}

function Climax_Back_Black( t )
{
	this.DrawScreenActorPriority(79);
	this.SetMotion(4909, 1);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Back( t )
{
	this.DrawScreenActorPriority(80);
	this.SetMotion(4909, 3);
	this.sx = this.sy = 1.75000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0.02000000;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		local s_ = (1.33000004 - this.sx) * 0.10000000;

		if (s_ > -0.00100000)
		{
			s_ = -0.00100000;
		}

		this.sx = this.sy += s_;
		this.SetSpeed_XY(0.00000000, -0.05000000 * this.sx);
	};
}

function Climax_Squeez( t )
{
	this.DrawScreenActorPriority(100);
	this.SetMotion(4909, 4);
	this.sx = this.sy = 3.00000000;
	this.rx = 45;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0.02000000;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}

				this.rz += 3.50000000 * 0.01745329;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0.50000000 * 0.01745329;
		this.sx = this.sy += (1.25000000 - this.sx) * 0.10000000;
	};
}

function Climax_EnemyStun( t )
{
	this.SetMotion(309, 1);
	this.DrawScreenActorPriority(90);
	this.sx = this.sy = 6.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.target.flag5.face)
				{
					this.Warp(this.owner.target.flag5.face.x, this.owner.target.flag5.face.y);
				}

				this.sx = this.sy -= 0.05000000;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		local s_ = (2.25000000 - this.sx) * 0.10000000;

		if (s_ > -0.00500000)
		{
			s_ = -0.00500000;
		}

		this.sx = this.sy += s_;
	};
}

function Climax_Gate( t )
{
	this.SetMotion(4909, 5);
	this.DrawScreenActorPriority(95);
	this.ry = -80 * 0.01745329;
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x - 625 * this.sx * this.direction, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0.02000000;
				this.alpha += 0.07500000;
				this.flag1 += 0.01000000 * 0.01745329;

				if (this.flag1 > 6.00000000 * 0.01745329)
				{
					this.flag1 = 6.00000000 * 0.01745329;
				}

				this.ry += this.flag1;

				if (this.ry >= 0.00000000)
				{
					this.ry = 0.00000000;
				}

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.07500000;
		this.flag1 += 0.01000000 * 0.01745329;

		if (this.flag1 > 6.00000000 * 0.01745329)
		{
			this.flag1 = 6.00000000 * 0.01745329;
		}

		this.ry += this.flag1;

		if (this.ry >= 0.00000000)
		{
			this.ry = 0.00000000;
			this.stateLabel = null;
		}
	};
}

function Climax_ChainPre( t )
{
	this.DrawScreenActorPriority(96);
	this.SetMotion(4908, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag1.x *= 1.01999998;
				this.flag1.y *= 1.01999998;

				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x + this.flag1.x, this.owner.flag5.face.y + this.flag1.y);
				}

				this.sx = this.sy -= 0.02000000;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.subState = function ()
			{
				if (this.flag2 >= 1.00000000)
				{
					this.flag2 -= 1.00000000;
				}
				else
				{
					this.flag2 -= 0.10000000;
				}

				if (this.flag2 <= 0)
				{
					this.flag2 = -3.00000000;
					this.subState = function ()
					{
						this.flag2 += 1.00000000;

						if (this.flag2 > 0)
						{
							this.flag2 = 0;
							this.subState = function ()
							{
							};
						}
					};
				}
			};
			this.stateLabel = function ()
			{
				this.subState();
				this.anime.top += this.flag2;
			};
		}
	];
	this.flag1 = this.Vector3();
	this.flag1.x = this.x - 640;
	this.flag1.y = this.y - 360;
	this.alpha = 0.00000000;
	this.sx = this.sy = 15.00000000;
	this.flag4 = this.sx * 0.00500000;
	this.rz = t.rot;
	this.flag2 = 10.00000000;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.alpha += 0.05000000;
		this.anime.top += this.flag2;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0.15000001;
	};
}

function Climax_Chain( t )
{
	this.DrawScreenActorPriority(95);
	this.SetMotion(4908, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.owner.flag5.face)
				{
					this.Warp(this.owner.flag5.face.x, this.owner.flag5.face.y);
				}

				this.sx = this.sy -= 0.02000000;

				if (this.sx < 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.alpha = 0.00000000;
	this.sx = this.sy = 30.00000000;
	this.rz = 45 * 0.01745329;
	this.flag1 = 10.00000000;
	this.flag2 = 4.00000000;
	this.flag3 = 0.00000000;
	this.subState = function ()
	{
		if (this.count >= 50)
		{
			if (this.keyTake == 0 && this.flag1 < 10)
			{
				this.SetMotion(this.motion, 1);
			}

			if (this.flag1 >= 1.00000000)
			{
				this.flag1 -= 1.00000000;
			}
			else
			{
				this.flag1 -= 0.10000000;
			}

			if (this.flag1 <= 0)
			{
				this.flag1 = -3.00000000;
				this.subState = function ()
				{
					this.flag1 += 1.00000000;

					if (this.flag1 > 0)
					{
						this.flag1 = 0;
						this.subState = function ()
						{
						};
					}
				};
			}
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.count++;
		this.anime.top += this.flag1;
		this.flag2 -= 0.00750000;
		this.flag3 += 0.02000000;

		if (this.flag3 > 1.00000000)
		{
			this.flag3 = 1.00000000;
		}

		this.sx = this.sy = this.Math_Bezier(30.00000000, this.flag2, 25.00000000, this.flag3);

		if (this.sx < this.flag2)
		{
			this.sx = this.sy = this.flag2;
		}

		this.alpha += 0.10000000;
		this.Warp(this.x - (this.x - 640) * 0.15000001, this.y);
	};
}

function Climax_MidBack( t )
{
	this.DrawScreenActorPriority(100);
	this.SetMotion(4909, 1);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.05000000;
	};
}

function Climax_Cut( t )
{
	this.DrawScreenActorPriority(101);
	this.SetMotion(4909, 8);
	this.sx = this.sy = 5.00000000;
	this.alpha = 0.00000000;
	this.flag1 = null;
	this.flag2 = -0.01000000;
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_CutFlash, {}).weakref();
			this.stateLabel = function ()
			{
				local s_ = (1.00000000 - this.sx) * 0.10000000;

				if (s_ > -0.00025000)
				{
					s_ = -0.00025000;
				}

				this.sx = this.sy += s_;
				this.alpha += 0.05000000;
				this.SetSpeed_XY((360 - this.x) * 0.10000000, (420 - this.y) * 0.10000000);
				local r_ = this.rz * 0.10000000;

				if (r_ > -0.01000000 * 0.01745329)
				{
					r_ = -0.01000000 * 0.01745329;
				}
			};
		},
		function ()
		{
			this.flag1.func[1].call(this.flag1);
			this.stateLabel = function ()
			{
				local s_ = (1.00000000 - this.sx) * 0.10000000;

				if (s_ > -0.00025000)
				{
					s_ = -0.00025000;
				}

				this.sx = this.sy += s_;
				this.alpha += 0.05000000;
				this.SetSpeed_XY((360 - this.x) * 0.10000000, (420 - this.y) * 0.10000000);
				local r_ = this.rz * 0.10000000;

				if (r_ > -0.01000000 * 0.01745329)
				{
					r_ = -0.01000000 * 0.01745329;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag2 -= 0.00500000;
		local s_ = (1.00000000 - this.sx) * 0.15000001;

		if (s_ > -0.00025000)
		{
			s_ = -0.00025000;
		}

		this.sx = this.sy += s_;
		this.alpha += 0.05000000;
		this.SetSpeed_XY((360 - this.x) * 0.15000001, (420 - this.y) * 0.15000001);
		local r_ = (-20 * 0.01745329 - this.rz) * 0.10000000;

		if (r_ > -0.01000000 * 0.01745329)
		{
			r_ = -0.01000000 * 0.01745329;
		}

		this.rz += r_;
	};
}

function Climax_CutFlash( t )
{
	this.DrawScreenActorPriority(101);
	this.SetMotion(4909, 6);
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.alpha = 1.00000000;
			this.SetMotion(4909, 7);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02500000;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.00500000;
		this.alpha += 0.02500000;
	};
}

