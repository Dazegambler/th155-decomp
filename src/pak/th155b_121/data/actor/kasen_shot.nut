function BeginBattleB_TigerMask( t )
{
	this.SetMotion(9001, 7);
	this.DrawActorPriority(179);
	this.anime.is_write = true;
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.ReleaseActor();
	};
}

function BeginBattleB_TigerMaskB( t )
{
	this.SetMotion(9001, 8);
	this.DrawActorPriority(179);
	this.anime.is_write = true;
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.ReleaseActor();
	};
}

function BeginBattleB_Object( t )
{
	this.SetMotion(9001, 0);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(20.00000000 * this.direction, -10.00000000);
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.flag2 = this.Vector3();
	this.func = function ()
	{
		if (this.option)
		{
			this.option.func();
		}

		this.ReleaseActor();
	};
	this.PlaySE(3034);
	this.stateLabel = function ()
	{
		if (this.subState)
		{
			this.subState();
		}
	};
	this.keyAction = [
		function ()
		{
			this.owner.x = this.x;
			this.owner.y = this.y;
			this.owner.centerStop = -3;
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = this.va.x;
			t_.v.y = this.va.y;
			this.owner.BeginBattleB_Fall(t_);
		},
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 5.00000000 ? 0.20000000 : 0.00000000);
				this.AddSpeed_XY(0.00000000, 1.39999998);
				this.count++;

				if (this.y > ::battle.scroll_bottom + 256)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.VX_Brake(this.va.x * this.direction >= 5.00000000 ? 0.40000001 : 0.00000000);
		this.AddSpeed_XY(0.00000000, 0.40000001);

		if (this.x > ::battle.corner_right - 50 && this.direction == 1.00000000 || this.x < ::battle.corner_left + 50 && this.direction == -1.00000000)
		{
			this.SetSpeed_XY(0.00000000, null);
		}
	};
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 4);
	this.rz = t.rot;
	this.flag1 = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_Normal_Aura, {}).weakref();
	this.flag1.rx = this.rz * this.direction;
	this.flag1.SetParent(this, 0, 0);
	this.func = [
		function ()
		{
			this.SetMotion(2009, 0);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
				this.SetSpeed_XY.call(this.flag1, this.va.x * 0.50000000, this.va.y * 0.50000000);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha = this.red = this.green -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(2009, 2);
			this.flag1.SetParent(this, 0, 0);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100.00000000) || this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.Damage_ConvertOP(this.x, this.y, 4))
				{
					this.func[0].call(this);
					return true;
				}

				this.AddSpeed_Vec(0.75000000, this.rz, 15.00000000, this.direction);
			};
			this.PlaySE(3080);

			for( local i = 0; i < 12; i++ )
			{
				local t_ = {};
				t_.rot <- this.rz;
				t_.rot2 <- i * 30 * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.Shot_NormalMini, t_);
			}

			this.func[0].call(this);
			return;
		}
	];
	this.SetSpeed_Vec(3.50000000, t.rot, this.direction);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.cancelCount = 3;
	this.atk_id = 16384;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100.00000000) || this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.func[0].call(this);
			return true;
		}

		this.count++;

		if (this.count >= 20)
		{
			this.func[1].call(this);
		}
	};
}

function Shot_NormalMini( t )
{
	this.SetMotion(2009, 3);
	this.func = function ()
	{
		this.SetMotion(2009, 0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.89999998;
			this.alpha = this.red = this.green -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.sx = this.sy = 0.50000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.flag2 = this.Vector3();
	this.flag2.x = 0.25000000;
	this.flag2.RotateByRadian(t.rot2);
	this.flag2.y *= 2.50000000;
	this.flag2.RotateByRadian(t.rot);
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.AddSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	this.flag2.x = this.va.x * 0.10000000;
	this.flag2.y = this.va.y * 0.10000000;
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100.00000000) || this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.func();
			return true;
		}

		this.AddSpeed_XY(this.flag2.x, this.flag2.y);
	};
}

function Shot_Normal_Aura( t )
{
	this.SetMotion(2009, 1);
	this.func = [
		function ()
		{
			this.flag1 = 7.50000000 * 0.01745329;
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.rz += this.flag1;
				this.flag1 *= 0.89999998;
				this.anime.top -= 10.00000000;
				this.Vec_Brake(0.50000000, 0.50000000);
				this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0.10000000;
				this.anime.length *= 0.85000002;
				this.sx = this.sy += (2.00000000 - this.sx) * 0.10000000;
				this.alpha -= 0.05000000;

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
				this.rz -= 6.00000000 * 0.01745329;
				this.anime.top -= 10.00000000;
				this.sx = this.sy += (1.00000000 - this.sx) * 0.15000001;
			};
		}
	];
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 43;
	this.anime.radius1 = 135;
	this.anime.length = 69;
	this.anime.vertex_alpha1 = 0.00000000;
	this.anime.vertex_red1 = 0.00000000;
	this.anime.vertex_green1 = 0.00000000;
	this.ry = -75 * 0.01745329;
	this.sx = this.sy = 0.60000002;
	this.stateLabel = function ()
	{
		this.rz -= 3.00000000 * 0.01745329;
		this.anime.top -= 5.00000000;
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 4);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0.15000001;
				this.sy *= 0.80000001;
				this.sx *= 1.10000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.flag1 = 1;
		}
	];
	this.flag1 = 0;
	this.SetSpeed_XY(17.50000000 * this.direction, 0.00000000);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 9;
	this.atk_id = 65536;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 6) || this.flag1 >= 1)
		{
			this.func[0].call(this);
			return true;
		}

		this.VX_Brake(0.50000000);

		if (this.direction == 1.00000000 && this.x > ::battle.corner_right || this.direction == -1.00000000 && this.x < ::battle.corner_left)
		{
			this.VX_Brake(1.50000000);
		}

		this.sx += 0.01000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.flag1 > 0)
		{
			this.flag1++;
		}

		this.count++;

		if (this.hitCount >= 5 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(8);

		if (this.flag1 == 0 && this.count % 6 == 1)
		{
			this.SetParent.call(this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_FrontVortexA, {}), this, 0, 0);
			local t_ = {};
			t_.target <- this.weakref();
			this.SetFreeObjectDynamic(this.owner.point0_x, this.owner.point0_y, this.direction, this.Shot_FrontVortexB, t_);
		}
	};
}

function Shot_FrontVortexA( t )
{
	this.SetMotion(2019, 1 + this.rand() % 3);
	this.rx = 5 * 0.01745329;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 48;
	this.anime.radius0 = 20 + this.rand() % 16;
	this.anime.radius1 = this.anime.radius0 + this.rand() % 64;
	this.anime.length = 16;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = (10 - this.rand() % 21) * 0.01745329;
	this.ry = 70 * 0.01745329;
	this.flag1 = 6.00000000 + this.rand() % 3;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.50000000 * this.direction, 0.00000000);
				this.rz += 24.00000000 * 0.01745329;
				this.anime.radius0 += 4.40000010;
				this.anime.radius1 += (this.anime.radius0 - this.anime.radius1) * 0.10000000;
				this.anime.length *= 0.94999999;
				this.alpha -= 0.05000000;
				this.red = this.green = this.blue -= 0.00500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
		if (this.alpha < 1.00000000)
		{
			this.alpha += 0.10000000;
		}

		this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.50000000 : 0.01000000);
		this.rz += 18.00000000 * 0.01745329;
		this.anime.radius0 += this.flag1;
		this.anime.radius1 += this.flag1 * 1.25000000;
		this.flag1 *= 0.85000002;
		this.anime.length += (96 - this.anime.length) * 0.10000000;
		this.count++;

		if (this.count >= 24)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_FrontVortexB( t )
{
	this.SetMotion(2019, 1 + this.rand() % 3);
	this.rx = 5 * 0.01745329;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 48;
	this.anime.radius0 = 10 + this.rand() % 8;
	this.anime.radius1 = this.anime.radius0 + this.rand() % 16;
	this.anime.length = 64;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = (10 - this.rand() % 21) * 0.01745329;
	this.ry = 70 * 0.01745329;
	this.flag1 = 1.00000000 + this.rand() % 2;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.initTable.target)
				{
					this.SetSpeed_XY((this.initTable.target.x + 128 * this.direction - this.x) * 0.05000000, 0.00000000);
				}
				else
				{
					this.VX_Brake(1.50000000);
				}

				this.rz += 24.00000000 * 0.01745329;
				this.anime.radius0 += 12.39999962;
				this.anime.radius1 += (this.anime.radius0 - this.anime.radius1) * 0.10000000;
				this.anime.length *= 0.85000002;
				this.alpha -= 0.10000000;
				this.red = this.green = this.blue -= 0.00500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.alpha < 1.00000000)
		{
			this.alpha += 0.10000000;
		}

		this.rz += 40.00000000 * 0.01745329;
		this.anime.radius0 += this.flag1;
		this.anime.radius1 += this.flag1 * 1.25000000;
		this.flag1 *= 0.85000002;
		this.anime.length += (160 - this.anime.length) * 0.10000000;

		if (this.initTable.target)
		{
			this.SetSpeed_XY((this.initTable.target.x + 128 * this.direction - this.x) * 0.05000000, 0.00000000);
		}

		this.count++;

		if (this.count >= 20)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 0);
	this.sx = this.sy = 0.00000000;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.flag1 = this.Vector3();
	this.flag2 = 0;
	this.flag3 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_ChargeLight, {}).weakref();
	this.flag4 = ::manbow.Actor2DProcGroup();
	this.flag3.SetParent(this, 0, 0);
	this.flag1.x = this.rand() % 11 * 0.10000000;
	this.flag1.y = this.rand() % 11 * 0.10000000;
	this.flag1.z = this.rand() % 11 * 0.10000000;
	this.count = 15;
	this.stateLabel = function ()
	{
		if (this.owner.motion != 2020)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		this.flag2++;

		if (this.count >= 20)
		{
			this.count = 0;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_ChargeAura, {});
			a_.SetParent(this, 0, 0);
			this.flag4.Add(a_);
		}

		if (this.count % 4 == 1)
		{
			local a_ = this.SetFreeObject(this.x + 100 - this.rand() % 201, this.y + 100 - this.rand() % 201, this.direction, this.Shot_ChargeParticle, {}, this.weakref());
			a_.SetParent(this, a_.x - this.x, a_.y - this.y);
			this.flag4.Add(a_);
		}

		local s_ = 0.00000000;

		if (this.flag2 < 30)
		{
			s_ = (0.50000000 - this.sx) * 0.10000000;
		}
		else
		{
			s_ = (1.50000000 - this.sx) * 0.50000000;
		}

		if (s_ <= 0.01000000)
		{
			s_ = 0.01000000;
		}

		this.sx = this.sy += s_;

		if (this.flag3)
		{
			this.flag3.sx = this.flag3.sy = this.sx * 2;
			this.flag3.SetSpeed_XY((1.00000000 - this.sx) * 15 * this.direction, (1.00000000 - this.sy) * 15);
		}
	};
	this.func = [
		function ()
		{
			this.flag4.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.SetMotion(2029, 0);
			this.ResetSpeed();
			this.sx = this.sy = 3.00000000;

			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			local t_ = {};
			t_.rot <- this.initTable.rot;
			this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeFire, t_);
			this.flag4.Foreach(function ()
			{
				this.func[0].call(this);
			});

			if (this.flag3)
			{
				this.flag3.func[1].call(this.flag3);
			}

			this.HitReset();
			this.SetMotion(2029, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (0.25000000 - this.sx) * 0.50000000;

				if (this.IsScreen(100.00000000))
				{
					this.ReleaseActor();
					return;
				}

				if (this.Damage_ConvertOP(this.x, this.y, 6))
				{
					this.func[0].call(this);
					return;
				}

				if (this.Vec_Brake(0.75000000))
				{
					this.func[2].call(this);
					return;
				}
			};
			this.SetSpeed_Vec(this.initTable.v, this.initTable.rot, this.direction);
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Shot_ChargeExp, {});
			this.PlaySE(3028);

			if (this.initTable.charge)
			{
				this.PlaySE(3081);
				this.SetMotion(2029, 11);
				this.count = 0;
				this.DrawActorPriority(201);
				this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeMarker, {});
				this.stateLabel = function ()
				{
					this.sx = this.sy += (6.00000000 - this.sx) * 0.20000000;
					this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
					this.count++;

					if (this.count == 20)
					{
						this.callbackGroup = 0;
						this.count = 0;
						this.stateLabel = function ()
						{
							this.count++;

							if (this.count % 5 == 1)
							{
								for( local i = 0; i < 3; i++ )
								{
									local t_ = {};
									t_.v <- 2.00000000;
									t_.rot <- this.count * 5 * 0.01745329 + i * 120 * 0.01745329;
									this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeMini, t_);
								}
							}

							this.alpha -= 0.05000000;

							if (this.alpha <= -2.00000000)
							{
								this.ReleaseActor();
							}
						};
					}
				};
			}
			else
			{
				this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeMarker, {});
				this.ReleaseActor();
				return;
			}
		}
	];
}

function Shot_ChargeMini( t )
{
	this.SetMotion(2029, 9);
	this.cancelCount = 1;
	this.atk_id = 131072;
	this.func = [
		function ()
		{
			this.SetMotion(2029, 10);
			this.sx = this.sy = 3.00000000;
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
		}
	];
	this.sx = this.sy = 3.00000000;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.15000001;
	};
}

function Shot_ChargeMarkerAttack( t )
{
	this.SetMotion(2029, 1);
	this.sx = this.sy = 4.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy -= (1.00000000 - this.sx) * 0.10000000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_ChargeMarkerB( t )
{
	this.Shot_ChargeMarker(t);
	this.SetMotion(2029, 12);
}

function Shot_ChargeMarker( t )
{
	this.SetMotion(2029, 1);
	this.atk_id = 131072;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag3 = null;
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.SetMotion(2029, 0);
			this.ResetSpeed();
			this.sx = this.sy = 3.00000000;

			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			foreach( val, a in this.owner.mark )
			{
				if (a && a == this)
				{
					this.owner.mark.remove(val);
					break;
				}
			}

			this.func[0].call(this);
		}
	];
	this.count = 0;
	this.sx = this.sy = 4.00000000;
	this.keyAction = function ()
	{
		this.DrawActorPriority(180);

		if (this.owner.mark.len() > 0)
		{
			foreach( a in this.owner.mark )
			{
				if (a)
				{
					if (a.motion == 4028)
					{
						this.func[0].call(this);
						return;
					}

					a.func[0].call(a);
				}
			}
		}

		this.owner.mark = [];
		this.owner.mark.append(this.weakref());
	};
	local a_ = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_Charge_EffectAura, {});
	a_.SetParent(this, 0, 0);
	this.flag1.Add(a_);
	this.stateLabel = function ()
	{
		this.rz -= 0.25000000 * 0.01745329;
		this.count++;

		if (this.count % 4 == 1)
		{
			local a_ = this.SetFreeObject(this.x + 100 - this.rand() % 201, this.y + 100 - this.rand() % 201, this.direction, this.Shot_ChargeParticle, {}, this.weakref());
			a_.SetParent(this, a_.x - this.x, a_.y - this.y);
			this.flag1.Add(a_);
		}

		if (this.count % 30 == 1)
		{
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Charge_EffectRing, {});
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
	};
}

function Shot_ChargeFire( t )
{
	this.SetMotion(2029, 6);
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.sx = this.sy = 2.00000000;
	this.SetCollisionScaling(3.00000000, 2.00000000, 1.00000000);
	this.stateLabel = function ()
	{
		this.sx += (4.00000000 - this.sx) * 0.25000000;
		this.sy *= 0.89999998;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_ChargeLight( t )
{
	this.SetMotion(2029, 4);
	this.sx = this.sy = 0.00000000;
	this.func = [
		function ()
		{
			this.ResetSpeed();
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
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.15000001;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function Shot_ChargeAura( t )
{
	this.SetMotion(2029, 3);
	this.DrawActorPriority(199);
	this.alpha = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;
				this.sx = this.sy += 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;
		this.sx = this.sy += 0.05000000;

		if (this.alpha >= 1.00000000)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_ChargeParticle( t )
{
	this.SetMotion(2029, 3);
	this.rz = this.rand() % 360 * 0.01745329;
	this.DrawActorPriority(198);
	this.sx = this.sy = 0.01000000;
	this.flag1 = 0.10000000 + this.rand() % 11 * 0.01000000;
	this.flag2 = 0.10000000;
	this.flag3 = this.Vector3();
	this.flag3.x = t.pare.x - this.x;
	this.flag3.y = t.pare.y - this.y;
	this.flag3.Normalize();
	this.SetSpeed_XY(this.flag3.x, this.flag3.y);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0.15000001;

		if (this.sx >= this.flag1 - 0.05000000)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.97000003;
				this.flag2 += (1.00000000 - this.flag2) * 0.05000000;
				this.flag3.x = (this.initTable.pare.x - this.x) * 0.25000000;
				this.flag3.y = (this.initTable.pare.y - this.y) * 0.25000000;
				this.SetSpeed_XY(this.flag3.x * this.flag2, this.flag3.y * this.flag2);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Shot_ChargeExp( t )
{
	this.SetMotion(2029, 4);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (6.00000000 - this.sx) * 0.25000000;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Charge_EffectRing( t )
{
	this.SetMotion(2029, 8);
	this.DrawActorPriority(180);
	this.rz = this.rand() % 360 * 0.01745329;
	this.ry = (60 - this.rand() % 120) * 0.01745329;
	this.rx = (60 - this.rand() % 120) * 0.01745329;
	this.sx = this.sy = 0.75000000;
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.02500000;
				this.sx = this.sy += 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
		this.alpha += 0.02500000;

		if (this.alpha > 1.00000000)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_Charge_EffectAura( t )
{
	this.SetMotion(2029, 5);
	this.DrawActorPriority(180);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 33;
	this.anime.radius1 = 85;
	this.anime.length = 69;
	this.anime.vertex_alpha1 = 0.00000000;
	this.rx = 20 * 0.01745329;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.rz -= 0.01745329;
				this.anime.top -= 1.00000000;
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
		this.rz -= 0.01745329;
		this.anime.top -= 1.00000000;
		this.alpha += 0.20000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}
	};
}

function Shot_Barrage_Core( t )
{
	this.SetMotion(2026, 2);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.sx = this.sy = 0.00000000;
	this.flag1 = this.Vector3();
	this.flag1.x = -130.00000000;
	this.flag2 = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState;
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.flag1.RotateByRadian(-0.08726646);
		this.vec.x = this.flag1.x;
		this.vec.y = this.flag1.y;
		this.vec.y *= 0.33000001;

		if (this.drawPriority == 180 && this.vec.y > 0)
		{
			this.DrawActorPriority(200);
		}

		if (this.drawPriority == 200 && this.vec.y < 0)
		{
			this.DrawActorPriority(180);
		}

		this.vec.RotateByRadian(this.initTable.rot);
		this.SetSpeed_XY(this.owner.x + this.vec.x * this.direction - this.x, this.owner.y + this.vec.y - this.y);
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.owner.motion != 2025)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		this.subState();

		if (this.count <= 20)
		{
			this.sx = this.sy += 0.10000000;
		}

		if (this.count == 20)
		{
			this.flag2 = this.atan2(this.owner.target.y - this.owner.y, (this.owner.target.x - this.owner.x) * this.owner.direction);
		}

		if (this.count >= 20 && this.count <= 60)
		{
			if (this.count % 3 == 1)
			{
				local t_ = {};
				t_.rot <- this.flag2;
				t_.v <- this.count * 0.25000000;
				this.SetShot(this.x, this.y, this.owner.direction, this.Shot_Barrage, t_);
			}
		}

		if (this.count >= 90)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.alpha = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 2.00000000;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.alpha = 1.00000000;
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

		this.alpha += 0.25000000;
		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
	};
}

function Shot_Okult( t )
{
	this.SetMotion(2509, 0);
	this.cancelCount = 3;
	this.atk_id = 524288;
	this.flag2 = this.Vector3();
	this.flag3 = null;
	this.flag4 = 1.25000000;
	this.SetSpeed_XY(14.50000000 * this.direction * this.flag4, 0.00000000);
	this.func = [
		function ()
		{
			this.SetMotion(2509, 2);

			if (this.flag3)
			{
				this.flag3.freeMap = false;
				this.owner.KnockBackTarget(-this.direction);
				this.flag3.SetParent(null, 0, 0);
			}

			this.ReleaseActor();
		},
		function ()
		{
			if (this.keyTake <= 1)
			{
				this.SetMotion(2509, 2);
			}

			this.owner.target.DamageGrab_Common(301, 2, -this.direction);
			this.flag3 = this.owner.target.weakref();
			this.flag3.freeMap = true;
			this.flag3.x = this.point0_x;
			this.flag3.y = this.point0_y;
			this.flag3.SetParent(this, this.flag3.x - this.x, this.flag3.y - this.y);
			this.count = 0;
			this.subState = function ()
			{
				if (this.Vec_Brake(3.00000000))
				{
					this.count++;

					if (this.count >= 10)
					{
						this.subState = function ()
						{
							this.flag2.x = this.owner.point0_x - this.x;
							this.flag2.y = this.owner.point0_y - this.y;

							if (this.flag2.Length() <= 15)
							{
								this.flag3.SetParent(null, 0, 0);
								this.owner.func[0].call(this.owner);
								this.ReleaseActor();
								return;
							}

							this.flag2.SetLength(3.00000000);
							this.va = this.va + this.flag2;

							if (this.va.Length() > 25.00000000)
							{
								this.va.x = this.owner.point0_x - this.x;
								this.va.y = this.owner.point0_y - this.y;
								this.va.SetLength(25.00000000);
							}

							this.ConvertTotalSpeed();
							this.rz = this.atan2(this.va.y, this.va.x * this.direction) + 3.14159203;
						};
					}
				}
			};
			this.stateLabel = function ()
			{
				if (this.owner.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				this.subState();
			};
		},
		function ()
		{
			if (this.keyTake <= 1)
			{
				this.SetMotion(2509, 2);
			}

			this.subState = function ()
			{
				if (this.Vec_Brake(6.00000000))
				{
					this.subState = function ()
					{
						this.flag2.x = this.owner.point0_x - this.x;
						this.flag2.y = this.owner.point0_y - this.y;

						if (this.flag2.Length() <= 15)
						{
							this.owner.func[0].call(this.owner);
							this.ReleaseActor();
							return;
						}

						this.flag2.SetLength(3.00000000);
						this.va = this.va + this.flag2;

						if (this.va.Length() > 25.00000000)
						{
							this.va.SetLength(25.00000000);
						}

						this.rz = this.atan2(this.va.y, this.va.x * this.direction) + 3.14159203;
						this.SetSpeed_XY(null, null);
					};
				}
			};
			this.stateLabel = function ()
			{
				if (this.owner.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				if (this.owner.motion != 2500)
				{
					this.func[0].call(this);
					return;
				}

				this.subState();
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.ReleaseActor();
			return;
		}

		if (this.owner.motion != 2500)
		{
			this.ReleaseActor();
			return;
		}

		if (this.owner.input.y < 0)
		{
			this.rz -= 2.00000000 * 0.01745329 * this.flag4;
			this.va.RotateByDegree(-2.00000000 * this.direction * this.flag4);
		}

		if (this.owner.input.y > 0)
		{
			this.rz += 2.00000000 * 0.01745329 * this.flag4;
			this.va.RotateByDegree(2.00000000 * this.direction * this.flag4);
		}

		this.SetSpeed_XY(null, null);
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
		this.count++;
	};
}

function Shot_Okult_Back( t )
{
	this.target = this.owner.target.weakref();
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.target.cameraPos.y = this.y;
	this.target.Warp(this.point0_x, this.point0_y);
	this.stateLabel = function ()
	{
		this.target.cameraPos.y = this.y;
		this.target.Warp(this.point0_x, this.point0_y);
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.atk_id = 536870912;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_Vec(17.50000000, t.rot, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.alpha = 2.00000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.85000002;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.SetMotion(this.motion, 1);
			this.HitReset();
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
				this.count++;

				if (this.count % 4 == 0)
				{
					this.rz = this.rand() % 360 * 0.01745329;
				}

				this.Vec_Brake(2.00000000, 0.00000000);
				this.HitCycleUpdate(5);

				if (this.count == 30)
				{
					this.owner.eagle.Eagle_MarkAssultB(this);
				}

				if (this.hitCount >= 10 || this.count >= 60)
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0 || this.count >= 30)
		{
			this.func[1].call(this);
			return true;
		}

		this.TargetHoming(this.owner.target, 0.01745329, this.direction);
	};
}

function SPShot_A_Tiger( t )
{
	this.SetMotion(3009, 0);
	this.owner.tiger = true;
	this.DrawActorPriority(180);
	this.cancelCount = 3;
	this.atk_id = 1048576;
	this.SetSpeed_XY(20.00000000 * this.direction, -10.00000000);
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.flag2 = this.Vector3();
	this.option = this.SetFreeObjectStencil(this.x + 200 * this.direction, this.y - 100, this.direction, this.SPShot_A_TigerMask, {}).weakref();
	this.anime.stencil = this.option;
	this.func = function ()
	{
		if (this.option)
		{
			this.option.func();
		}

		this.owner.tiger = null;
		this.ReleaseActor();
	};
	this.PlaySE(3034);
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.callbackGroup = 0;
		}

		if (this.subState)
		{
			this.subState();
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3035);
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_TigerCrow, {});
			this.HitReset();

			if (this.option)
			{
				this.option.func();
				this.option = this.SetFreeObjectStencil(this.x + 100 * this.direction, this.y + 200, this.direction, this.SPShot_A_TigerMaskB, {}).weakref();
				this.anime.stencil = this.option;
			}
		},
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 5.00000000 ? 0.20000000 : 0.00000000);
				this.AddSpeed_XY(0.00000000, 1.39999998);

				if (this.x > ::battle.corner_right - 50 && this.direction == 1.00000000 || this.x < ::battle.corner_left + 50 && this.direction == -1.00000000)
				{
					this.SetSpeed_XY(0.00000000, null);
				}

				this.count++;

				if (this.count >= 25)
				{
					if (this.option)
					{
						this.option.func();
					}

					this.owner.tiger = null;
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.VX_Brake(this.va.x * this.direction >= 5.00000000 ? 0.40000001 : 0.00000000);
		this.AddSpeed_XY(0.00000000, 0.40000001);

		if (this.x > ::battle.corner_right - 50 && this.direction == 1.00000000 || this.x < ::battle.corner_left + 50 && this.direction == -1.00000000)
		{
			this.SetSpeed_XY(0.00000000, null);
		}
	};
}

function SPShot_A_TigerGate( t )
{
	this.SetMotion(3009, 6);
	this.DrawActorPriority(170);
	this.sx = this.sy = 0.00000000;
	this.rz = t.rot;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_TigerGateF, t_).weakref();
	this.flag1.SetParent(this, 0, 0);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.50000000 - this.sx) * 0.25000000;

		if (this.flag1)
		{
			this.flag1.sx = this.flag1.sy = this.sx;
		}
	};
	this.func = function ()
	{
		this.count = 0;
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count >= 12)
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}

				this.stateLabel = function ()
				{
					this.sx = this.sy *= 0.80000001;

					if (this.flag1)
					{
						this.flag1.sx = this.flag1.sy = this.sx;
					}

					if (this.sx <= 0.01000000)
					{
						this.ReleaseActor();
					}
				};
			}
		};
	};
}

function SPShot_A_TigerGateF( t )
{
	this.SetMotion(3009, 7);
	this.DrawActorPriority(170);
	this.sx = this.sy = 0.00000000;
	this.rz = t.rot;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SPShot_A_TigerMask( t )
{
	this.SetMotion(3009, 3);
	this.DrawActorPriority(179);
	this.anime.is_write = true;
	local t_ = {};
	t_.rot <- 90.00000000 * 0.01745329;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_TigerGate, t_).weakref();
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.ReleaseActor();
	};
}

function SPShot_A_TigerMaskB( t )
{
	this.SetMotion(3009, 4);
	this.DrawActorPriority(179);
	this.anime.is_write = true;
	local t_ = {};
	t_.rot <- 0.00000000;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_A_TigerGate, t_).weakref();
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.ReleaseActor();
	};
}

function SPShot_A_TigerCrow( t )
{
	this.SetMotion(3009, 5);
	this.keyAction = this.ReleaseActor;
}

function SPShot_B( t )
{
}

function SPShot_B_Feather( t )
{
	this.DrawActorPriority(179);
	this.SetMotion(3018, 5);
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag1 = (5.00000000 + this.rand() % 6) * 0.01745329;
	this.SetSpeed_XY(3.00000000 - this.rand() % 7, -this.rand() % 4);
	this.sx = this.sy = 0.89999998 + this.rand() % 3 * 0.10000000;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.02500000, 1.00000000);
		this.flag1 *= 0.92000002;
		this.rz += this.flag1;
		this.AddSpeed_XY(0.00000000, 0.10000000);
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_B_AuraF( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(3018, 4);
	this.rz = t.rot;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx *= 1.04999995;
				this.sy *= 0.89999998;
				this.alpha = this.red = this.green -= 0.15000001;

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

function SPShot_B_Aura( t )
{
	this.DrawActorPriority(179);
	this.SetMotion(3018, this.rand() % 4);
	this.rz = t.rot;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx += (2.50000000 - this.sx) * 0.10000000;
		this.sy -= 0.10000000;

		if (this.sy <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SP_C_SparkCharge( t )
{
	this.SetMotion(3029, 3);
	this.stateLabel = function ()
	{
		this.anime.radius0 += (this.initTable.scale - this.anime.radius0) * 0.25000000;
		this.anime.radius1 += (this.initTable.scale - this.anime.radius1) * 0.25000000;
		this.alpha = this.red = this.green -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SP_C_Spark( t )
{
	this.SetMotion(3029, 1);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;
				this.alpha = this.red = this.green -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SPShot_C( t )
{
	this.SetMotion(3029, 2);
	this.atk_id = 4194304;
	this.keyAction = this.ReleaseActor;
	this.sx = this.sy = t.scale;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.stateLabel = function ()
	{
		this.sy += 0.01000000;
		this.sx *= 0.99800003;
		this.count++;

		if (this.count == 4 && this.initTable.num > 0)
		{
			local t_ = {};
			t_.scale <- this.sx;
			t_.num <- this.initTable.num - 1;
			this.SetShot(this.x + 25 * this.direction, this.y + 10, this.direction, this.SPShot_C, t_);
		}
	};
}

function SPShot_D_OpenSplash( t )
{
	this.SetMotion(3039, 5);
	this.sx = this.sy = 0.10000000;
	this.SetSpeed_XY(0.00000000, -5.00000000);
	this.DrawActorPriority(180);
	this.flag1 = 1.00000000;
	this.stateLabel = function ()
	{
		this.flag1 += 0.10000000;
		local s_ = (1.75000000 - this.sx) * 0.20000000;

		if (s_ < 0.02000000)
		{
			s_ = 0.02000000;
		}

		this.sx += s_;
		this.sy = this.sx;
		this.sy *= this.flag1;
		this.count++;
		this.AddSpeed_XY(0.00000000, 0.60000002);

		if (this.count >= 15)
		{
			this.alpha = this.red = this.green -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_D_OpenSplashB( t )
{
	this.SetMotion(3039, 5);
	this.sx = this.sy = 0.10000000;
	this.SetSpeed_XY(0.00000000, -1.00000000);
	this.DrawActorPriority(179);
	this.stateLabel = function ()
	{
		local s_ = (1.10000002 - this.sx) * 0.20000000;

		if (s_ < 0.02000000)
		{
			s_ = 0.02000000;
		}

		this.sx = this.sy += s_;
		this.count++;
		this.AddSpeed_XY(0.00000000, 0.10000000);

		if (this.count >= 15)
		{
			this.alpha = this.red = this.green -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_D_Edge( t )
{
	this.SetMotion(3039, 5 + this.rand() % 4);
	this.DrawActorPriority(179);
	this.rz = (-5 + this.rand() % 11) * 0.01745329;
	this.alpha = 0.00000000;
	this.flag1 = 1.00000000;
	this.flag2 = 0.50000000;
	this.flag3 = 1.00000000;
	this.subState = function ()
	{
		this.alpha += 0.20000000;

		if (this.alpha >= 1.00000000)
		{
			this.func[0].call(this);
		}
	};
	this.func = [
		function ()
		{
			this.subState = function ()
			{
				this.alpha = this.red = this.green -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0.01000000;
		this.flag3 += 0.03000000;
		this.sx = this.sy = this.flag2 * this.flag1;
		this.sy *= this.flag3;
		this.count++;

		if (this.count >= 10)
		{
			this.AddSpeed_XY(0.00000000, 0.15000001);
		}

		this.subState();
	};
}

function SPShot_D( t )
{
	this.SetMotion(3039, 4);
	this.sx = this.sy = 0.10000000;
	this.owner.seals = true;
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_D_OpenSplash, {});
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.DrawActorPriority(179);
	this.func = [
		function ()
		{
			this.owner.seals = false;
			this.stateLabel = function ()
			{
				this.sx = this.sy += -this.sx * 0.20000000;
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
		if (this.count >= 70 || this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		if (this.count == 6)
		{
			this.flag2 = this.SetShotStencil(this.x, this.y, this.direction, this.SPShot_D_Tama, {}).weakref();
		}

		if (this.count % 9 == 1)
		{
			this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_D_Edge, {}));
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.20000000;
		this.flag1.Foreach(function ( s_ = this.sx )
		{
			this.flag2 = s_;
		});
		this.count++;
	};
}

function SPShot_D_Tama( t )
{
	if (this.owner.ball)
	{
		this.SetMotion(3038, 0);
	}
	else
	{
		this.SetMotion(3039, 0);
	}

	this.option = this.SetFreeObjectStencil(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(3039, 3);
		this.DrawActorPriority(180);
		this.anime.is_write = true;
	}, {}).weakref();
	this.anime.stencil = this.option;
	this.atk_id = 8388608;
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = null;
		}
	];
	this.keyAction = [
		function ()
		{
			if (this.owner.ball && this.motion == 3038)
			{
				local x_ = this.owner.ball.x - this.point0_x;
				local y_ = this.owner.ball.y - this.point0_y;

				if (x_ <= 75 && x_ >= -75 && y_ > 0 && y_ < 150)
				{
					this.owner.ball.func[2].call(this.owner.ball, this.direction);
				}
			}
			else if (this.motion == 3039)
			{
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D_Ball, {});
			}
		},
		function ()
		{
			this.stateLabel = null;
		},
		function ()
		{
			this.owner.seals = null;

			if (this.option)
			{
				this.option.ReleaseActor();
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SPShot_D_Ball( t )
{
	this.SetMotion(3037, 0);
	this.SetSpeed_XY(4.00000000 * this.direction, -18.00000000);
	this.cancelCount = 3;
	this.atk_id = 8388608;
	this.owner.ball = this.weakref();
	this.flag4 = ::manbow.Actor2DProcGroup();
	this.PlaySE(3065);
	this.func = [
		function ()
		{
			this.PlaySE(3068);
			this.callbackGroup = 0;
			this.SetSpeed_XY(-5.00000000 * this.direction, -6.00000000);
			this.owner.ball = null;
			this.stateLabel = function ()
			{
				this.alpha -= 0.05000000;
				this.sx = this.sy += (1.33000004 - this.sx) * 0.10000000;
				this.AddSpeed_XY(0.00000000, 0.30000001);
			};
		},
		function ()
		{
		},
		function ( dir_ )
		{
			this.direction = dir_;
			this.PlaySE(3065);
			this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashB, {});
			this.SetMotion(3037, 0);
			this.SetSpeed_XY(4.00000000 * this.direction, -18.00000000);
		}
	];
	this.stateLabel = function ()
	{
		if (this.x > 128 + ::battle.scroll_right || this.x < ::battle.scroll_left - 128 || this.y >= ::battle.scroll_bottom + 128 || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.owner.ball = null;
			this.ReleaseActor();
			return;
		}

		this.HitCycleUpdate(0);

		if (this.cancelCount <= 0 || this.hitCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 6.00000000 * 0.01745329;
		this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 0.66000003 : 0.25000000);

		if (this.keyTake == 0 && this.va.y > 0.00000000)
		{
			this.SetMotion(this.motion, 1);
		}
	};
}

function SPShot_E_Dragon( t )
{
	this.SetMotion(3048, 0);
	this.owner.dragon = true;
	this.DrawActorPriority(180);
	this.flag1 = 20 * 0.01745329;

	if (this.owner.centerStop <= -2 && this.owner.y < this.owner.centerY)
	{
		this.flag1 = 35 * 0.01745329;
	}

	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
			this.SetParent(null, 0, 0);
			this.SetMotion(3048, 5);
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(3048, 2);
		}
	];
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(3046);
			this.count = 0;
			local t_ = {};
			t_.rot <- this.flag1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_E, t_);
			this.stateLabel = function ()
			{
				if (this.owner.IsDamage())
				{
					this.func[0].call(this);
				}

				this.count++;

				if (this.count >= 60)
				{
					this.func[0].call(this);
				}
			};
		},
		null,
		function ()
		{
			this.owner.dragon = null;
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(3049, 0);
	local t_ = {};
	t_.rot <- t.rot;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(3049, 1);
		this.rz = t.rot;
		this.keyAction = this.ReleaseActor;
	}, t_);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 3;
	this.atk_id = 16777216;
	this.flag1 = 0.00000000;
	this.flag2 = 0;
	this.SetSpeed_Vec(27.50000000, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.PlaySE(3048);
			this.callbackGroup = 0;
			this.count = 0;
			this.SetSpeed_XY(0.00000000, -3.00000000);

			for( local i = 0; i < 360; i = i + (30 + this.rand() % 10) )
			{
				local t_ = {};
				t_.rot <- i * 0.01745329;
				this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_Splash, t_);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.25000000;
				this.count++;
				this.alpha = this.red = this.green -= 0.15000001;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};

			for( local i = 0; i < 2; i++ )
			{
				this.SetFreeObject(this.x, this.y, 1.00000000 - 2.00000000 * i, function ( t )
				{
					this.SetMotion(3049, 2);
					this.SetSpeed_XY(0.00000000, -3.00000000);
					this.rx = (45 + this.rand() % 30) * 0.01745329 * this.direction;
					this.ry = (45 + this.rand() % 30) * 0.01745329;
					this.flag1 = 2.20000005 + this.rand() % 12 * 0.10000000;
					this.stateLabel = function ()
					{
						this.sx = this.sy += (this.flag1 - this.sx) * 0.15000001;
						this.AddSpeed_XY(0.00000000, 0.30000001);
						this.alpha = this.red = this.green -= 0.07500000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}, {});
			}
		},
		function ()
		{
			for( local i = 0; i < 360; i = i + 36 )
			{
				local t_ = {};
				t_.rot <- i * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.SPShot_E_SprashShot, t_);
			}

			this.func[0].call(this);
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.grazeCount >= 10)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);
		this.sx = this.sy += 0.10000000;

		if (this.sx > 1.00000000)
		{
			this.sx = this.sy = 1.00000000;
		}

		if (this.sx >= 1.00000000)
		{
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		}

		this.AddSpeed_XY(0.00000000, 0.10000000);
		this.flag2 += 4;

		if (this.hitCount > 0 || this.flag2 >= 80)
		{
			this.func[1].call(this);
		}
	};
}

function SPShot_E_SprashShot( t )
{
	this.SetMotion(3049, 6);
	this.SetSpeed_Vec(8.00000000, t.rot, 1.00000000);
	this.SetSpeed_XY(null, this.va.y * 0.25000000 - 8.00000000);
	this.va.RotateByRadian(30 * 0.01745329);
	this.SetSpeed_XY(this.va.x * this.direction, null);
	this.AddSpeed_XY(8.00000000 * this.direction * 0.86600000, -8.00000000 * 0.50000000);
	this.cancelCount = 1;
	this.atk_id = 16777216;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.20000000;
				this.alpha = this.red = this.green -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 100 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.SetSpeed_XY(this.va.x * 0.97500002, this.va.y + 0.44999999);

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SPShot_E_RingSplash( t )
{
	this.SetMotion(3049, 5);
	this.sx = this.sy = 0.10000000;
	this.SetSpeed_XY(0.00000000, -10.00000000);
	this.flag1 = 1.00000000;
	this.stateLabel = function ()
	{
		local s_ = (1.50000000 - this.sx) * 0.12500000;

		if (s_ < 0.02000000)
		{
			s_ = 0.02000000;
		}

		this.sx += s_;
		this.sy = this.sx * this.flag1;
		this.flag1 += 0.10000000;
		this.count++;
		this.AddSpeed_XY(0.00000000, 0.75000000);

		if (this.count >= 8)
		{
			this.alpha = this.red = this.green -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_E_Splash( t )
{
	this.SetMotion(3049, 4);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.75000000 + this.rand() % 6 * 0.10000000;
	this.SetSpeed_Vec(15 + this.rand() % 6, t.rot, this.direction);
	this.SetSpeed_XY(null, this.va.y * 0.33000001);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.sx = this.sy += 0.05000000;
		this.alpha = this.red = this.green -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_A_Net( t )
{
	this.SetMotion(4008, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.atk_id = 67108864;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 64;
	this.anime.radius0 = 1;
	this.anime.vertex_alpha1 = 0.00000000;
	this.anime.vertex_blue1 = 0.80000001;
	this.anime.vertex_red1 = 0.80000001;
	this.anime.vertex_green1 = 0.80000001;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = 0.10000000;
	this.anime.radius1 = 128 * this.flag2;
	this.anime.length = 255 * this.flag2;
	this.SetCollisionRotation(0.00000000, 0.00000000, 45 * 0.01745329);
	this.SetCollisionScaling(this.flag2, this.flag2, 1.00000000);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetParent(null, 0, 0);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.flag1.Foreach(function ( s_ = this.sx )
				{
					this.sx = this.sy *= 0.94999999;
				});
				this.alpha -= 0.25000000;
				this.anime.top += 15;
				this.anime.radius0 *= 0.94999999;
				this.anime.radius1 *= 0.94999999;

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

		if (this.count % 6 == 1)
		{
			local t_ = {};
			t_.owner <- this.weakref();
			local a_ = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Spell_A_NetB, t_);
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
			this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Spell_A_NetHand, {});
		}

		this.flag1.Foreach(function ( s_ = this.sx )
		{
			this.sx = this.sy = this.flag1;
		});
		this.flag2 += (4.00000000 - this.flag2) * 0.10000000;
		this.anime.radius1 = 128 * this.flag2;
		this.anime.length = 255 * this.flag2;
		this.anime.top -= 10;

		if (this.hitCount <= 4)
		{
			this.HitCycleUpdate(5);
		}

		this.SetCollisionScaling(this.flag2, this.flag2, 1.00000000);

		if (this.count >= 15)
		{
		}
	};
}

function Spell_A_NetHand( t )
{
	this.SetMotion(4008, 1);
	this.SetParent(this.owner, 0, 0);
	this.ry = (50 + this.rand() % 41) * 0.01745329;
	this.rx -= (40 + this.rand() % 11) * 0.01745329 * this.direction;
	this.SetSpeed_Vec(1.50000000 + this.rand() % 16 * 0.10000000, 45 * 0.01745329, this.direction);
	this.sx = this.sy = 0.05000000;
	this.flag1 = 1.00000000 + this.rand() % 5 * 0.10000000;
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.97000003, this.va.y * 0.97000003);
		this.rz += -18 * 0.01745329;
		this.sx = this.sy += (this.flag1 - this.sx) * 0.20000000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_A_NetB( t )
{
	this.SetMotion(4008, 1);
	this.rz = this.rand() % 360 * 0.01745329;
	this.ry = (50 + this.rand() % 41) * 0.01745329;
	this.rx -= 45 * 0.01745329 * this.direction;
	this.flag1 = 0.25000000 + this.rand() % 75 * 0.01000000;
	this.flag2 = (15.00000000 + this.rand() % 120 * 0.10000000) * 0.01745329;
	this.x += 400 * this.flag1;
	this.y += 400 * this.flag1;
	this.SetParent(t.owner, this.x - t.owner.x, this.y - t.owner.y);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag1 += 0.10000000;
				this.rz += this.flag2 * 1.75000000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.SetSpeed_Vec(16.00000000 + this.rand() % 4, 45 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.97000003, this.va.y * 0.97000003);
		this.flag1 += 0.10000000;
		this.rz += this.flag2;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_A_CapNet( t )
{
	this.SetMotion(4008, 1);
	this.rz = this.rand() % 360 * 0.01745329;
	this.ry = (50 + this.rand() % 41) * 0.01745329;
	this.rx = (60 - this.rand() % 121) * 0.01745329;
	this.alpha = 0.00000000;
	this.sx = this.sy = 1.50000000 + this.rand() % 16 * 0.10000000;
	this.SetParent(this.owner.target, this.owner.target.x - this.x, this.owner.target.y - this.y);
	this.stateLabel = function ()
	{
		this.rz += 16.00000000 * 0.01745329;
		this.sx = this.sy *= 0.66000003;
		this.alpha += 0.33000001;

		if (this.sx <= 0.10000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_A_HitSpinEffect( t )
{
	this.SetMotion(4008, 2);
	this.DrawActorPriority(189);
	this.SetParent(this.owner, -64 * this.direction, -150);
	this.ry = 45 * 0.01745329;
	this.rx -= 50 * 0.01745329 * this.direction;
	this.sx = this.sy = 1.50000000 + this.rand() % 21 * 0.01745329;
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.97000003, this.va.y * 0.97000003);
		this.rz += -18 * 0.01745329;
		this.sx = this.sy += 0.02500000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_A_HitCapture( t )
{
	this.SetMotion(4008, 3);
	this.SetParent(this.owner.target, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.sx = this.sy = 1.50000000;
	this.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha == 1.00000000)
		{
			this.target.DamageGrab_Common(308, 0, this.direction);
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
	};
}

function SpellShot_B( t )
{
	this.SetMotion(4018, 2);
	this.cancelCount = 3;
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.rz = -50 * 0.01745329;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.FitBoxfromSprite();
	this.keyAction = function ()
	{
		this.func[0].call(this);
	};
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 4010)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (3.50000000 - this.sx) * 0.25000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.count++;

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(0);
		}

		if (this.count >= 10)
		{
			this.SetParent(null, 0, 0);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx += 0.05000000;
				this.sy *= 0.89999998;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B_Shock( t )
{
	this.SetMotion(4018, this.rand() % 2);
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (4.00000000 - this.sx) * 0.25000000;

		if (this.sx > 3.75000000)
		{
			this.stateLabel = function ()
			{
				this.sy *= 0.80000001;
				this.sx *= 1.10000002;
				this.alpha = this.red = this.green -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B_Aura( t )
{
	this.SetMotion(7021, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.alpha = 0.00000000;
	this.flag1 = ::actor[t.name].weakref();
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0.05000000;
			this.alpha = this.green = this.red -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.subState = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.alpha = this.green = this.red -= 0.05000000;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0.05000000;

		if (this.flag1)
		{
			this.Warp(this.flag1.x, this.flag1.y);
		}
		else
		{
			this.func();
		}
	};
}

function SpellShot_B_AuraB( t )
{
	this.SetMotion(7021, 1);
	this.rz = this.rand() % 360 * 0.01745329;
	this.alpha = 0.00000000;
	this.flag1 = ::actor[t.name].weakref();
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.rz -= 2.50000000 * 0.01745329;
			this.sx = this.sy += 0.01000000;
			this.alpha = this.green = this.red -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.subState = function ()
	{
		this.alpha += 0.25000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.alpha = this.green = this.red -= 0.02500000;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
			return;
		}

		this.rz -= 2.50000000 * 0.01745329;
		this.sx = this.sy += 0.01000000;

		if (this.flag1)
		{
			this.Warp(this.flag1.x, this.flag1.y);
		}
		else
		{
			this.func();
		}
	};
}

function SpellShot_B_AuraC( t )
{
	this.SetMotion(7021, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.alpha = 0.00000000;
	this.flag1 = ::actor[t.name].weakref();
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0.05000000;
			this.alpha = this.green = this.red -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.subState = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.alpha = this.green = this.red -= 0.05000000;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0.10000000;

		if (this.flag1)
		{
			this.Warp(this.flag1.x, this.flag1.y);
		}
		else
		{
			this.func();
		}
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 0);
	this.sx = this.sy = 0.00000000;
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.SetMotion(4029, 0);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.sx = this.sy = 0.10000000;
			this.SetMotion(4029, 1);
			this.SetParent(null, 0, 0);
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_Wave, {});
					a_.SetParent(this, 0, 0);
				}

				this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.VX_Brake(0.75000000);
				this.count++;
				this.HitCycleUpdate(4);

				if (this.count == 40)
				{
					this.func[2].call(this);
				}
			};
		},
		function ()
		{
			this.PlaySE(3076);
			this.HitReset();
			this.sx = this.sy = 3.00000000;
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_Flash, {});
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_FlashB, {});
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_Splash, {});
			this.SetShot(this.x, this.y, this.direction, this.SpellC_Marker, {});
			this.SetMotion(4029, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.50000000;
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
		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
		this.count++;
	};
}

function SpellShot_C_Splash( t )
{
	this.SetMotion(4029, 6);
	this.stateLabel = function ()
	{
		this.flag1 = (3.50000000 - this.sx) * 0.10000000;

		if (this.flag1 < 0.01500000)
		{
			this.flag1 = 0.01500000;
		}

		this.sx = this.sy += this.flag1;
		this.count++;

		if (this.count >= 10)
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_C_Wave( t )
{
	this.SetMotion(4029, 4);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.33000001;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.25000000;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_C_Flash( t )
{
	this.SetMotion(4029, 5);
	this.DrawActorPriority(180);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_C_FlashB( t )
{
	this.SetMotion(4029, 4);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.50000000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellC_Marker( t )
{
	this.SetMotion(4028, 1);
	this.flag1 = ::manbow.Actor2DProcGroup();

	if (this.owner.mark.len() > 0)
	{
		foreach( a in this.owner.mark )
		{
			if (a)
			{
				a.func[0].call(a);
			}
		}
	}

	local a_ = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_Charge_EffectAura, {});
	a_.SetParent(this, 0, 0);
	this.flag1.Add(a_);
	this.flag5 = {};
	this.flag5.count <- 0;
	this.flag5.actor <- ::manbow.Actor2DProcGroup();
	local pos_ = this.Vector3();
	pos_.x = 125.00000000;

	for( local i = 0; i < 3; i++ )
	{
		local t_ = {};
		t_.pos <- this.Vector3();
		t_.pos.x = pos_.x;
		t_.pos.y = pos_.y;
		t_.num <- i;
		this.flag5.actor.Add(this.SetFreeObject(this.x, this.y, this.direction, this.SpellC_MarkerCount, t_));
		pos_.RotateByRadian(120 * 0.01745329);
	}

	this.owner.mark = [];
	this.owner.mark.append(this.weakref());
	this.count = 0;
	this.sx = this.sy = 4.00000000;
	this.keyAction = function ()
	{
		this.DrawActorPriority(180);
	};
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag5.actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.SetMotion(4028, 0);
			this.ResetSpeed();
			this.sx = this.sy = 3.00000000;

			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			foreach( val, a in this.owner.mark )
			{
				if (a && a == this)
				{
					this.flag4++;

					if (this.flag4 >= 3)
					{
						this.owner.mark.remove(val);
					}

					break;
				}
			}

			this.flag5.actor.Foreach(function ( num_ = this.flag4 )
			{
				if (this.initTable.num < num_)
				{
					this.func[0].call(this);
				}
			});
			this.func[2].call(this);

			if (this.flag4 >= 3)
			{
				this.func[0].call(this);
			}
		},
		function ()
		{
			this.PlaySE(3078);
			this.sx = this.sy = 4.00000000;
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_FlashB, {});

			for( local i = 0; i < 20; i++ )
			{
				local t_ = {};
				t_.v <- 4.00000000;
				t_.rot <- i * 18 * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeMini, t_);
			}
		}
	];
	this.stateLabel = function ()
	{
		this.flag5.actor.Foreach(function ( a = this )
		{
			this.x += (a.x - (this.x + this.initTable.pos.x * this.direction)) * 0.10000000;
			this.y += (a.y - (this.y + this.initTable.pos.y)) * 0.10000000;
		});
		this.rz -= 0.25000000 * 0.01745329;
		this.count++;

		if (this.count % 4 == 1)
		{
			local a_ = this.SetFreeObject(this.x + 100 - this.rand() % 201, this.y + 100 - this.rand() % 201, this.direction, this.Shot_ChargeParticle, {}, this.weakref());
			a_.SetParent(this, a_.x - this.x, a_.y - this.y);
			this.flag1.Add(a_);
		}

		if (this.count % 30 == 1)
		{
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Charge_EffectRing, {});
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
	};
}

function SpellC_MarkerCount( t )
{
	this.SetMotion(4028, 0);
	this.func = [
		function ()
		{
			this.sx = this.sy = 2.00000000;
			this.stateLabel = function ()
			{
				this.initTable.pos.RotateByDegree(2.00000000);
				this.sx = this.sy *= 0.80000001;

				if (this.sx <= 0.01000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.initTable.pos.RotateByDegree(2.00000000);
	};
}

function Climax_VortexA( t )
{
	this.SetMotion(4907, this.rand() % 3);
	this.rx = 5 * 0.01745329;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 48;
	this.anime.radius0 = 64 + this.rand() % 96;
	this.anime.radius1 = this.anime.radius0 + this.rand() % 32;
	this.anime.length = 1;
	this.alpha = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = (70 + this.rand() % 5) * 0.01745329;
	this.ry = (-25 - this.rand() % 25) * 0.01745329 * this.direction;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, -0.10000000);
				this.rz += 24.00000000 * 0.01745329;
				this.anime.radius0 += 1.39999998;
				this.anime.radius1 += (this.anime.radius0 - this.anime.radius1) * 0.10000000;
				this.anime.length *= 0.50000000;
				this.alpha -= 0.05000000;
				this.red = this.green = this.blue -= 0.00500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.alpha < 1.00000000)
		{
			this.alpha += 0.10000000;
		}

		this.AddSpeed_XY(0.00000000, -0.50000000);
		this.rz += 12.00000000 * 0.01745329;
		this.anime.radius0 += 40.00000000;
		this.anime.radius1 += 1.10000002;
		this.anime.length += (128 - this.anime.length) * 0.10000000;
		this.count++;

		if (this.count >= 10)
		{
			this.func[0].call(this);
		}
	};
}

function Climax_VortexB( t )
{
	this.SetMotion(4907, 1);
	this.rx = 5 * 0.01745329;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 0;
	this.anime.radius0 = 256 + this.rand() % 32;
	this.anime.radius1 = 392 + this.rand() % 128;
	this.anime.length = 64;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = -70 * 0.01745329 * this.direction;
	this.ry = 60 * 0.01745329;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.rz -= 12.00000000 * 0.01745329;
				this.anime.height += (256 - this.anime.height) * 0.05000000;
				this.anime.radius0 *= 0.98000002;
				this.anime.radius1 *= 0.97000003;
				this.anime.length *= 1.04999995;
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
		this.AddSpeed_XY(0.00000000, -0.25000000);
		this.rz -= 6.00000000 * 0.01745329;
		this.anime.height += (256 - this.anime.height) * 0.05000000;
		this.anime.radius0 *= 0.98000002;
		this.anime.radius1 *= 0.98000002;
		this.anime.length *= 0.99000001;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_VortexC( t )
{
	this.SetMotion(4907, 3);
	this.atkRate_Pat = t.rate;
	this.atk_id = 134217728;
	this.cancelCount = 99;
	this.func = [
		function ()
		{
			this.SetMotion(4907, 5);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.00000000 - this.sx) * 0.15000001;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2.00000000 - this.sx) * 0.15000001;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.HitCycleUpdate(15);
	};
}

function Climax_Arm( t )
{
	this.SetMotion(4908, 0);
	this.SetSpeed_XY(0.00000000, -6.00000000);
	this.rz = -480 * 0.01745329;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, this.va.y <= 0.25000000 ? 0.50000000 : 0.00500000);
		local r_ = -this.rz * 0.10000000;
		r_ = this.Math_MinMax(r_, 23.00000000 * 0.01745329, 35.00000000 * 0.01745329);
		this.rz += r_;
	};
}

function Climax_FaceA( t )
{
	this.EnableTimeStop(false);
	this.flag1 = this.Vector3();
	this.SetMotion(4909, 1);
	this.GetPoint(0, this.flag1);
	this.flag2 = this.SetFreeObject(this.flag1.x, this.flag1.y, this.direction, this.Climax_ArmA, {}).weakref();
	this.stateLabel = function ()
	{
		this.GetPoint(0, this.flag1);

		if (this.flag2)
		{
			this.flag2.x = this.flag1.x;
			this.flag2.y = this.flag1.y;
		}
	};
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.ReleaseActor();
			}

			this.SetMotion(4909, 2);
			this.stateLabel = function ()
			{
				this.GetPoint(0, this.flag1);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.GetPoint(0, this.flag1);
			};
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_ArmA( t )
{
	this.SetMotion(4909, 3);
	this.EnableTimeStop(false);
	this.stateLabel = function ()
	{
		this.rz -= 0.05000000 * 0.01745329;
		this.sx = this.sy -= 0.00050000;
	};
}

function Spell_Climax_BackA( t )
{
	this.SetMotion(4909, 4);
	this.DrawActorPriority(490);
	this.EnableTimeStop(false);
}

function Spell_Climax_BackB( t )
{
	this.SetMotion(4908, 3);
	this.DrawActorPriority(490);
	this.EnableTimeStop(false);
}

function Climax_FaceB( t )
{
	this.SetMotion(4908, 1);
	this.DrawActorPriority(505);
	this.EnableTimeStop(false);
	this.stateLabel = function ()
	{
	};
	this.func = [
		function ()
		{
			this.PlaySE(3055);
			this.flag4 = this.SetFreeObject(this.point0_x, this.point0_y, 1.00000000, this.Climax_FaceB_Light, {}).weakref();
			this.flag4.SetParent(this, this.flag4.x - this.x, this.flag4.y - this.y);
		},
		function ()
		{
			this.PlaySE(3056);

			if (this.flag4)
			{
				this.flag4.func[1].call(this.flag4);
			}

			this.FadeIn(1.00000000, 1.00000000, 1.00000000, 30);
		},
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.ReleaseActor();
		}
	];
}

function Climax_FaceB_Light( t )
{
	this.SetMotion(4908, 6);
	this.alpha = 0.00000000;
	this.DrawActorPriority(510);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.01000000;
		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.count++;

		if (this.count == 60)
		{
			local t_ = {};
			t_.take <- 7;
			t_.rot <- 60 * 0.01745329;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_FaceB_LightBar, t_);
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
		}

		if (this.count == 70)
		{
			local t_ = {};
			t_.take <- 9;
			t_.rot <- 180 * 0.01745329;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_FaceB_LightBar, t_);
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
		}

		if (this.count == 78)
		{
			local t_ = {};
			t_.take <- 7;
			t_.rot <- 300 * 0.01745329;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_FaceB_LightBar, t_);
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
		}

		if (this.count == 90)
		{
			local t_ = {};
			t_.take <- 9;
			t_.rot <- 360 * 0.01745329;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_FaceB_LightBar, t_);
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
		}
	};
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		},
		function ()
		{
			this.alpha = 1.00000000;
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag1.Clear();
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_FaceB_LightVortex, {});
			a_.SetParent(this, 0, 0);
			this.flag1.Add(a_);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.25000000;
			};
		}
	];
}

function Climax_FaceB_LightBar( t )
{
	this.SetMotion(4908, t.take);
	this.DrawActorPriority(509);
	this.sx = 1.50000000;
	this.sy = 0.75000000 + this.rand() % 5 * 0.10000000;
	this.rz = t.rot;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0.50000000 * 0.01745329;
	};
}

function Climax_FaceB_LightVortex( t )
{
	this.SetMotion(4908, 11);
	this.DrawActorPriority(509);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.flag1 = 1.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.flag1 += 0.25000000;
		this.rz += this.flag1 * 0.01745329;
	};
}

function Climax_FinishArm( t )
{
	this.SetMotion(4908, 4);
	this.DrawActorPriority(499);
	this.PlaySE(3057);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(3058);
			this.SetMotion(4908, 12);
		}
	];
}

