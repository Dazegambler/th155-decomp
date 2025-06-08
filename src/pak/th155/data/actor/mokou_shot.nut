function Grab_Exp( t )
{
	this.SetMotion(1809, t.type);
	this.keyAction = this.ReleaseActor;
	this.sx = this.sy = 0.75000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.00100000;
		this.AddSpeed_XY(0.00000000, -0.01000000);
		this.alpha -= 0.01500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 0);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.atk_id = 16384;
	this.cancelCount = 1;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32)
		{
			this.ReleaseActor();
			return true;
		}
	};
}

function Shot_NormalB( t )
{
	this.SetMotion(2009, 1);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.atk_id = 16384;
	this.cancelCount = 1;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32)
		{
			this.ReleaseActor();
			return true;
		}
	};
}

function Shot_Front( t )
{
	if (t.charge)
	{
		this.SetMotion(2019, 2);
		this.cancelCount = 3;
		this.SetFreeObject(this.x - 50 * this.direction, this.y, this.direction, function ( t )
		{
			this.SetMotion(2019, 8);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.10000000;
			};
		}, {});
	}
	else
	{
		this.SetMotion(2019, 0);
		this.cancelCount = 3;
		this.SetFreeObject(this.x - 50 * this.direction, this.y, this.direction, function ( t )
		{
			this.SetMotion(2019, 7);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.10000000;
			};
		}, {});
	}

	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.atk_id = 65536;
	this.SetSpeed_Vec(25.00000000, this.rz, this.direction);
	this.sx = this.sy = 1.50000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
		this.rz -= 9.00000000 * 0.01745329;

		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.hitCount > 0 || this.hitResult & 32)
		{
			this.callbackGroup = 0;
			this.sx = this.sy = 2.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha = this.blue = this.green -= 0.15000001;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			return true;
		}

		if (this.cancelCount <= 0 || this.count >= 20)
		{
			this.callbackGroup = 0;
			this.count = 0;
			this.sx = this.sy = 2.50000000;
			this.alpha = 1.50000000;
			this.PlaySE(3234);

			if (this.owner.occultCount)
			{
				for( local i = 0; i < 7; i++ )
				{
					local t_ = {};
					t_.v <- -12 - 6 * i;
					t_.charge <- this.initTable.charge;
					t_.rot <- (-30 + 10 * i) * 0.01745329;
					this.SetShot(this.x, this.y, this.direction, this.Shot_FrontB, t_);
				}
			}
			else
			{
				for( local i = 0; i < 5; i++ )
				{
					local t_ = {};
					t_.v <- -12 - 6 * i;
					t_.charge <- this.initTable.charge;
					t_.rot <- (-20 + 10 * i) * 0.01745329;
					this.SetShot(this.x, this.y, this.direction, this.Shot_FrontB, t_);
				}
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.85000002;
				this.alpha -= 0.15000001;

				if (this.alpha <= 1.00000000)
				{
					this.blue = this.green = this.alpha;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.DrawActorPriority();
			return;
			this.stateLabel = function ()
			{
				this.VX_Brake(1.14999998);
				this.rz -= 9.00000000 * 0.01745329;

				if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 8))
				{
					this.ReleaseActor();
					return true;
				}

				this.count++;
				this.sx = this.sy *= 0.89999998;

				if (this.count >= 10)
				{
					this.sx = this.sy = 2.50000000;
					this.alpha = 1.50000000;
					this.PlaySE(3234);

					for( local i = 0; i < 5; i++ )
					{
						local t_ = {};
						t_.v <- -12 - 6 * i;
						t_.charge <- this.initTable.charge;
						t_.rot <- (-20 + 10 * i) * 0.01745329;
						this.SetShot(this.x, this.y, this.direction, this.Shot_FrontB, t_);
					}

					this.stateLabel = function ()
					{
						this.sx = this.sy *= 0.85000002;
						this.alpha -= 0.15000001;

						if (this.alpha <= 1.00000000)
						{
							this.blue = this.green = this.alpha;
						}

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	};
}

function Shot_FrontB( t )
{
	if (t.charge)
	{
		this.SetMotion(2019, 3);
		this.cancelCount = 1;
		this.flag2 = this.SetTrail(2019, 6, 5, 30).weakref();
		this.flag1 = 0.98000002;
	}
	else
	{
		this.SetMotion(2019, 1);
		this.cancelCount = 1;
		this.flag2 = this.SetTrail(2019, 5, 5, 30).weakref();
		this.flag1 = 0.97000003;
	}

	this.rz = t.rot;
	this.atk_id = 65536;
	this.SetSpeed_Vec(15 + this.cos(this.rz * 2) * 10.00000000, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;

			if (this.flag2)
			{
				this.ReleaseActor.call(this.flag2);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.69999999;
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
		if (this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		this.SetSpeed_XY(this.va.x, this.va.y * 0.94999999);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
		this.count++;

		if (this.IsScreen(100) || this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_FrontB2( t )
{
	this.SetMotion(2019, 1);
	this.SetTrail(this.motion, 3, 5, 30);
	this.SetSpeed_XY(0.00000000, -t.v);
	this.flag1 = this.y;
	this.stateLabel = function ()
	{
		this.va.RotateByRadian(6.00000000 * 0.01745329);
		this.SetSpeed_XY(null, null);

		if (this.va.y < 0.00000000 && this.y < this.flag1)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage( t )
{
	if (t.type)
	{
		this.SetMotion(2027, 0);
	}
	else
	{
		this.SetMotion(2026, 0);
	}

	this.rz = t.rot;
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.atk_id = 262144;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 2);
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
	if (t.occult)
	{
		this.SetMotion(2028, 0);
	}
	else
	{
		this.SetMotion(2029, 0);
	}

	this.sx = this.sy = 0.10000000;
	this.atk_id = 131072;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.33000001;
	};
	this.func = [
		function ()
		{
			this.HitReset();
			this.sx = this.sy = 1.00000000;
			this.rz = 0;
			this.SetMotion(this.motion, 1);
			this.DrawActorPriority(201);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.20000000;
				this.count++;

				if (this.count >= 12)
				{
					this.alpha = this.green = this.blue -= 0.05000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.DrawActorPriority(201);

			if (this.initTable.charge)
			{
				for( local i = 0; i < 14; i++ )
				{
					local t_ = {};
					t_.v <- 40.00000000 + this.rand() % 11;
					t_.rot <- (-40 - this.rand() % 20) * 0.01745329;
					t_.wait <- 40 + i * 5;
					t_.occult <- this.initTable.occult;
					this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeF, t_);
				}
			}
			else
			{
				for( local i = 0; i < 6; i++ )
				{
					local t_ = {};
					t_.v <- 20.00000000 + this.rand() % 6;
					t_.rot <- (-50 - this.rand() % 25) * 0.01745329;
					t_.addV <- 0.00000000;
					t_.occult <- this.initTable.occult;

					if (this.initTable.k < 0)
					{
						t_.addV = 6.00000000;
					}

					if (this.initTable.k > 0)
					{
						t_.addV = -6.00000000;
					}

					this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeB, t_);
				}
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.20000000;
				this.count++;

				if (this.count >= 12)
				{
					this.alpha = this.green = this.blue -= 0.05000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				}
			};
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Shot_Charge_FirePart( t )
{
	if (t.occult)
	{
		this.SetMotion(3009, 2);
	}
	else
	{
		this.SetMotion(3009, 1);
	}

	if (this.rand() % 100 <= 50)
	{
		this.DrawActorPriority(180);
	}

	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = 0.50000000 + this.rand() % 25 * 0.10000000;
	this.sy = 0.50000000 + this.rand() % 25 * 0.10000000;
	this.keyAction = this.ReleaseActor;
	this.SetSpeed_Vec(5.00000000 + this.rand() % 6, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.25000000);
		this.sx = this.sy *= 0.92000002;
	};
}

function Shot_ChargeB( t )
{
	if (t.occult)
	{
		this.SetMotion(2028, 3);
	}
	else
	{
		this.SetMotion(2029, 3);
	}

	this.flag1 = this.SetTrail(this.motion, 5, 5, 90).weakref();
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.AddSpeed_XY(t.addV * this.direction, 0.00000000);
	this.sx = this.sy = 0.80000001 + this.rand() % 21 * 0.01000000;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.sx = this.sy = 2.00000000;
			this.alpha = 2.00000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;

				if (this.flag1)
				{
					this.flag1.alpha -= 0.25000000;
					this.flag1.anime.length *= 0.80000001;
					this.flag1.anime.radius0 *= 0.80000001;

					if (this.flag1.alpha <= 0.00000000)
					{
						this.flag1.ReleaseActor();
					}
				}

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
		if (this.va.y > 5.00000000 && this.keyTake == 3)
		{
			this.SetMotion(this.motion, 4);
		}

		if (this.y > ::camera.bottom + 200 || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 12.00000000 * 0.01745329;
		this.AddSpeed_XY(0.00000000, 0.75000000 + 0.25000000);
	};
}

function Shot_ChargeF( t )
{
	if (t.occult)
	{
		this.SetMotion(2028, 3);
	}
	else
	{
		this.SetMotion(2029, 3);
	}

	this.flag1 = this.SetTrail(this.motion, 5, 5, 90).weakref();
	this.flag2 = this.x;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.sx = this.sy = 0.80000001 + this.rand() % 21 * 0.01000000;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.sx = this.sy = 2.00000000;
			this.alpha = 2.00000000;

			for( local i = 0; i < 4; i++ )
			{
				local t_ = {};
				t_.occult <- this.initTable.occult;
				this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Charge_FirePart, t_);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;

				if (this.flag1)
				{
					this.flag1.alpha -= 0.25000000;
					this.flag1.anime.length *= 0.80000001;
					this.flag1.anime.radius0 *= 0.80000001;

					if (this.flag1.alpha <= 0.00000000)
					{
						this.flag1.ReleaseActor();
					}
				}

				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 7);
			this.x += this.rand() % 256 - 128;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count > this.initTable.wait)
				{
					this.hitCount = 0;
					this.HitReset();
					this.SetMotion(this.motion, 8);
					this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
					this.rz += (5 - this.rand() % 11) * 0.01745329;
					this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
					this.SetSpeed_Vec(t.v, this.rz, this.direction);
					this.stateLabel = function ()
					{
						this.count++;

						if (this.hitCount > 0 || this.cancelCount <= 0)
						{
							this.func[0].call(this);
							return;
						}

						if (this.count >= 3)
						{
							local t_ = {};
							t_.occult <- this.initTable.occult;
							this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Charge_FirePart, t_);
							this.count = 0;
						}

						if (this.y > ::camera.bottom + 200)
						{
							this.ReleaseActor();
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.y < ::battle.scroll_top - 300)
		{
			this.func[1].call(this);
			return;
		}

		this.rz -= 15.00000000 * 0.01745329;
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 1);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.atk_id = 536870912;
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
	this.flag1 = this.va.y * 0.02500000;
	this.subState = function ()
	{
		if (this.Vec_Brake(0.05000000, 5.00000000))
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}

		this.sx = this.sy += 0.00500000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.subState();
	};
}

function Occult_Fire( t )
{
	this.SetMotion(2509, 1);
	this.DrawActorPriority(189);
	this.rz = t.rot;
	this.sx = 0.75000000;
	this.sy = 2.00000000;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.stateLabel = function ()
		{
			this.sy *= 0.89999998;
			this.alpha = this.red = this.green -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2500 || this.owner.motion == 2501)
		{
			if (this.owner.keyTake != 1)
			{
				this.func();
			}
		}
		else
		{
			this.func();
		}
	};
}

function SPShot_A( t )
{
	this.SetMotion(3009, 1);
	this.keyAction = this.ReleaseActor;
}

function SPShot_A2( t )
{
	if (t.occult)
	{
		this.SetMotion(3009, 2);
	}
	else
	{
		this.SetMotion(3009, 1);
	}

	if (this.rand() % 100 <= 50)
	{
		this.DrawActorPriority(180);
	}

	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = 0.50000000 + this.rand() % 25 * 0.10000000;
	this.sy = 0.50000000 + this.rand() % 25 * 0.10000000;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.10000000);
		this.sx = this.sy *= 0.92000002;
	};
}

function SPShot_B( t )
{
	if (t.occult)
	{
		this.SetMotion(3018, 0);
	}
	else
	{
		this.SetMotion(3019, 0);
	}

	this.SetSpeed_XY(t.v.x * this.direction, t.v.y);
	this.rz = this.rand() % 360 * 0.01745329;
	this.atk_id = 2097152;
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3010 && this.owner.motion != 3011 || this.team.current.IsDamage())
		{
			this.func[1].call(this);
			return;
		}

		this.rz -= 8.50000000 * 0.01745329;
		this.AddSpeed_XY(0.00000000, this.va.y < 0.50000000 ? 0.50000000 : 0.05000000);
		this.count++;

		if (this.count >= 10)
		{
			this.red = this.green = this.blue += 0.15000001;
		}

		if (this.count >= 40)
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func = [
				null,
				null
			];
		}
	};
	this.func = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= this.initTable.count)
				{
					this.SetMotion(this.motion, 2);
					this.ResetSpeed();
					this.stateLabel = function ()
					{
						this.sx = this.sy += 0.02000000;
						this.alpha -= 0.15000001;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
			this.VX_Brake(this.va.x * this.direction > 1.00000000 ? 0.50000000 : 0.01000000);
			this.AddSpeed_XY(0.00000000, this.va.y < 0.50000000 ? 0.50000000 : 0.05000000);
			this.count++;
		},
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.ResetSpeed();
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02000000;
				this.alpha -= 0.15000001;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SPShot_B2( t )
{
	if (t.occult)
	{
		this.SetMotion(3018, 3);
	}
	else
	{
		this.SetMotion(3019, 3);
	}

	this.keyAction = this.ReleaseActor;
	this.atk_id = 2097152;
	this.SetShot(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(3019, 4);
		this.SetTeamSelfShot();
		this.attackTarget = this.owner.weakref();
		this.keyAction = this.ReleaseActor;
		this.stateLabel = function ()
		{
			if (this.hitResult & 1)
			{
				this.attackTarget.SetSelfDamage.call(this.attackTarget, 800);
				this.stateLabel = null;
			}
		};
	}, t);
}

function SPShot_C( t )
{
	if (this.owner.occultCount)
	{
		this.SetMotion(3028, 0);
	}
	else
	{
		this.SetMotion(3029, 0);
	}

	this.atk_id = 4194304;
	this.sx = this.sy = 1.00000000;
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.keyAction = this.ReleaseActor;
}

function SPShot_C2( t )
{
	if (this.owner.occultCount)
	{
		this.SetMotion(3028, 1);
	}
	else
	{
		this.SetMotion(3029, 1);
	}

	this.atk_id = 4194304;
	this.sx = this.sy = 1.00000000;
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.keyAction = this.ReleaseActor;
}

function SPShot_C3( t )
{
	if (this.owner.occultCount)
	{
		this.SetMotion(3028, 3);
	}
	else
	{
		this.SetMotion(3029, 3);
	}

	this.atk_id = 4194304;
	this.sx = this.sy = 1.00000000;
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.keyAction = this.ReleaseActor;
}

function SPShot_C_Fire( t )
{
	if (this.owner.occultCount)
	{
		this.SetMotion(3028, 2);
	}
	else
	{
		this.SetMotion(3029, 2);
	}

	this.sx = this.sy = 1.00000000;
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.10000000;
	};
}

function SPShot_D( t )
{
	if (t.occult)
	{
		this.SetMotion(3038, 0);
	}
	else
	{
		this.SetMotion(3039, 0);
	}

	this.rz = 60 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.keyAction = this.ReleaseActor;
	this.atk_id = 8388608;
	local t_ = {};
	t_.rot <- this.rz;
	t_.occult <- t.occult;
	this.SetFreeObject(this.x, this.y, this.direction, function ( b_ )
	{
		if (b_.occult)
		{
			this.SetMotion(3038, 1);
		}
		else
		{
			this.SetMotion(3039, 1);
		}

		this.alpha = 2.00000000;
		this.rz = b_.rot;
		this.stateLabel = function ()
		{
			this.sx = this.sy += (5.00000000 - this.sx) * 0.25000000;
			this.alpha -= 0.05000000;

			if (this.alpha <= 1.00000000)
			{
				this.blue = this.green = this.alpha;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			}
		};
	}, t_);
}

function SPShot_D2( t )
{
	this.SetMotion(3039, 1);
	this.SetSpeed_Vec(11.00000000, 45 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 45)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Wing( t )
{
	if (t.occult)
	{
		this.SetMotion(3038, 2);
	}
	else
	{
		this.SetMotion(3039, 2);
	}

	this.DrawActorPriority(180);
	this.alpha = 0.00000000;
	this.rz = t.rot;
	this.SetSpeed_Vec(3.00000000, this.rz, this.direction);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0.33000001;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.20000000);
		this.AddSpeed_XY(0.00000000, -0.25000000);
		this.alpha += 0.05000000;
		this.sx = this.sy += 0.05000000;
		this.rz += (-80 * 0.01745329 - this.rz) * 0.02500000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.20000000);
				this.AddSpeed_XY(0.00000000, -0.25000000);
				this.alpha -= 0.10000000;
				this.sx = this.sy += 0.05000000;

				if (this.alpha <= 1.00000000)
				{
					this.green = this.blue = this.alpha;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_E_Vortex( t )
{
	this.SetMotion(3049, 0);
	this.anime.length = 0;
	this.ry = 0.01745329 * this.rand() % 360;
	this.anime.radius0 *= t.scale;
	this.anime.radius1 *= t.scale;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.ry += 16.00000000 * 0.01745329;
				this.AddSpeed_XY(0.00000000, -0.75000000);
				this.alpha = this.blue = this.green -= 0.07500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.ry += 16.00000000 * 0.01745329;
		this.AddSpeed_XY(0.00000000, -0.75000000);
		this.alpha = this.blue = this.green -= 0.02500000;
		this.anime.length += (48 - this.anime.length) * 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E_ResFireDyna( t )
{
	if (t.occult)
	{
		this.SetMotion(3047, 2);
	}
	else
	{
		this.SetMotion(3049, 2);
	}

	this.anime.vertex_alpha1 = 0.00000000;
	this.alpha = 0.00000000;
	this.sx = this.sy = 2.00000000;
	this.SetParent(this.owner, 0, 0);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;
				this.anime.top -= 6.00000000;
				this.anime.radius1 += 18.00000000;

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
		this.anime.top += 12.00000000;
		this.anime.radius1 *= 0.94000000;
	};
}

function SPShot_E_ResFire( t )
{
	if (t.occult)
	{
		this.SetMotion(3047, 9);
	}
	else
	{
		this.SetMotion(3049, 9);
	}

	this.sx = this.sy = t.scale;
	this.rz = this.rand() % 360 * 0.01745329;
	this.ry = (-30 + this.rand() % 61) * 0.01745329;
	this.rx = (-30 + this.rand() % 61) * 0.01745329;
	this.SetParent(this.owner, 0, 0);
	this.DrawActorPriority(t.priority);
	this.alpha = 0.00000000;
	this.flag1 = (2 + this.rand() % 3) * 0.10000000;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 10);

			if (this.motion == 3049)
			{
				this.stateLabel = function ()
				{
					this.sx = this.sy += this.flag1;
					this.alpha = this.green = this.blue -= 0.05000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					this.sx = this.sy += this.flag1;
					this.alpha = this.green = this.red -= 0.05000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				};
			}
		}
	];
	this.stateLabel = function ()
	{
		this.rz -= 8.80000019 * 0.01745329;
		this.alpha += 0.50000000;
		this.sx = this.sy += 0.06000000;

		if (this.alpha >= 1.00000000)
		{
			this.stateLabel = function ()
			{
				this.rz -= 8.80000019 * 0.01745329;
				this.sx = this.sy += 0.02000000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_E_FirePilar( t )
{
	if (t.occult)
	{
		this.SetMotion(3046, 0);
		this.stateLabel = function ()
		{
			this.sy += 0.05000000;
			this.SetCollisionScaling(this.flag1, this.sy, 1.00000000);
			this.SetSpeed_XY(0.00000000, (::battle.scroll_bottom + 50 - this.y) * 0.10000000);
			this.alpha -= 0.10000000;

			if (this.alpha <= 1.00000000)
			{
				this.callbackGroup = 0;
				this.green = this.red = this.alpha;
				this.sx *= 0.92000002;
				this.sy *= 1.04999995;
			}

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}
	else
	{
		this.SetMotion(3048, 0);
		this.stateLabel = function ()
		{
			this.sy += 0.05000000;
			this.SetCollisionScaling(this.flag1, this.sy, 1.00000000);
			this.SetSpeed_XY(0.00000000, (::battle.scroll_bottom + 50 - this.y) * 0.10000000);
			this.alpha -= 0.10000000;

			if (this.alpha <= 1.00000000)
			{
				this.callbackGroup = 0;
				this.green = this.blue = this.alpha;
				this.sx *= 0.92000002;
				this.sy *= 1.04999995;
			}

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}

	this.atk_id = 16777216;
	this.DrawActorPriority(199);
	this.sx = (1.00000000 + 0.25000000 * t.level) * (1.00000000 + this.rand() % 31 * 0.01000000);
	this.sy = 2.00000000;
	this.flag1 = 1.00000000 + 0.25000000 * t.level;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.SetCollisionScaling(this.flag1, this.sy, 1.00000000);
	this.alpha = 3.00000000;
	this.atkRate_Pat = 1.00000000 + t.level * 0.25000000;
}

function SPShot_E_FirePart( t )
{
	if (t.occult)
	{
		this.SetMotion(3046, 1 + this.rand() % 2);
		this.sx = 0.75000000 + this.rand() % 25 * 0.01000000;
		this.sy = 0.50000000 + this.rand() % 15 * 0.10000000;
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, -0.75000000);
			this.sx += 0.02500000;
			this.sy += 0.16000000;
			this.alpha = this.green = this.red -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}
	else
	{
		this.SetMotion(3048, 1 + this.rand() % 2);
		this.sx = 0.75000000 + this.rand() % 25 * 0.01000000;
		this.sy = 0.50000000 + this.rand() % 15 * 0.10000000;
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, -0.75000000);
			this.sx += 0.02500000;
			this.sy += 0.16000000;
			this.alpha = this.green = this.blue -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}
}

function SpellShotA_VortexLost( t )
{
	if (t.occult)
	{
		this.SetMotion(4007, 2);
	}
	else
	{
		this.SetMotion(4009, 2);
	}

	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -1.00000000);
		this.sy *= 1.02499998;
		this.alpha = this.green = this.blue -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShotA_VortexA( t )
{
	if (t.occult)
	{
		this.SetMotion(4007, 1);
		this.alpha = this.green = this.red = 0.00000000;
		this.stateLabel = function ()
		{
			this.ry += 12 * 0.01745329;
			this.flag1 += 0.02500000;
			this.anime.radius1 += 10.00000000;
			this.anime.radius0 += 8.00000000;
			this.AddSpeed_XY(0.00000000, -0.85000002);

			if (this.flag1 >= 0.69999999)
			{
				this.anime.length *= 0.98000002;
				this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0.10000000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 1.00000000)
				{
					this.red = this.green = this.alpha;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			}
			else
			{
				this.alpha = this.green = this.red += 0.15000001;

				if (this.alpha > 1.00000000)
				{
					this.alpha = this.green = this.red = 1.00000000;
				}
			}
		};
	}
	else
	{
		this.SetMotion(4009, 1);
		this.alpha = this.green = this.blue = 0.00000000;
		this.stateLabel = function ()
		{
			this.ry += 12 * 0.01745329;
			this.flag1 += 0.02500000;
			this.anime.radius1 += 10.00000000;
			this.anime.radius0 += 8.00000000;
			this.AddSpeed_XY(0.00000000, -0.85000002);

			if (this.flag1 >= 0.69999999)
			{
				this.anime.length *= 0.98000002;
				this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0.10000000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 1.00000000)
				{
					this.blue = this.green = this.alpha;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			}
			else
			{
				this.alpha = this.green = this.blue += 0.15000001;

				if (this.alpha > 1.00000000)
				{
					this.alpha = this.green = this.blue = 1.00000000;
				}
			}
		};
	}

	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.ry += 12 * 0.01745329;
				this.anime.length *= 0.92500001;
				this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0.20000000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 1.00000000)
				{
					this.blue = this.green = this.alpha;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.ry = this.rand() % 360 * 0.01745329;
}

function SpellShotA_FirePart( t )
{
	this.SetMotion(4009, 4 + this.rand() % 2);
	this.sx = 0.75000000 + this.rand() % 25 * 0.01000000;
	this.sy = 0.50000000 + this.rand() % 15 * 0.10000000;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.75000000);
		this.sx += 0.02500000;
		this.sy += 0.16000000;
		this.alpha = this.green = this.blue -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShotA_FirePilar( t )
{
	this.SetMotion(4009, 3);
	this.DrawActorPriority(199);
	this.sx = 1.00000000 + this.rand() % 31 * 0.01000000;
	this.sy = 2.00000000;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.alpha = 3.00000000;
	this.stateLabel = function ()
	{
		this.sy += 0.05000000;
		this.SetCollisionScaling(1.00000000, this.sy, 1.00000000);
		this.SetSpeed_XY(0.00000000, (::battle.scroll_bottom + 50 - this.y) * 0.10000000);
		this.alpha -= 0.10000000;

		if (this.alpha <= 1.00000000)
		{
			this.callbackGroup = 0;
			this.green = this.blue = this.alpha;
			this.sx *= 0.92000002;
			this.sy *= 1.04999995;
		}

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_B_Fiji( t )
{
	if (t.occult)
	{
		this.SetMotion(4018, 8);
	}
	else
	{
		this.SetMotion(4018, 5);
	}

	this.sx = this.sy = 0.10000000;
	this.flag1 = 0.40000001;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.atkRate_Pat = t.rate;
	this.func = [
		function ()
		{
			this.flag3.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.callbackGroup = 0;
			this.flag1 = 0.00000000;
			this.stateLabel = function ()
			{
				this.sx *= 0.92000002;
				this.flag1 += 0.10000000;
				this.sy += this.flag1;
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
		this.sx = this.sy += this.flag1;
		this.flag1 -= 0.06500000;

		if (this.flag1 < 0.00000000)
		{
			this.flag1 = 0.00000000;
		}

		this.count++;

		if (this.count % 10 == 1)
		{
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			t_.occult <- this.initTable.occult;
			this.flag3.Add(this.SetShot(this.x, ::battle.scroll_bottom + 1024, 1.00000000 - this.rand() % 2 * 2, this.Spell_B_FirePilar, t_));
		}

		if (this.count % 5 == 1)
		{
			local t_ = {};
			t_.take <- 4 + this.rand() % 4;
			t_.occult <- this.initTable.occult;

			if (this.count % 4 <= 1)
			{
				this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.SpellShotB_FirePart, t_);
			}
			else
			{
				this.SetFreeObject(this.x, ::battle.scroll_bottom, -this.direction, this.SpellShotB_FirePart, t_);
			}
		}

		if (this.count == 80)
		{
			this.func[0].call(this);
		}
	};
}

function Spell_B_FirePilar( t )
{
	if (t.occult)
	{
		this.SetMotion(4018, 9);
		this.stateLabel = function ()
		{
			this.sy += 0.05000000;
			this.SetCollisionScaling(this.flag1, this.sy, 1.00000000);
			this.SetSpeed_XY(0.00000000, (::battle.scroll_bottom + 50 - this.y) * 0.10000000);
			this.alpha -= 0.10000000;

			if (this.alpha <= 1.00000000)
			{
				this.callbackGroup = 0;
				this.green = this.red = this.alpha;
				this.sx *= 0.92000002;
				this.sy *= 1.04999995;
			}

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}
	else
	{
		this.SetMotion(4018, 6);
		this.stateLabel = function ()
		{
			this.sy += 0.05000000;
			this.SetCollisionScaling(this.flag1, this.sy, 1.00000000);
			this.SetSpeed_XY(0.00000000, (::battle.scroll_bottom + 50 - this.y) * 0.10000000);
			this.alpha -= 0.10000000;

			if (this.alpha <= 1.00000000)
			{
				this.callbackGroup = 0;
				this.green = this.blue = this.alpha;
				this.sx *= 0.92000002;
				this.sy *= 1.04999995;
			}

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}

	this.atkRate_Pat = t.rate;
	this.DrawActorPriority(199);
	this.flag1 = 2.00000000;
	this.sx = this.flag1 + this.rand() % 31 * 0.01000000;
	this.sy = 2.00000000;
	this.alpha = 3.00000000;
	this.cancelCount = 3;
	this.atk_id = 67108864;
	this.SetCollisionScaling(this.flag1, this.sy, 1.00000000);
}

function SpellShotB_FirePart( t )
{
	if (t.occult)
	{
		this.SetMotion(4007, 4 + this.rand() % 2);
	}
	else
	{
		this.SetMotion(4009, 4 + this.rand() % 2);
	}

	this.sx = 0.75000000 + this.rand() % 25 * 0.01000000;
	this.sy = 0.50000000 + this.rand() % 15 * 0.10000000;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.75000000);
		this.sx += 0.02500000;
		this.sy += 0.16000000;
		this.alpha = this.green = this.blue -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_C_Swing( t )
{
	this.SetMotion(4029, 1);
	this.keyAction = this.ReleaseActor;
	this.sx = this.sy = t.scale;
	this.rx = t.rot.x;
	this.ry = t.rot.y;
	this.rz = t.rot.z;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
	};
}

function Spell_C_Amulet( t )
{
	this.SetMotion(4029, 2);
	this.rz = t.rot;
	this.SetSpeed_Vec(60.00000000, this.rz, this.direction);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.SetAllHitShot();
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4029, 4);
			this.sx = this.sy = 2.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.HitReset();
			this.cancelCount = 3;
			this.SetTeamShot();
			this.PlaySE(3296);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x, this.y, this.direction, this.Spell_C_SelfDamage, t_);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1.33000004 - this.sx) * 0.25000000;
				this.alpha = this.green = this.blue -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[1] = null;
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0)
		{
			this.func[1].call(this);
			return;
		}

		if (this.Vec_Brake(10.00000000, 0.25000000))
		{
			this.stateLabel = function ()
			{
				if (this.hitCount > 0)
				{
					this.func[1].call(this);
					return;
				}
			};
		}
	};
}

function Spell_C_SelfDamage( t )
{
	this.SetMotion(4029, 8);
	this.SetTeamSelfShot();
	this.attackTarget = this.owner.weakref();
	this.atkRate_Pat = t.rate;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.hitResult & 1)
		{
			this.attackTarget.SetSelfDamage(100 * this.atkRate_Pat);
			this.stateLabel = null;
		}
	};
}

function Spell_C_AmuletObjectA( t )
{
	this.SetMotion(4029, 5);
	this.DrawActorPriority(199);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetTaskAddRotation(0.00000000, 0.00000000, (-1.00000000 + this.rand() % 2) * 0.01745329);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2.25000000 - this.sx) * 0.15000001;
		this.alpha = this.green = this.blue -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_C_AmuletObjectB( t )
{
	this.SetMotion(4029, 6);
	this.DrawActorPriority(199);
	this.SetTaskAddRotation(0.00000000, 0.00000000, (-0.50000000 + this.rand() % 11 * 0.10000000) * 0.01745329);
	this.rz = this.rand() % 360 * 0.01745329;
	this.ry = (30 - this.rand() % 61) * 0.01745329;
	this.rx = (30 - this.rand() % 61) * 0.01745329;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.05000000);
		this.sx = this.sy += (2.20000005 - this.sx) * 0.10000000;
		this.alpha = this.green = this.blue -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_CutBack( t )
{
	this.SetMotion(4908, 1);
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(90);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Cut( t )
{
	this.SetMotion(4908, 0);
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(100);
	this.red = this.green = this.blue = 0.00000000;
	this.flag3 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.pos <- [
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag5.pos[0].x = this.x;
	this.flag5.pos[0].y = this.y;
	this.flag5.pos[1].x = 640 - 210 * this.direction;
	this.flag5.pos[1].y = 330;
	this.flag5.pos[2].x = this.x - 100 * this.direction;
	this.flag5.pos[2].y = this.y - 20;
	this.flag5.scale <- [
		4.00000000,
		0.75000000,
		3.90000010
	];
	this.flag5.rot <- [
		-12.00000000 * 0.01745329,
		10.00000000 * 0.01745329,
		-10.00000000 * 0.01745329
	];
	this.flag5.rate <- 0.00000000;
	this.flag5.rateSpeed <- 1.00000000 / 40.00000000;
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.ReleaseActor();
		}
	];
	this.flag3 = this.SetFreeObject(0, 0, 1.00000000, this.Climax_CutBack, {}).weakref();
	this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_CutFire, {}).weakref();
	this.SetParent.call(this.flag4, this, 0, 0);
	this.stateLabel = function ()
	{
		this.red = this.green = this.blue += (1.00000000 - this.red) * 0.05000000;
		this.flag5.rate += this.flag5.rateSpeed;

		if (this.flag5.rate > 1.00000000)
		{
			this.SetSpeed_XY(-0.25000000 * this.direction, -0.10000000);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 60)
				{
					if (this.flag4)
					{
						this.flag4.func[1].call(this.flag4);
					}
				}

				this.red = this.green = this.blue += (1.00000000 - this.red) * 0.05000000;
				this.sx = this.sy -= 0.00100000;
				this.rz += 0.02500000 * 0.01745329;

				if (this.flag4)
				{
					this.flag4.sx = this.flag4.sy = this.sx * this.flag4.flag1;
				}
			};
		}

		this.rz = this.Math_Bezier(this.flag5.rot[0], this.flag5.rot[1], this.flag5.rot[2], this.flag5.rate);
		this.sx = this.sy = this.Math_Bezier(this.flag5.scale[0], this.flag5.scale[1], this.flag5.scale[2], this.flag5.rate);
		this.x = this.Math_Bezier(this.flag5.pos[0].x, this.flag5.pos[1].x, this.flag5.pos[2].x, this.flag5.rate);
		this.y = this.Math_Bezier(this.flag5.pos[0].y, this.flag5.pos[1].y, this.flag5.pos[2].y, this.flag5.rate);

		if (this.flag4)
		{
			this.flag4.sx = this.flag4.sy = this.sx * this.flag4.flag1;
		}
	};
}

function Climax_CutFire( t )
{
	this.SetMotion(4908, 3);
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(101);
	this.flag1 = 0.00000000;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.flag3 = 0.75000000;
	this.func = [
		function ()
		{
			this.flag2.Foreach(function ()
			{
				this.ReleaseActor();
			});
			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(3289);
			this.subState = function ()
			{
				this.count++;

				if (this.count % 10 == 0)
				{
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_CutFire2, {});
					a_.SetParent(this, 0, 0);
					this.flag2.Add(a_);
				}

				if (this.count % 7 == 1)
				{
					local a_ = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Climax_CutPilar, {});
					a_.SetParent(this, 0, 0);
					this.flag2.Add(a_);
				}

				this.flag2.Foreach(function ( sx_ = this.sx )
				{
					this.sx = this.sy = sx_ + this.flag1;
				});
			};
			this.stateLabel = function ()
			{
				this.subState();
				this.flag1 += this.flag3;
				this.flag3 -= 0.02500000;

				if (this.flag3 < 0.34999999)
				{
					this.flag3 = 0.34999999;
				}
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.SetParent(null, 0, 0);
			this.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.01000000;
				this.alpha = this.green = this.red -= 0.01000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.count++;

		if (this.count % 10 == 0)
		{
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_CutFire2, {});
			a_.SetParent(this, 0, 0);
			this.flag2.Add(a_);
		}

		this.flag2.Foreach(function ( sx_ = this.sx )
		{
			this.sx = this.sy = sx_ + this.flag1;
		});
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.flag1 += (5.00000000 - this.flag1) * 0.02000000;
	};
}

function Climax_CutFire2( t )
{
	this.SetMotion(4908, 4);
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(100);
	this.alpha = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(1.00000000, this.rz, this.direction);
	this.flag1 = 1.00000000;
	this.subState = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.flag1 += 0.02500000;
		this.subState();
	};
}

function Climax_CutPilar( t )
{
	this.SetMotion(4908, 5);
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(100);
	this.flag1 = 1.00000000;
	this.flag2 = 35 + this.rand() % 25;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 512;
	this.anime.radius0 = 0;
	this.anime.radius1 = 0;
	this.anime.length = 1600;
	this.anime.vertex_alpha1 = 1.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.anime.top -= 20.00000000;
		this.anime.length += 15;
		this.anime.radius1 += (this.flag2 - this.anime.radius1) * 0.20000000;
		this.flag2 += 10;
		this.count++;

		if (this.count >= 2)
		{
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Ring( t )
{
	this.SetMotion(4909, 7);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.75000000;
		this.count++;

		if (this.count >= 15)
		{
			this.alpha -= 0.20000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Pilar( t )
{
	this.SetMotion(4909, 1);
	this.DrawActorPriority(181);
	this.SetParent(this.owner, 0, 0);
	this.flag1 = 35 + this.rand() % 25;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 512;
	this.anime.radius0 = 0;
	this.anime.radius1 = 0;
	this.anime.length = 1600;
	this.anime.vertex_alpha1 = 1.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.stateLabel = function ()
	{
		this.anime.top -= 20.00000000;
		this.anime.length += 15;
		this.anime.radius1 += (this.flag1 - this.anime.radius1) * 0.20000000;
		this.flag1 += 10;
		this.count++;

		if (this.count >= 20)
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Shadow( t )
{
	this.SetMotion(4908, 6);
	this.alpha = 1.00000000;
	this.SetParent(this.owner, 0, 0);
	this.DrawActorPriority(201);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx -= 0.05000000;
				this.sy += 0.05000000;
				this.AddSpeed_XY(0.00000000, -0.05000000);
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha -= 0.03300000;
		this.count++;

		if (this.count % 3 == 1)
		{
			this.SetFreeObject(this.x - 22 * this.direction, this.y - 33, this.direction, this.Climax_Shadow2, {});
		}

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
			return;
		}
	};
}

function Climax_Shadow2( t )
{
	this.SetMotion(4909, 6);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.50000000 + this.rand() % 5 * 0.10000000;
	this.SetSpeed_Vec(10.00000000, this.rand() % 360 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.20000000;
		this.AddSpeed_Vec(0.75000000, null, null);
		this.alpha -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_ShadowLine( t )
{
	this.SetMotion(4909, 5);
	this.sx = 0.00000000;
	this.sy = 0.25000000 + this.rand() % 10 * 0.10000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag2 = 1.50000000 + this.rand() % 15 * 0.10000000;
	this.stateLabel = function ()
	{
		this.sx += (this.flag2 - this.sx) * 0.05000000;
		this.sy += 0.02500000;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Ball( t )
{
	this.SetMotion(4909, 2);
	this.sx = this.sy = 0.05000000;
	this.callbackGroup = 0;
	this.atkRate_Pat = t.rate;
	this.flag1 = 0.25000000;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.flag3 = null;
	this.cancelCount = 99;
	this.atk_id = 134217728;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(-2.00000000 * this.direction, -13.00000000);
			this.count = 0;
			this.flag1 = 2.00000000;
			this.stateLabel = function ()
			{
				this.flag1 += 0.00500000;
				this.sx = this.sy += (this.flag1 - this.sx) * 0.05000000;
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.count++;
			};
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_Ring, {});
			this.sx = this.sy = 5.00000000;
			this.callbackGroup = this.team.callback_group_shot;
			this.flag1 = 16.00000000;
			this.flag3 = this.SetFreeObject(this.owner.x, this.owner.y, this.direction, this.Climax_Shadow, {}).weakref();
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.flag1 - this.sx) * 0.05000000;
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.HitCycleUpdate(10);
				this.count++;

				if (this.count % 10 == 0)
				{
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_BallFire, {});
					a_.SetParent(this, 0, 0);
					this.flag2.Add(a_);
				}

				this.flag2.Foreach(function ( sx_ = this.sx )
				{
					this.sx = this.sy = sx_ + this.flag1;
				});
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0.01000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.flag1 += 0.00500000;
		this.rz -= 3.00000000 * 0.01745329 * this.sin(this.count * 3 * 0.01745329);
		this.sx = this.sy += (this.flag1 - this.sx) * 0.10000000;
	};
}

function Climax_BallFireA( t )
{
	this.SetMotion(4909, 4);
	this.EnableTimeStop(false);
	this.sx = this.sy = 0.00000000;
	this.flag1 = 2.00000000 + this.rand() % 10 * 0.10000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(1.00000000, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.sx += (this.flag1 - this.sx) * 0.15000001;
		this.sy = this.sx;
		this.count++;

		if (this.count >= 5)
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_BallFireA2( t )
{
	this.SetMotion(4909, 3);
	this.EnableTimeStop(false);
	this.sx = this.sy = 0.50000000;
	this.alpha = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(1.00000000, this.rz, this.direction);
	this.subState = function ()
	{
		this.alpha += 0.20000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.sx += 0.05000000;
		this.sy += 0.05000000;
		this.subState();
	};
}

function Climax_BallFire( t )
{
	this.SetMotion(4909, 3);
	this.rz = this.rand() % 360 * 0.01745329;
	this.DrawActorPriority(180);
	this.alpha = 0.00000000;
	this.flag2 = (2.00000000 + this.rand() % 20 * 0.10000000) * 0.01745329;
	this.subState = function ()
	{
		this.alpha += 0.20000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 15)
				{
					this.flag1 += 0.05000000;
					this.alpha -= 0.10000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.flag1 += 0.05000000 * this.sx;
		this.rz += this.flag2;
		this.subState();
	};
}

