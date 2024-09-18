function Shot_Normal( t )
{
	this.SetMotion(2009, this.initTable.type);
	this.atk_id = 16384;
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.SetSpeed_XY(t.vx, t.vy);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, this.initTable.type);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.alpha = this.red = this.green = this.blue -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(2009, this.initTable.type + 1);
			this.SetSpeed_Vec(this.initTable.v, this.initTable.rot, this.direction);
			this.flag1 = this.va.y < 0.00000000 ? -0.20000000 : 0.20000000;
			this.stateLabel = function ()
			{
				if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
				{
					this.ReleaseActor();
					return true;
				}

				this.subState();
				this.AddSpeed_Vec(0.25000000, null, 20.00000000, this.direction);
			};
		}
	];
	this.subState = function ()
	{
		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.hitResult & 8)
		{
			this.func[0].call(this);
			return true;
		}

		local r_ = this.atan2(this.vy, this.vx * this.direction);
		this.rz += (r_ - this.rz) * 0.33000001;
		return false;
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.subState();
	};
}

function Shot_Normal_Trail( t )
{
	this.DrawActorPriority(190);
	this.SetMotion(2009, 1);
	this.rz = t.rot;
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.alpha = this.green = this.blue -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.atk_id = 65536;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.count >= 10 || this.Damage_ConvertOP(this.x, this.y, 8))
				{
					this.ReleaseActor();
					return true;
				}

				this.count++;

				if (this.count % 4 == 1)
				{
					this.SetShot(this.owner.target.x + 75 - this.rand() % 150, this.owner.target.y + 75 - this.rand() % 150, this.direction, this.Shot_FrontExp, {}, this.weakref());
				}
			};
		}
	];
	this.SetSpeed_XY(35.00000000 * this.direction, -2.00000000);
	this.stateLabel = function ()
	{
		if (this.va.x > 0.00000000 && this.x > ::battle.scroll_right + 200 || this.va.x < 0.00000000 && this.x < ::battle.scroll_left - 200 || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.ReleaseActor();
			return true;
		}

		this.AddSpeed_XY(0.00000000, -0.25000000);

		if (this.flag2)
		{
			this.func[1].call(this);
			return;
		}

		this.count++;

		if (this.count % 2 == 1)
		{
			this.SetShot(this.x, this.y, this.direction, this.Shot_FrontExp, {}, this.weakref());
		}

		if (this.count >= 45)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_FrontExp( t )
{
	this.SetMotion(2019, 1);
	this.atk_id = 65536;
	this.sx = this.sy = 0.50000000;
	this.flag1 = 1.25000000 + this.rand() % 75 * 0.01000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetTaskAddRotation(0.00000000, 0.00000000, (-2.00000000 + this.rand() % 41) * 0.10000000 * 0.01745329);
	this.cancelCount = 1;
	this.keyAction = [
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, -0.50000000);
				this.sx = this.sy += (this.flag1 - this.sx) * 0.20000000;
				this.alpha = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0.20000000;

		if (this.hitCount > 0 && this.initTable.pare)
		{
			this.initTable.pare.flag2 = true;
		}
	};
}

function Shot_Barrage_Effect( t )
{
	this.SetMotion(2026, 12);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (12.00000000 - this.sx) * 0.10000000;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, this.initTable.type);
	this.atk_id = 262144;
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_XY(0.00000000, -12.00000000);
	this.cancelCount = 1;
	this.alpha = 0.00000000;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.initTable.type + 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.alpha = this.red = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[1] = function ()
			{
			};
		},
		function ()
		{
			this.flag2.x = this.x - this.owner.x;
			this.flag2.y = this.y - this.owner.y;
			this.count = 0;
			this.flag2.SetLength(0.25000000);
			this.subState = function ()
			{
				this.count--;
				this.VY_Brake(0.25000000);

				if (this.count <= 0)
				{
					this.count = 0;
					this.SetMotion(this.motion, this.initTable.type + 1);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.flag1 = (40 - this.rand() % 81) * 0.10000000 * 0.01745329;
					this.subState = function ()
					{
						if (this.IsScreen(100))
						{
							this.ReleaseActor();
							return;
						}

						this.rz += this.flag1;
						this.count++;

						if (this.count <= 60)
						{
							this.AddSpeed_XY(this.flag2.x, this.flag2.y);
						}
					};
				}
			};
		}
	];
	this.subState = function ()
	{
		this.VY_Brake(0.25000000, -0.20000000);
		this.count++;
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 150)
		{
			this.func[0].call(this);
			return true;
		}

		this.alpha += 0.10000000;
		this.subState();
	};
}

function Shot_ChargeRing( t )
{
	this.SetMotion(2029, 1);
	this.flag4 = 0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.10000000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(2029, 3);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.alpha = 1.00000000;
			local t_ = {};
			t_.scale <- 1.50000000;
			this.SetShot(this.x, this.y, this.direction, this.Shot_ChargeRingHit, t_);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.25000000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.alpha = 0.00000000;
			this.sx = this.sy = 1.50000000;
			this.stateLabel = function ()
			{
				if (this.owner.input.x == 0)
				{
					this.SetSpeed_XY(0.00000000, null);
				}
				else
				{
					this.SetSpeed_XY(this.owner.input.x > 0 ? 10.00000000 : -10.00000000, null);
				}

				if (this.owner.input.y == 0)
				{
					this.SetSpeed_XY(null, 0.00000000);
				}
				else
				{
					this.SetSpeed_XY(null, this.owner.input.y > 0 ? 10.00000000 : -10.00000000);
				}

				this.sx = this.sy += 0.02000000;
				this.alpha += 0.20000000;

				if (this.alpha >= 1.00000000)
				{
					this.stateLabel = function ()
					{
						if (this.owner.input.x == 0)
						{
							this.SetSpeed_XY(0.00000000, null);
						}
						else
						{
							this.SetSpeed_XY(this.owner.input.x > 0 ? 10.00000000 : -10.00000000, null);
						}

						if (this.owner.input.y == 0)
						{
							this.SetSpeed_XY(null, 0.00000000);
						}
						else
						{
							this.SetSpeed_XY(null, this.owner.input.y > 0 ? 10.00000000 : -10.00000000);
						}

						this.sx = this.sy += 0.02000000;
						this.alpha -= 0.02500000;

						if (this.alpha <= 0.00000000)
						{
							this.func[2].call(this);
						}
					};
				}
			};
		},
		function ()
		{
			this.SetMotion(2029, 3);
			this.alpha = 1.00000000;
			this.sx = this.sy = 1.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetShot(this.x, this.y, this.direction, this.Shot_FullChargeRingHit, {});
			this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Shot_ChargeFlash, {});
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.50000000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					if (this.flag4 < 6)
					{
						this.flag4++;
						this.alpha = 1.00000000;
						this.sx = this.sy = 1.00000000;
						this.SetShot(this.x, this.y, this.direction, this.Shot_FullChargeRingHit, {});
					}
					else
					{
						this.ReleaseActor();
					}
				}
			};
		}
	];
	this.func[2].call(this);
}

function Shot_ChargeRingHit( t )
{
	this.SetMotion(2029, 2);
	this.atk_id = 131072;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.75000000;
	};
}

function Shot_FullChargeRingHit( t )
{
	this.SetMotion(2029, 4);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 1.25000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	};
}

function Shot_ChargeFlash( t )
{
	this.SetMotion(2029, 5);
	this.anime.vertex_alpha1 = 0.00000000;
	this.stateLabel = function ()
	{
		this.anime.top -= 40.00000000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Doppel_Damage( life_ )
{
	if (life_ - this.life > 0)
	{
		local d_ = life_ - this.life;

		if (d_ > life_)
		{
			d_ = life_;
		}

		if (this.team.life < d_)
		{
			this.team.life = 1;
		}
		else
		{
			this.team.life -= d_;
		}
	}
}

function Shot_OkultDoppel_Damage( t )
{
	this.SetMotion(2509, 0);
	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.count = 0;
	this.Doppel_Damage(t);
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
		this.count++;

		if (this.count >= 20)
		{
			this.sx *= 0.89999998;
			this.sy *= 1.04999995;
			this.SetSpeed_XY(0.00000000, -10 * this.sy);
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Shot_OkultDoppel_A( t )
{
	this.SetMotion(2507, 0);
	this.atk_id = 524288;
	this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
	this.life = 1000;
	this.red = this.green = this.blue = 0.66000003;
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage() || this.life <= 0)
		{
			this.Shot_OkultDoppel_Damage(1000);
			return;
		}

		this.subState();
	};
	this.subState = function ()
	{
		this.VX_Brake(0.25000000, 6.00000000 * this.direction);

		if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
		{
			this.SetSpeed_XY(0.00000000, this.va.y);
		}
	};
	this.keyAction = [
		function ()
		{
			this.subState = function ()
			{
				if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
				{
					this.SetSpeed_XY(0.00000000, this.va.y);
				}

				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.PlaySE(3694);
			this.subState = function ()
			{
				if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
				{
					this.SetSpeed_XY(0.00000000, this.va.y);
				}

				this.VX_Brake(0.75000000);
			};
		},
		null,
		function ()
		{
			this.Doppel_Damage(1000);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 1.04999995;
				this.SetSpeed_XY(0.00000000, -10 * this.sy);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function Shot_OkultDoppel_B( t )
{
	this.SetMotion(2506, 0);
	this.SetSpeed_XY(-7.50000000 * this.direction, -2.00000000);
	this.life = 1000;
	this.red = this.green = this.blue = 0.66000003;
	this.flag1 = 0;
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage() || this.life <= 0)
		{
			this.Shot_OkultDoppel_Damage(1000);
			return;
		}

		this.subState();
	};
	this.subState = function ()
	{
		if (this.y >= this.owner.centerY)
		{
			this.SetSpeed_XY(this.va.x, 0.00000000);
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(this.va.x * this.direction < -2.50000000 ? 0.20000000 : 0.01000000);
			this.AddSpeed_XY(0.00000000, 0.10000000, null, 1.00000000);
		}

		if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
		{
			this.SetSpeed_XY(0.00000000, this.va.y);
		}
	};
	this.keyAction = [
		function ()
		{
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
		null,
		function ()
		{
			if (this.flag1 >= 1)
			{
				this.SetMotion(2506, 5);
				this.Doppel_Damage(1000);
				this.SetSpeed_XY(0.00000000, 0.00000000);
				this.stateLabel = function ()
				{
					this.sx *= 0.89999998;
					this.sy *= 1.04999995;
					this.SetSpeed_XY(0.00000000, -10 * this.sy);
					this.alpha -= 0.05000000;

					if (this.alpha <= 0.00000000)
					{
						this.ReleaseActor();
					}
				};
				return;
			}
		},
		function ()
		{
			this.SetMotion(2506, 1);
			this.flag1++;
		}
	];
}

function Shot_OkultDoppel_C( t )
{
	this.SetMotion(2505, 0);
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
	this.life = 1000;
	this.red = this.green = this.blue = 0.66000003;
	this.flag1 = 0;
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage() || this.life <= 0)
		{
			this.Shot_OkultDoppel_Damage(1000);
			return;
		}

		this.subState();
	};
	this.subState = function ()
	{
		this.VX_Brake(0.50000000);

		if (this.y <= this.owner.centerY)
		{
			this.SetSpeed_XY(this.va.x, 0.00000000);
		}
		else
		{
			this.AddSpeed_XY(0.00000000, -0.10000000, null, -1.00000000);
		}

		if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
		{
			this.SetSpeed_XY(0.00000000, this.va.y);
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			::camera.shake_radius = 2.00000000;
			this.PlaySE(3627);
			this.SetShot(this.x + 200 * this.direction, ::battle.scroll_bottom, this.direction, this.SPShot_C, {});
			this.subState = function ()
			{
				this.VX_Brake(0.50000000);

				if (this.y <= this.owner.centerY)
				{
					this.SetSpeed_XY(this.va.x, 0.00000000);
				}
				else
				{
					this.AddSpeed_XY(0.00000000, -0.10000000, null, -1.00000000);
				}

				if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
				{
					this.SetSpeed_XY(0.00000000, this.va.y);
				}

				this.count++;

				if (this.count == 80)
				{
					::camera.shake_radius = 2.00000000;
					this.PlaySE(3627);
					this.SetShot(this.x + 400 * this.direction, ::battle.scroll_bottom, this.direction, this.SPShot_C, {});
				}

				if (this.count == 180)
				{
					this.SetMotion(this.motion, 4);
				}
			};
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
		},
		function ()
		{
			this.Doppel_Damage(1000);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 1.04999995;
				this.SetSpeed_XY(0.00000000, -10 * this.sy);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	return true;
}

function Shot_Okult( t )
{
	this.SetMotion(2508, 5);
	this.anime.is_write = true;
	this.sx = this.sy = 0.00000000;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Okult_Slash, {});
	this.DrawActorPriority(180);
	this.flag2 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.Occult_Back, {}).weakref();
	this.flag2.anime.stencil = this;
	this.flag3 = this.SetShotStencil(this.x, this.y, this.direction, this.Shot_OkultMask, {});
	this.stateLabel = function ()
	{
		this.count++;
		this.sx += (1.00000000 - this.sx) * 0.05000000;
		this.sy += (1.00000000 - this.sy) * 0.15000001;

		if (this.count == 4)
		{
			local t_ = {};
			t_.mask <- this.flag3;
			this.flag1 = this.SetShotStencil(this.x - 160 * this.direction, this.y, this.direction, this.Shot_OkultGhost, t_).weakref();
		}

		if (this.count == 40)
		{
			this.func();
		}
	};
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.stateLabel = function ()
		{
			this.sx *= 0.89999998;
			this.sy *= 0.98000002;

			if (this.sx <= 0.01000000)
			{
				this.ReleaseActor.call(this.flag3);
				this.ReleaseActor.call(this.flag2);
				this.ReleaseActor();
			}
		};
	};
}

function Shot_OkultB( t )
{
	this.SetMotion(2508, 5);
	this.anime.is_write = true;
	this.sx = this.sy = 0.00000000;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Okult_Slash, {});
	this.DrawActorPriority(180);
	this.flag2 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.Occult_Back, {}).weakref();
	this.flag2.anime.stencil = this;
	this.flag3 = this.SetShotStencil(this.x, this.y, this.direction, this.Shot_OkultMask, {});

	for( local i = -24; i <= 24; i = i + 12 )
	{
		local t_ = {};
		t_.rot <- i * 0.01745329;
		t_.mask <- this.flag3;
		this.SetShotStencil(this.x - 180 * this.direction, this.y, this.direction, this.Shot_OkultSotoba, t_);
	}

	this.stateLabel = function ()
	{
		this.count++;
		this.sx += (1.00000000 - this.sx) * 0.05000000;
		this.sy += (1.00000000 - this.sy) * 0.15000001;

		if (this.count == 20)
		{
			this.PlaySE(1075);
		}

		if (this.count == 40)
		{
			this.func();
		}
	};
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx *= 0.89999998;
			this.sy *= 0.98000002;

			if (this.sx <= 0.01000000)
			{
				this.ReleaseActor.call(this.flag3);
				this.ReleaseActor.call(this.flag2);
				this.ReleaseActor();
			}
		};
	};
}

function Shot_OkultMask( t )
{
	this.SetMotion(2508, 4);
	this.DrawActorPriority(180);
	this.anime.is_write = true;
}

function Shot_OkultCollectLight( t )
{
	this.SetMotion(2509, 6);
	this.DrawActorPriority(t.priority);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 3.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.50000000;

		if (this.sx <= 0.02500000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_OkultCollectBallAura( t )
{
	this.SetMotion(2509, 1);
	this.alpha = 0.00000000;
	this.func = [
		function ()
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
	];
	this.stateLabel = function ()
	{
		this.alpha -= 0.10000000;
	};
}

function Shot_OkultCoreLight( t )
{
	this.SetMotion(2509, 3);
	this.DrawActorPriority(201);
	this.sx = this.sy = 0.01000000;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultCoreLightB, {}).weakref();
	this.SetParent.call(this.flag1, this, 0, 0);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

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
			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.40000001;
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
		this.sx = this.sy += 0.05000000;
	};
}

function Shot_OkultCoreLightB( t )
{
	this.SetMotion(2509, 4);
	this.DrawActorPriority(179);
	this.sx = this.sy = 1.00000000;
	this.alpha = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02500000;
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
				this.sx = this.sy += 0.10000000;
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
		this.alpha += 0.05000000;
		this.sx = this.sy += 0.05000000;
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 1 + this.rand() % 5 * 2);
	this.atk_id = 536870912;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(10.00000000, this.rz, this.direction);
	this.flag1 = this.keyTake;
	this.flag2 = this.Vector3();
	this.flag2.x = this.owner.target.x;
	this.flag2.y = this.owner.target.y;
	this.cancelCount = 1;
	this.SetTrail(3929, 11);
	this.func = [
		function ()
		{
			if (this.linkObject[0])
			{
				this.linkObject[0].ReleaseActor();
			}

			this.keyAction = this.ReleaseActor;
			this.SetMotion(this.motion, this.flag1 - 1);
			this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.25000000);
				this.alpha = this.red = this.green = this.blue -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag2.x = this.owner.target.x;
			this.flag2.y = this.owner.target.y;
			this.flag3 = 0.01745329;
			this.count = 0;
			this.subState = function ()
			{
				this.flag3 += 0.10000000 * 0.01745329;
				this.count++;

				if (this.PosHoming(this.flag2, this.flag3, this.direction) || this.count >= 45)
				{
					this.subState = function ()
					{
						this.AddSpeed_Vec(0.50000000, null, 15.00000000, this.direction);
					};
					return;
				}

				this.rz = this.atan2(this.va.y, this.va.x * this.direction);
				this.AddSpeed_Vec(0.50000000, null, 12.50000000, this.direction);
			};
		}
	];
	this.subState = function ()
	{
		this.PosHoming(this.flag2, 0.75000000 * 0.01745329, this.direction);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.Vec_Brake(0.40000001, 3.00000000))
		{
			this.subState = function ()
			{
				this.PosHoming(this.flag2, 1.25000000 * 0.01745329, this.direction);
				this.rz = this.atan2(this.va.y, this.va.x * this.direction);
				this.count++;

				if (this.count == this.initTable.wait)
				{
					this.func[1].call(this);
				}
			};
		}
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
			this.func[0].call(this);
			return true;
		}

		this.subState();
	};
}

function SPShot_B( t )
{
	this.SetMotion(3019, 0);
	this.atk_id = 2097152;
	this.cancelCount = 1;
	this.rz = t.rot;
	this.SetSpeed_Vec(8.00000000, t.rot, this.direction);
	this.SetTrail(3019, 1, 15, 30);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SPShot_C( t )
{
	if (this.x < 100 && this.direction == -1.00000000 || this.x > 1180 && this.direction == 1.00000000)
	{
		this.x = 640 + 540 * this.direction;
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(3628);
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP(this.x, this.y, 6))
				{
					this.func[0].call(this);
					return;
				}

				this.count++;

				if (this.count <= 20 && this.count % 5 == 1)
				{
					this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Splash, {});
				}

				if (this.count == 50)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 6))
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count == 20)
		{
			this.func[1].call(this);
		}
	};
	this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Hole, {});
}

function SPShot_C_Hole( t )
{
	this.SetMotion(3029, 0);
	this.atk_id = 4194304;
	this.cancelCount = 3;
	this.SetSpeed_Vec(35.00000000, -70 * 0.01745329, this.direction);
	this.flag1 = -35 * 0.01745329;
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0.94999999;
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.subState();
				this.SetSpeed_XY(this.va.x * 0.89999998, this.va.y * 0.89999998);
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.alpha = this.red = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();

		if (this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 6))
		{
			this.func[0].call(this);
			return;
		}

		this.Vec_Brake(1.00000000, 1.50000000);
		this.count++;

		if (this.count == 20)
		{
			this.callbackGroup = 0;
			this.SetMotion(3029, 3);
		}

		if (this.count >= 50)
		{
			this.stateLabel = function ()
			{
				this.subState();
				this.AddSpeed_XY(0.00000000, 0.75000000);

				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_C_Splash( t )
{
	this.SetMotion(3029, 1);
	this.atk_id = 4194304;
	this.rz = 20 * 0.01745329;
	this.rz += (-2 + this.rand() % 5) * 0.01745329;
	this.sx -= (20 - this.rand() % 41) * 0.01000000;
	this.SetSpeed_Vec(60.00000000, -70 * 0.01745329, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, 20 * 0.01745329);
	this.cancelCount = 1;

	if (this.rand() % 100 <= 50)
	{
		this.sx = -this.sx;
	}

	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(2.00000000, 1.50000000))
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0.00000000, 0.50000000);
						this.sx *= 1.00999999;
						this.alpha = this.red = this.green -= 0.05000000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}

				this.alpha -= 0.10000000;
				this.sx *= 0.92000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		if (this.Vec_Brake(2.00000000, 1.50000000))
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.sx *= 1.00999999;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_D( t )
{
	this.SetMotion(3039, t.type * 2);
	this.atk_id = 8388608;
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag1 = {};
	this.flag1.pos <- this.Vector3();
	this.flag1.pos.x = 1.00000000;
	this.flag1.pos.RotateByDegree(this.owner.skillD_pos[t.pos].z);
	this.flag1.r <- this.owner.skillD_pos[t.pos].x;
	this.flag1.y <- this.owner.skillD_pos[t.pos].y;
	this.flag2 = 300;
	this.flag3 = 12.00000000;
	this.alpha = this.red = this.green = this.blue = 0.00000000;
	this.cancelCount = 1;
	this.subState = function ()
	{
		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
			};
		}
		else
		{
			this.alpha = this.red = this.green = this.blue += 0.10000000;
		}
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.flag1 = 0.30000001 + this.rand() % 4 * 0.10000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.flag1);
				this.alpha = this.red = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( charge_ )
		{
			this.alpha = this.red = this.green = this.blue = 1.00000000;
			this.SetMotion(this.motion, this.keyTake + 1);
			this.HitReset();
			this.cancelCount = 1;
			this.hitCount = 0;
			this.grazeCount = 0;
			this.flag1.pos.SetLength(1.50000000);

			if (charge_)
			{
				this.SetSpeed_XY((this.flag1.pos.x + 25.00000000) * this.direction, this.flag1.pos.y);
			}
			else
			{
				this.SetSpeed_XY((this.flag1.pos.x + 13.50000000) * this.direction, this.flag1.pos.y);
			}

			this.SetTaskAddRotation(0.00000000, 0.00000000, (-5 + this.rand() % 11) * 0.01745329);
			this.stateLabel = function ()
			{
				if (this.IsScreen(150) || this.Damage_ConvertOP(this.x, this.y, 1))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0 || this.grazeCount > 0 || this.hitCount > 0)
				{
					this.callbackGroup = 0;
					this.stateLabel = function ()
					{
						this.alpha = this.red = this.green = this.blue -= 0.10000000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();

		if (this.drawPriority == 180)
		{
			if (this.flag1.pos.y > 0.00000000)
			{
				this.DrawActorPriority(200);
			}
		}
		else if (this.flag1.pos.y < 0.00000000)
		{
			this.DrawActorPriority(180);
		}

		this.flag2 += (this.flag1.y - this.flag2) * 0.20000000;
		this.flag1.pos.RotateByDegree(this.flag3);
		this.x = this.owner.x + this.flag1.pos.x * this.flag1.r * this.direction;
		this.y = this.owner.y + this.flag2 + this.flag1.pos.y * 25;
	};
}

function SPShot_E( t )
{
	this.SetMotion(3049, 0);
	this.atk_id = 16777216;
	this.rz = 90 * 0.01745329;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.alpha = this.red = this.green = this.blue = 0.00000000;
	this.target = this.owner.target.weakref();
	this.DrawActorPriority(180);
	this.flag1 = 0.00000000;
	this.flag2 = 0;
	this.flag3 = t.rot;
	this.func = [
		function ()
		{
			this.DrawActorPriority(180);
			this.SetMotion(3049, 0);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetParent(null, 0, 0);

			if (this.owner.skillE_shot == this)
			{
				this.owner.skillE_shot = null;
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.rz += (90 * 0.01745329 - this.rz) * 0.07500000;
				this.alpha = this.red = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.DrawActorPriority(200);
			this.cancelCount = 3;
			this.SetMotion(3049, 1);
			this.SetSpeed_Vec(20.00000000, this.flag3, this.direction);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				if (this.IsScreen(300) || this.Damage_ConvertOP(this.x, this.y, 10))
				{
					if (this.owner.skillE_shot == this)
					{
						this.owner.skillE_shot = null;
					}

					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0)
				{
					this.func[0].call(this);
					return;
				}

				this.rz += 2.50000000 * 0.01745329;
				this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

				if (this.hitCount == 0)
				{
					this.HitCycleUpdate(0);
				}
			};
		},
		function ()
		{
			this.flag2++;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
			this.HitReset();
			this.count = 0;
			this.hitCount = 0;
			this.cancelCount = 3;
			this.flag1 = -17.50000000 * 0.01745329;
			this.SetMotion(3049, 2);
			this.SetSpeed_XY(3.00000000 * this.direction, -17.00000000);
			this.SetCollisionRotation(0.00000000, 0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.IsScreen(600) || this.Damage_ConvertOP(this.x, this.y, 10))
				{
					if (this.owner.skillE_shot == this)
					{
						this.owner.skillE_shot = null;
					}

					this.ReleaseActor();
					return;
				}

				this.rz += this.flag1;
				this.AddSpeed_XY(0.00000000, 0.60000002, null, 17.00000000);
				this.count++;

				if (this.keyTake != 5 && this.va.y > 0.00000000)
				{
					this.SetMotion(this.motion, 5);
				}

				if (this.cancelCount <= 0 || this.hitCount > 0 || (this.owner.motion == 3040 || this.owner.motion == 3041) && this.owner.keyTake == 0)
				{
					this.SetMotion(3049, 3);
					this.stateLabel = function ()
					{
						if (this.IsScreen(300) || this.Damage_ConvertOP(this.x, this.y, 10))
						{
							if (this.owner.skillE_shot == this)
							{
								this.owner.skillE_shot = null;
							}

							this.ReleaseActor();
							return;
						}

						this.AddSpeed_XY(0.00000000, 0.60000002);
						this.flag1 *= 0.92000002;
						this.rz += this.flag1;
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += (-this.rz - 25 * 0.01745329) * 0.25000000;
		this.alpha = this.red = this.green = this.blue += 0.10000000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = this.red = this.green = this.blue = 1.00000000;
		}

		this.SetSpeed_XY((this.owner.point0_x - this.x) * 0.15000001, (this.owner.point0_y - this.y) * 0.15000001);
	};
}

function SPShot_F( t )
{
	this.SetMotion(3059, 2);
	this.atk_id = 33554432;
	this.rz = -10 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.flag1 = 0.75000000 * 0.01745329;
	this.stateLabel = function ()
	{
		if (this.team.current.IsDamage())
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.05000000;
				this.flag1 += 0.05000000 * 0.01745329;
				this.rz += this.flag1;

				if (this.rz > 90.00000000 * 0.01745329)
				{
					this.rz = 90.00000000 * 0.01745329;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			return;
		}

		if (this.rz > 10.00000000 * 0.01745329)
		{
			this.flag1 += 0.05000000 * 0.01745329;

			if (this.keyTake == 2)
			{
				this.SetMotion(3059, 0);
			}
		}

		this.rz += this.flag1;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

		if (this.hitCount <= 3)
		{
			this.HitCycleUpdate(10);
		}

		if (this.rz >= 90 * 0.01745329)
		{
			this.PlaySE(3638);
			::camera.shake_radius = 5.00000000;
			this.ReleaseActor();
			return;
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(4009, 0);
	this.atk_id = 67108864;
	this.rz = t.rot;
	this.atkRate_Pat = t.rate;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.hitResult & 1)
		{
			this.SetFreeObject(this.target.x, this.target.y, this.direction, this.SpellShot_A_Hit, {});
			this.stateLabel = function ()
			{
			};
		}
	};
}

function SpellShot_A_Hit( t )
{
	this.SetMotion(4009, 1);
	this.sx = this.sy = 0.50000000;
	::battle.SetSlow(90);
	this.stateLabel = function ()
	{
		local s_ = (3.00000000 - this.sx) * 0.25000000;

		if (s_ < 0.02500000)
		{
			s_ = 0.02500000;
		}

		this.sx = this.sy += s_;
		this.alpha = this.blue -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_B_Bullet( t )
{
	this.SetMotion(4019, t.take);
	this.atk_id = 67108864;
	this.flag1 = this.Vector3();
	this.flag1.x = 125 + this.rand() % 100;
	this.flag1.RotateByDegree(this.rand() % 360);
	this.rz = this.rand() % 360 * 0.01745329;
	this.atkRate_Pat = t.rate;
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.red = this.green = this.blue -= 0.05000000;

				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.HitReset();
			this.SetMotion(4019, this.keyTake + 1);
			this.SetSpeed_XY(this.flag1.x * 0.25000000, this.flag1.y * 0.25000000);
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

function SpellShot_B( t )
{
	this.SetMotion(4019, 9);
	this.sx = this.sy = 0.01000000;
	this.flag1 = 0.33000001;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag4 = 0;
	this.atkRate_Pat = t.rate;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_B1, {});
	a_.SetParent(this, 0, 0);
	this.flag2.Add(a_);
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_B2, {});
	a_.SetParent(this, 0, 0);
	this.flag2.Add(a_);
	local a_ = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.owner.SpellShot_B3, {});
	a_.SetParent(this, 0, 0);
	this.flag2.Add(a_);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag3.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag2.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.sx = this.sy = 2.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.69999999;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4019, 8);
			this.HitReset();
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag3.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.flag2.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.sx = this.sy += (6.00000000 - this.sx) * 0.25000000;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
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
		this.count++;

		if (this.count % 3 == 1 && this.flag4 < 20)
		{
			local t_ = {};
			t_.take <- this.flag4 % 4 * 2;
			t_.rate <- this.atkRate_Pat;
			local a_ = this.SetShot(this.x - 320 + this.rand() % 640, ::battle.scroll_bottom + 100, this.direction, this.owner.SpellShot_B_Bullet, t_);
			this.flag3.Add(a_);
			a_.hitOwner = this;
			this.flag4++;
		}

		this.HitCycleUpdate(11);
		this.flag1 += 0.01000000;
		this.sx = this.sy += (this.flag1 - this.sx) * 0.20000000;
		this.flag2.Foreach(function ( sx_ = this.sx, sy_ = this.sy )
		{
			this.sx = this.flag1.x * sx_;
			this.sy = this.flag1.y * sy_;
		});
		this.flag3.Foreach(function ( a_ = this )
		{
			this.flag1.RotateByDegree(9.00000000);
			this.SetSpeed_XY((a_.x + this.flag1.x - this.x) * 0.20000000, (a_.y + this.flag1.y - this.y) * 0.20000000);
		});
		this.Vec_Brake(0.50000000);

		if (this.owner.input.x)
		{
			this.AddSpeed_XY(this.owner.input.x > 0 ? 1.00000000 : -1.00000000, null);
		}

		if (this.owner.input.y)
		{
			this.AddSpeed_XY(null, this.owner.input.y > 0 ? 1.00000000 : -1.00000000);
		}
	};
}

function SpellShot_B1( t )
{
	this.SetMotion(4019, 11);
	this.rx = 75 * 0.01745329;
	this.flag1 = this.Vector3();
	this.flag1.x = 0.00000000;
	this.flag1.y = 0.00000000;
	this.flag2 = 1.00000000;
	this.sx = this.sy = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
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
		this.rz -= 4.00000000 * 0.01745329;
		this.flag2 += 0.01000000;
		this.flag1.x = this.flag1.y += this.flag2 - this.flag1.x - 0.10000000;
	};
}

function SpellShot_B2( t )
{
	this.SetMotion(4019, 12);
	this.flag1 = this.Vector3();
	this.flag1.x = 0.50000000;
	this.flag1.y = 0.50000000;
	this.sx = this.sy = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0.80000001;
				this.sy *= 1.04999995;
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
		this.flag1.y += 0.02500000;
	};
}

function SpellShot_B3( t )
{
	this.SetMotion(4019, 13);
	this.DrawActorPriority(180);
	this.anime.vertex_alpha1 = 0.00000000;
	this.alpha = 0.00000000;
	this.flag1 = this.Vector3();
	this.flag1.x = 1.75000000;
	this.flag1.y = 1.75000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top += 10.00000000;
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
		this.alpha += this.alpha <= 0.94999999 ? 0.05000000 : 0.00000000;
		this.anime.top += 10.00000000;
	};
}

function SpellShot_B_Spark( t )
{
	this.SetMotion(4019, 10);
	this.DrawActorPriority(199);
	this.rz = t.rot;
	this.sx = this.sy = 0.50000000 + this.rand() % 15 * 0.10000000;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx += 0.05000000;
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 2);
	this.atk_id = 67108864;
	::camera.shake_radius = 5.00000000;
	this.PlaySE(3649);
	this.rz = 15 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.flag1 = 0.25000000 * 0.01745329;
	this.atkRate_Pat = t.rate;
	this.cancelCount = 99;
	this.stateLabel = function ()
	{
		if (this.rz > 10.00000000 * 0.01745329)
		{
			if (this.keyTake == 2)
			{
				this.SetMotion(4029, 0);
			}
		}

		this.flag1 += this.flag1 < 0.50000000 * 0.01745329 ? 0.00025000 * 0.01745329 : 0.00000000;

		if (this.rz > 45.00000000 * 0.01745329)
		{
			this.flag1 += 0.01000000 * 0.01745329;

			if (this.keyTake == 0)
			{
				this.SetMotion(4029, 1);
			}
		}

		this.rz += this.flag1;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
		this.HitCycleUpdate(8);
		this.count++;

		if (this.count == 90 && this.initTable.tower)
		{
			local t_ = {};
			t_.rot <- 0.00000000;
			t_.rate <- this.atkRate_Pat;
			t_.tower <- false;
			this.SetShot(640 + 1160 * this.direction, ::battle.scroll_bottom + 260, -this.direction, this.owner.SpellShot_C, t_);
		}

		if (this.rz >= 90 * 0.01745329)
		{
			if (this.initTable.tower == false)
			{
				this.team.spell_enable_end = true;
			}

			this.PlaySE(3650);
			::camera.shake_radius = 12.00000000;
			this.ReleaseActor();
			return;
		}
	};
}

function Climax_Shot( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(4908, 0);
	this.rz = t.rot;
	this.sx = this.sy = 0.00000000;
	this.flag2 = 1.00000000 + this.rand() % 20 * 0.10000000;
	this.flag1 = 0.02500000 + this.rand() % 25 * 0.00100000;
	this.SetSpeed_Vec(2.00000000 + this.rand() % 6, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.sx += 0.50000000;
		this.sy += (this.flag2 - this.sy) * 0.25000000;
		this.count++;

		if (this.count == 6)
		{
			this.stateLabel = function ()
			{
				this.sx += 0.05000000;
				this.sy *= 0.94999999;
				this.alpha -= this.flag1;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_ShotB( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(4908, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02500000;
		this.count++;

		if (this.hitResult & 1)
		{
			this.owner.flag1 = true;
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02500000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
		else
		{
			this.HitCycleUpdate(2);
		}

		if (this.count >= 10)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02500000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_ShotC( t )
{
	this.SetMotion(4908, 0);

	if (this.rand() % 100 <= 50)
	{
		this.DrawActorPriority(110);
	}
	else
	{
		this.DrawActorPriority(210);
	}

	this.rz = t.rot + 90 * 0.01745329;
	this.sx = this.sy = 0.00000000;
	this.flag2 = 0.50000000 + this.rand() % 10 * 0.10000000;
	this.SetSpeed_Vec(1.00000000 * this.flag2, t.rot, this.direction);
	this.flag1 = 0.02500000 + this.rand() % 25 * 0.00100000;
	this.stateLabel = function ()
	{
		this.sx += 0.50000000;
		this.sy += (this.flag2 - this.sy) * 0.25000000;
		this.count++;

		if (this.count == 6)
		{
			this.stateLabel = function ()
			{
				this.sx += 0.00500000;
				this.sy *= 0.99980003;
				this.alpha -= 0.00100000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Back( t )
{
	this.DrawActorPriority(100);
	this.SetMotion(4909, 1);
	this.alpha = 0.00000000;
	this.rz = (45 - this.rand() % 90) * 0.01745329;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 4903)
		{
			this.ReleaseActor();
			return;
		}

		this.rz += 0.50000000 * 0.01745329;
		this.count++;
		this.alpha += 0.02500000;
		this.sx = this.sy += 0.00500000;

		if (this.count == 40)
		{
			this.SetFreeObject(640, 360, this.direction, this.Climax_Back, {});
		}

		if (this.count == 80)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_BackB( t )
{
	this.SetMotion(4909, 5);
	this.flag4 = this.Vector3();
	this.flag4.x = -320;
	this.flag4.RotateByRadian(-30 * 0.01745329);
	this.flag5 = this.Vector3();
	this.flag5.x = 45;
	this.flag5.RotateByRadian(-30 * 0.01745329);
	this.flag3 = this.SetFreeObjectStencil(640 + this.flag4.x * this.direction, 360 + this.flag4.y, this.direction, this.Climax_FaceMaskA, {}).weakref();
	this.anime.stencil = this.flag3;
	this.anime.is_equal = true;
	this.DrawActorPriority(210);
	this.func = [
		function ()
		{
			this.ReleaseActor.call(this.flag3);
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.flag3)
		{
			if (this.count <= 60)
			{
				this.flag3.x += this.flag5.x * this.direction;
				this.flag3.y += this.flag5.y;
			}
		}
	};
}

function ClimaxEffect_SceneA_Sumireko( t )
{
	this.SetMotion(4909, 2);
	this.DrawActorPriority(502);
	this.SetSpeed_XY(0.10000000, -0.07500000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.00050000;
	};
}

function ClimaxEffect_SceneA_Vortex( t )
{
	this.SetMotion(4909, 3);
	this.DrawActorPriority(501);
	this.SetSpeed_XY(-0.25000000, 0.05000000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}
	];
	this.anime.vertex_alpha1 = 0.00000000;
	this.alpha = 1.00000000;
	this.anime.vertex_alpha0 = 1.00000000;
	this.anime.vertex_blue0 = 1.00000000;
	this.anime.vertex_red0 = 1.00000000;
	this.anime.vertex_green0 = 0.20000000;
	this.anime.vertex_alpha1 = 0.00000000;
	this.anime.vertex_blue1 = 0.80000001;
	this.anime.vertex_red1 = 1.00000000;
	this.anime.vertex_green1 = 0.00000000;
	this.stateLabel = function ()
	{
		this.anime.top += 0.10000000;
		this.anime.left -= 0.25000000;
		this.count++;
		this.alpha += 0.01500000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}
	};
}

function ClimaxEffect_SceneA_Back( t )
{
	this.SetMotion(4909, 1);
	this.DrawActorPriority(500);
	this.SetSpeed_XY(-0.25000000, 0.05000000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}
	];
}

function ClimaxEffect_SceneA_LightPilarA( t )
{
	this.SetMotion(4909, 4);
	this.DrawActorPriority(500);
	this.SetSpeed_XY(-0.25000000, 0.05000000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}
	];
	this.stateLabel = function ()
	{
		this.sx += 0.00050000;
	};
}

function ClimaxEffect_SceneA_LightPilarB( t )
{
	this.SetMotion(4909, 5);
	this.DrawActorPriority(500);
	this.SetSpeed_XY(-0.25000000, -0.15000001);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}
	];
}

function Climax_FaceA( t )
{
	this.SetMotion(4909, 3);
	this.flag1 = -30 * 0.01745329;
	this.anime.is_equal = true;
	this.flag4 = this.Vector3();
	this.flag4.x = -320;
	this.flag4.RotateByRadian(-30 * 0.01745329);
	this.flag5 = this.Vector3();
	this.flag5.x = 45;
	this.flag5.RotateByRadian(-30 * 0.01745329);
	this.flag3 = this.SetFreeObjectStencil(this.x + this.flag4.x * this.direction, this.y + this.flag4.y, this.direction, this.Climax_FaceMaskA, {}).weakref();
	this.DrawActorPriority(210);
	this.anime.stencil = this.flag3;
	this.sx = this.sy = 0.80000001;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.25000000 - this.sx) * 0.10000000;
		this.count++;

		if (this.flag3)
		{
			if (this.count <= 60)
			{
				this.flag3.x += this.flag5.x * this.direction;
				this.flag3.y += this.flag5.y;
			}
			else
			{
				this.flag3.alpha -= 0.05000000;

				if (this.flag3.alpha <= 0.00000000)
				{
					this.ReleaseActor.call(this.flag3);
				}
			}
		}
	};
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.ReleaseActor.call(this.flag3);
			}

			this.ReleaseActor();
		}
	];
}

function Climax_FaceMaskA( t )
{
	this.SetMotion(4909, 4);
	this.rz = -30 * 0.01745329;
	this.DrawActorPriority(210);
	this.anime.is_write = true;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_LineA( t )
{
	this.SetMotion(4909, 7);
	this.DrawActorPriority(215);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_LineB( t )
{
	this.SetMotion(4909, 8);
	this.DrawActorPriority(225);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function ClimaxCut_A( t )
{
	this.SetMotion(4907, 1);
	this.DrawScreenActorPriority(200);
	this.SetSpeed_XY(0.15000001, -0.15000001);
	this.func = [
		function ()
		{
			this.ReleaseActor();
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
		this.sx = this.sy -= 0.00025000;
	};
}

function Climax_FaceB( t )
{
	this.SetMotion(4909, 5);
	this.DrawActorPriority(220);
	this.sx = this.sy = 0.50000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0.75000000 - this.sx) * 0.05000000;
		this.rz += (45 * 0.01745329 - this.rz) * 0.05000000;
		this.x += (640 + 100 * this.direction - this.x) * 0.05000000;
		this.y += (360 + 10 - this.y) * 0.05000000;
	};
	this.flag1 = null;
	this.func = [
		function ()
		{
			this.DrawActorPriority(220);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_FaceB_Arm, {}).weakref();
			this.stateLabel = function ()
			{
				this.x += (640 - 200 * this.direction - this.x) * 0.10000000;
				this.y += (360 - 100 - this.y) * 0.10000000;
				this.sx = this.sy += (1.25000000 - this.sx) * 0.10000000;
				this.rz += (-25 * 0.01745329 - this.rz) * 0.10000000;
				this.flag1.x = this.x;
				this.flag1.y = this.y;
				this.flag1.sx = this.flag1.sy = this.sx;
				this.flag1.rz = this.rz;
			};
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.ReleaseActor();
		}
	];
}

function Climax_FaceB_Arm( t )
{
	this.SetMotion(4909, 6);
	this.DrawActorPriority(230);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function ClimaxCut_Flash( t )
{
	this.SetMotion(4907, 3);
	this.DrawScreenActorPriority(200);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sy += 0.01000000;
				this.alpha += (1.00000000 - this.alpha) * 0.05000000;
			};
		}
	];
	this.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.00500000;
	};
}

function SpellShot_ClimaxBrake( t )
{
	this.SetMotion(4908, 0);
	this.atkRate_Pat = t.rate;
	this.flag1 = 0.00000000;
	this.stateLabel = function ()
	{
		this.alpha -= 0.03300000;
		this.sx += 0.05000000;
		this.flag1 += 0.00500000;
		this.sy += this.flag1;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_ClimaxBrakeB( t )
{
	this.SetMotion(4908, 7);
	this.DrawScreenActorPriority(200);
	this.flag1 = 0.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.00500000;
		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function ClimaxEffect_BallRay( t )
{
	this.SetMotion(4908, 2);
	this.alpha = 0.00000000;
	this.rz = this.atan2(700 + this.y, (this.x - 640) * this.direction) - 90 * 0.01745329;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0.99000001;
				this.alpha += 0.02500000;

				if (this.alpha > 1.00000000)
				{
					this.alpha = 1.00000000;
				}

				this.rz *= 1.02499998;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0.01500000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.sy += 0.00100000;
		this.rz *= 1.00500000;
	};
}

function ClimaxEffect_BallLight( t )
{
	this.SetMotion(4908, 3);
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
				this.sx = this.sy *= 1.04999995;
				this.alpha += 0.02500000;

				if (this.alpha > 1.00000000)
				{
					this.alpha = 1.00000000;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.00500000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.alpha += 0.00500000;
	};
}

function Climax_ShotLaserHead( t )
{
	this.SetMotion(4908, 4);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.05000000;
				this.sy *= 0.99000001;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function Climax_ShotLaserBottom( t )
{
	this.SetMotion(4908, 6);
	this.sy = 0.75000000 + this.rand() % 21 * 0.01000000;
	this.sx = 1.00000000 + this.rand() % 30 * 0.01000000;
	this.flag1 = 0.20000000;
	this.stateLabel = function ()
	{
		this.sy += 0.01500000;
		this.sx += this.flag1;
		this.flag1 -= 0.03000000;

		if (this.flag1 <= 0.00500000)
		{
			this.flag1 = 0.00500000;
		}

		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_ShotLaser( t )
{
	this.SetMotion(4908, 5);
	this.atkRate_Pat = t.rate;
	this.owner.KnockBackTarget.call(this, -this.owner.direction);
	this.sx = 0.10000000;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_ShotLaserHead, {}));
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.sx *= 0.85000002;
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
		this.sx += (1.00000000 - this.sx) * 0.33000001;
		this.HitCycleUpdate(10);

		if (this.count % 20 == 19)
		{
			this.flag1.Add(this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.Climax_ShotLaserBottom, {}));
		}
	};
}

