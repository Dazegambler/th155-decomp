function Debug_MarkInvin( t )
{
	this.flag1 = t.owner.weakref();
	this.SetMotion(9001, 0);
	this.ConnectRenderSlot(::graphics.slot.actor, 1000);
	this.sy = 0.50000000;
	this.func = function ()
	{
		this.Release();
	};
	this.stateLabel = function ()
	{
		if (this.flag1.current)
		{
			local take_ = 0;

			if (this.flag1.current.flagState & 32768 || this.flag1.current.invin > 0)
			{
				take_ = take_ + 1;
			}

			if (this.flag1.current.flagState & 65536 || this.flag1.current.invinObject > 0)
			{
				take_ = take_ + 2;
			}

			if (this.flag1.current.flagState & 8192 || this.flag1.current.invinGrab > 0)
			{
				take_ = take_ + 4;
			}

			if (this.flag1.current.flagState & 4096 || this.flag1.current.graze > 0)
			{
				take_ = take_ + 8;
			}

			this.SetMotion(9001, take_);
			this.Warp(this.flag1.current.x - 40, this.flag1.current.y);
		}
	};
}

function Debug_MarkGuard( t )
{
	this.flag1 = t.owner.weakref();
	this.SetMotion(9001, 0);
	this.ConnectRenderSlot(::graphics.slot.actor, 1000);
	this.sy = 0.50000000;
	this.func = function ()
	{
		this.Release();
	};
	this.stateLabel = function ()
	{
		if (this.flag1.current)
		{
			local take_ = 0;

			if (this.flag1.current.flagState & 16)
			{
				take_ = take_ + 1;
			}

			if (this.flag1.current.flagState & 2048)
			{
				take_ = take_ + 2;
			}

			if (this.flag1.current.autoGuardCount > 0)
			{
				take_ = take_ + 4;
			}

			this.SetMotion(9001, take_);
			this.Warp(this.flag1.current.x - 40, this.flag1.current.y + 10);
		}
	};
}

function Debug_MarkCancel( t )
{
	this.flag1 = t.owner.weakref();
	this.SetMotion(9001, 0);
	this.ConnectRenderSlot(::graphics.slot.actor, 1000);
	this.sy = 0.50000000;
	this.func = function ()
	{
		this.Release();
	};
	this.stateLabel = function ()
	{
		if (this.flag1.current)
		{
			local take_ = 0;

			if (this.flag1.current.flagState & 32)
			{
				take_ = take_ + 1;
			}

			if (this.flag1.current.flagState & 1024)
			{
				take_ = take_ + 2;
			}

			if (this.flag1.current.flagState & 16384)
			{
				take_ = take_ + 4;
			}

			if (this.flag1.current.flagState & 512)
			{
				take_ = take_ + 8;
			}

			this.SetMotion(9001, take_);
			this.Warp(this.flag1.current.x - 40, this.flag1.current.y + 20);
		}
	};
}

function Debug_GuardGauge( t )
{
	this.SetMotion(9000, 0);
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.flag1 = this.SetEffect(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(9000, 1);
		this.ConnectRenderSlot(::graphics.slot.info, 1000);
		this.red = 0.00000000;
		this.blue = 0.50000000;
	}, {});
	this.stateLabel = function ()
	{
		this.sx = this.initTable.pare.guardMax / 500.00000000;
		this.flag1.sx = this.initTable.pare.guard / 500.00000000;
	};
}

function Debug_RecoverGauge( t )
{
	this.SetMotion(9000, 0);
	this.ConnectRenderSlot(::graphics.slot.actor, 1000);
	this.SetParent(t.pare, 0, 0);
	this.flag1 = this.SetEffect(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(9000, 1);
		this.SetParent(t_.pare, 0, 0);
		this.ConnectRenderSlot(::graphics.slot.actor, 1000);
		this.blue = 0.00000000;
	}, t);
	this.stateLabel = function ()
	{
		this.flag1.sx = this.initTable.pare.recover / 120.00000000;

		if (this.flag1.sx > this.sx || this.initTable.pare.recover > this.flag2)
		{
			this.sx = this.flag1.sx;
		}

		if (this.initTable.pare.recover <= 0)
		{
			this.sx = 0;
		}

		this.flag2 = this.initTable.pare.recover;
	};
}

function Debug_OkltGauge( t )
{
	if (t.owner.index == 0)
	{
		this.SetMotion(9001, 0);
	}
	else
	{
		this.SetMotion(9002, 0);
	}

	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.stateLabel = function ()
	{
		if (::act.BattleStatus.pl.visible)
		{
			this.isVisible = true;
		}
		else
		{
			this.isVisible = false;
		}

		if (this.initTable.owner.okltBall != this.keyTake)
		{
			this.SetMotion(this.motion, this.initTable.owner.okltBall);
		}
	};
}

function Debug_SpellGuageBack( t )
{
	this.SetMotion(9001, 5);
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	local t_ = {};
	t_.owner <- t.owner;
	this.SetEffect(this.x, this.y, this.direction, this.Debug_SpellGuage, t_);
	this.stateLabel = function ()
	{
		if (::act.BattleStatus.pl.visible)
		{
			this.isVisible = true;
		}
		else
		{
			this.isVisible = false;
		}
	};
}

function Debug_SpellGuage( t )
{
	this.SetMotion(9001, 6);
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.sx = 0;
	this.flag1 = t.owner.weakref();
	this.func = [
		function ()
		{
			this.SetMotion(9001, 6);
			this.sx = this.flag1.sp / 1000.00000000;
			this.stateLabel = function ()
			{
				if (::act.BattleStatus.pl.visible)
				{
					this.isVisible = true;
				}
				else
				{
					this.isVisible = false;
				}

				this.sx = this.flag1.sp / 1000.00000000;

				if (this.sx > 1.00000000)
				{
					this.sx = 1.00000000;
				}

				if (this.flag1.sp > 1000)
				{
					this.func[1].call(this);
				}
			};
		},
		function ()
		{
			this.SetMotion(9001, 7);
			this.sx = (this.flag1.sp - 1000) / 1000.00000000;
			this.stateLabel = function ()
			{
				if (::act.BattleStatus.pl.visible)
				{
					this.isVisible = true;
				}
				else
				{
					this.isVisible = false;
				}

				this.sx = (this.flag1.sp - 1000) / 1000.00000000;

				if (this.sx > 1.00000000)
				{
					this.sx = 1.00000000;
				}

				if (this.flag1.sp <= 1000)
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.func[0].call(this);
}

function Debug_GuardGuageBack( t )
{
	if (t.owner)
	{
		this.flag1 = t.owner.weakref();
	}
	else
	{
		this.Release();
		return;
	}

	this.SetMotion(9000, 0);
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	local t_ = {};
	t_.owner <- t.owner;
	this.flag2 = this.SetEffect(this.x, this.y, this.direction, this.Debug_GuardGuage, t_).weakref();
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.Release();
		}

		this.Release();
	};
	this.stateLabel = function ()
	{
		if (this.flag2 && this.flag1.current)
		{
			this.flag2.sx = this.flag1.current.guard / 500.00000000;

			if (this.flag1.current.guard <= 100)
			{
				this.flag2.blue = 0.00000000;
				this.flag2.green = 0.00000000;
				this.flag2.red = 1.00000000;
			}

			if (this.flag1.current.guard > 100)
			{
				this.flag2.blue = 0.00000000;
				this.flag2.green = 0.50000000;
				this.flag2.red = 1.00000000;
			}

			if (this.flag1.current.guard > 200)
			{
				this.flag2.blue = 0.00000000;
				this.flag2.green = 1.00000000;
				this.flag2.red = 1.00000000;
			}

			if (this.flag1.current.guard > 300)
			{
				this.flag2.blue = 0.00000000;
				this.flag2.green = 1.00000000;
				this.flag2.red = 0.00000000;
			}

			if (this.flag1.current.guard > 400)
			{
				this.flag2.blue = 1.00000000;
				this.flag2.green = 0.33000001;
				this.flag2.red = 0.00000000;
			}
		}
	};
}

function Debug_GuardGuage( t )
{
	this.SetMotion(9000, 1);
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.sx = 0;
	this.flag1 = t.owner.weakref();
}

function Debug_GuardCheck( t )
{
	this.SetMotion(9000, 2);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 60)
		{
			this.Release();
		}
	};
}

function Debug_OP_GuageBack( t )
{
	this.SetMotion(9000, 0);
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
}

function Debug_OP_Guage( t )
{
	this.SetMotion(9000, 1);
	this.SetEffect(this.x, this.y, this.direction, this.Debug_OP_GuageBack, {});
	this.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.sx = 0;
	this.flag1 = t.pare.weakref();
	this.func = [
		function ()
		{
			this.SetMotion(9000, 1);
			this.red = this.green = 0.50000000;
			this.blue = 1.00000000;
			this.sx = this.flag1.op / 2000.00000000;
			this.stateLabel = function ()
			{
				this.sx += (this.flag1.op / 2000.00000000 - this.sx) * 0.20000000;

				if (this.flag1.op >= 2000)
				{
					this.red = this.green = this.blue = 1.00000000;
				}

				if (this.flag1.op_stop > 0)
				{
					this.func[1].call(this);
				}
			};
		},
		function ()
		{
			this.SetMotion(9000, 1);
			this.red = 1.00000000;
			this.blue = this.green = 0.00000000;
			this.count = 0;
			this.sx = this.flag1.op / 2000.00000000;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 20 <= 9)
				{
					this.red = 1.00000000;
					this.blue = this.green = 0.00000000;
				}
				else
				{
					this.red = this.green = 0.50000000;
					this.blue = 1.00000000;
				}

				this.sx += (this.flag1.op / 2000.00000000 - this.sx) * 0.20000000;

				if (this.flag1.op_stop <= 0)
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.func[0].call(this);
}

function Debug_RagEffect_Test( t )
{
	this.SetMotion(9001, 0);
	this.flag1 = 0;
	this.stateLabel = function ()
	{
		if (this.initTable.pare.input.b0 == 1)
		{
			this.flag1++;

			if (this.flag1 > 1)
			{
				this.flag1 = 0;
			}

			this.SetMotion(9001, this.flag1);
		}

		if (this.initTable.pare.input.b1 == 1)
		{
			this.flag1--;

			if (this.flag1 < 0)
			{
				this.flag1 = 1;
			}

			this.SetMotion(9001, this.flag1);
		}
	};
}

function Debug_NumberFont( t )
{
	this.SetMotion(9004, 0);
	local text = ::font.CreateSystemString(t.val);
	this.flag2 = text;
	this.flag2.ConnectRenderSlot(::graphics.slot.actor, 1000);
	this.flag2.x = this.x;
	this.flag2.y = this.y;
	this.vy = -2.00000000;
	this.stateLabel = function ()
	{
		this.flag2.y += this.vy;
		this.count++;

		if (this.count >= 60)
		{
			this.Release();
		}
	};
}

function Font_Infomation( t )
{
	this.SetMotion(9004, 0);
	local text = ::font.CreateSystemString(t.text);
	this.flag2 = text;
	this.flag2.ConnectRenderSlot(::graphics.slot.info, 1000);
	this.flag2.x = this.x - this.flag2.width * 0.66000003;
	this.flag2.y = this.y;
	this.flag2.sx = 1.50000000;
	this.flag2.sy = 1.50000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag2.alpha -= 0.05000000;

				if (this.flag2.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
		}
	];
	this.flag2.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.flag2.alpha += 0.05000000;

		if (this.flag2.alpha >= 1.00000000)
		{
			this.flag2.alpha = 1.00000000;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 40)
				{
					this.flag2.alpha = 0.50000000 + 0.50000000 * this.cos(3.14159203 * (this.count - 40) * 0.10000000);
				}
				else
				{
					this.flag2.alpha = 1.00000000;
				}

				if (this.count >= 60)
				{
					this.count = 0;
				}
			};
		}
	};
}

function Hyoui_Aura( t )
{
	this.SetMotion(58, 0);
	this.SetParent(t.pare, 0, 50);
	this.func = function ()
	{
		this.Release();
	};
	this.stateLabel = function ()
	{
		if (this.initTable.pare)
		{
			if (this.initTable.pare.team.life <= 0)
			{
				this.func();
				return;
			}

			this.flag1 = this.initTable.pare.flagState & -2147483648;

			if (this.isVisible)
			{
				if (this.flag1)
				{
					this.isVisible = false;
				}
			}
			else if (!this.flag1)
			{
				this.isVisible = true;
			}
		}
		else
		{
			this.func();
		}
	};
}

function Occult_Aura( t )
{
	if (t.team == 1)
	{
		this.SetMotion(9003, 4);
	}

	if (t.team == 2)
	{
		this.SetMotion(9003, 5);
	}

	this.ConnectRenderSlot(::graphics.slot.actor, 170);
	this.alpha = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag1 = t.owner.weakref();
	this.flag2 = this.Vector3();
	this.flag4 = 0.00000000;
	this.stateLabel = function ()
	{
		if (this.flag1.motion != 2600)
		{
			this.stateLabel = function ()
			{
				this.vx *= 0.89999998;
				this.vy *= 0.89999998;
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
			return;
		}

		this.alpha += 0.10000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.flag4 += 0.50000000;

		if (this.flag4 > 15.00000000)
		{
			this.flag4 = 15.00000000;
		}

		this.flag2.x = this.flag1.x - this.x;
		this.flag2.y = this.flag1.y - this.y;

		if (this.flag2.Length() <= 30.00000000)
		{
			this.stateLabel = function ()
			{
				this.flag4 *= 0.80000001;
				this.flag2.x = this.flag1.x - this.x;
				this.flag2.y = this.flag1.y - this.y;
				this.flag2.SetLength(this.flag4);
				this.vx = this.flag2.x;
				this.vy = this.flag2.y;
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
		}
		else
		{
			this.flag2.SetLength(this.flag4);
			this.vx = this.flag2.x;
			this.vy = this.flag2.y;
		}
	};
}

function Occult_AuraB_Core( t )
{
	this.SetParent(t.owner, 0, 50);
	this.flag1 = [
		null,
		null
	];
	this.flag2 = t.owner.weakref();
	local t_ = {};
	t_.type <- 0;
	t_.owner <- this.weakref();
	this.flag1[0] = this.SetEffect(this.x, this.y, 1.00000000, this.Occult_AuraB, t_).weakref();
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

			this.Release();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 15)
		{
			local t_ = {};
			t_.type <- 1;
			t_.owner <- this.weakref();
			this.flag1[1] = this.SetEffect(this.x, this.y, 1.00000000, this.Occult_AuraB, t_).weakref();
		}

		if (this.flag2)
		{
			if (this.flag2.flagState & -2147483648 || this.flag2.masterAlpha < 1.00000000)
			{
				if (this.flag2.occultAura[0])
				{
					this.flag2.occultAura[0].alpha = 0;
				}

				foreach( a in this.flag1 )
				{
					if (a)
					{
						a.isVisible = false;
					}
				}
			}
			else
			{
				if (this.flag2.occultAura[0])
				{
					this.flag2.occultAura[0].alpha = 1.00000000;
				}

				foreach( a in this.flag1 )
				{
					if (a)
					{
						a.isVisible = true;
					}
				}
			}
		}
	};
}

function Occult_AuraB( t )
{
	this.SetMotion(56, t.type);
	this.ConnectRenderSlot(::graphics.slot.actor, 189);
	this.SetParent(t.owner, 0, 0);
	this.flag1 = t.owner.weakref();
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (6.00000000 - this.sx) * 0.10000000;
				this.alpha -= 0.01000000;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
		},
		function ()
		{
			this.sx = this.sy = 1.00000000;
			this.alpha = 0.00000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
				this.alpha += 0.25000000;

				if (this.alpha >= 1.00000000)
				{
					this.stateLabel = function ()
					{
						this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
						this.alpha -= 0.04000000;

						if (this.alpha <= 0.00000000)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
}

function EF_Team_Change( t )
{
	this.SetMotion(301, 0);
	this.ConnectRenderSlot(::graphics.slot.actor, 191);
	this.keyAction = this.Release;
}

function EF_Team_ChangeB( t )
{
	this.SetMotion(301, 1);
	this.ConnectRenderSlot(::graphics.slot.actor, 189);
	this.keyAction = this.Release;
	this.SetEffect(this.x, this.y, this.direction, this.EF_Team_ChangeB_Front, {});
}

function EF_Team_ChangeB_Front( t )
{
	this.SetMotion(301, 2);
	this.ConnectRenderSlot(::graphics.slot.actor, 191);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.alpha = this.green -= 0.15000001;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_DashDome( t )
{
	this.SetMotion(50, 0);
}

function EF_CancelMove( t )
{
	this.SetMotion(51, 0);
}

function EF_Dash( t )
{
	this.SetMotion(52, 0);
	this.keyAction = this.Release;
	this.SetParent(t.pare, 0, 0);
}

function EF_DashLine( t )
{
	this.SetMotion(52, 1);
	this.func = function ()
	{
		this.SetKeyFrame(1);
		this.SetParent(null, 0, 0);
		this.func = function ()
		{
		};
	};
	this.keyAction = this.Release;
	this.SetParent(t.pare, 0, 0);
}

function EF_DashFall( t )
{
	this.SetMotion(52, 0);
	this.rz = 45 * 0.01745329;
}

function EF_DashRise( t )
{
	this.SetMotion(52, 0);
}

function EF_Charge( t )
{
	this.SetMotion(53, 0);
}

function EF_ChargeR( t )
{
	this.SetMotion(54, 0);
}

function EF_ChargeO( t )
{
	this.SetMotion(55, 1);
	this.PlaySE(868);
	this.sx = this.sy = 2.50000000;
	this.flag1 = 3;

	if (this.flag1 > 0)
	{
		local t_ = {};
		t_.rot <- this.flag1 * 120 * 0.01745329;
		this.flag1--;
		this.SetEffect(this.x, this.y, this.direction, this.EF_ChargeSparkO, t_);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.25000000;

		if (this.flag1 > 0 && this.rand() % 2 == 1)
		{
			local t_ = {};
			t_.rot <- this.flag1 * 120 * 0.01745329;
			this.flag1--;
			this.SetEffect(this.x, this.y, this.direction, this.EF_ChargeSparkO, t_);
		}

		if (this.sx <= 0.00000000)
		{
			this.SetEffect(this.x, this.y, this.direction, this.EF_ChargeORing, {});
			this.SetMotion(55, 2);
			this.sx = 0.10000000;
			this.sy = 2.00000000;
			this.stateLabel = function ()
			{
				this.sx += (3.00000000 - this.sx) * 0.10000000;
				this.sy *= 0.94999999;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
		}
	};
}

function EF_ChargeSparkO( t )
{
	this.SetMotion(55, 0);
	this.rz = t.rot + this.rand() % 120 * 0.01745329;
	this.keyAction = this.Release;
	this.sx = 0.10000000;
	this.sy = 1.00000000 + this.rand() % 3;
	this.flag1 = 2.50000000 + this.rand() % 25 * 0.10000000;
	this.stateLabel = function ()
	{
		this.sx += (this.flag1 - this.sx) * 0.15000001;
		this.sy *= 0.94999999;
	};
}

function EF_ChargeORing( t )
{
	this.SetMotion(55, 3);
	this.sx = this.sy = 0.10000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (5.00000000 - this.sx) * 0.15000001;
		this.alpha -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_Graze( t )
{
	this.PlaySE(803);
	this.SetMotion(3, 1);
	this.keyAction = this.ReleaseActor;
}

function EF_Blossum( t )
{
	this.SetMotion(4, 0);
	this.keyAction = this.ReleaseActor;
}

function EF_Counter( t )
{
	this.PlaySE(832);
	this.SetMotion(21, 0);
	local t_ = {};
	t_.count <- 20;
	t_.priority <- 210;
	this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
	this.stateLabel = function ()
	{
		this.sx += 0.20000000;
		this.sy = this.sx;

		if (this.alpha > 0.10000000)
		{
			this.alpha -= 0.10000000;
		}
		else
		{
			this.Release();
		}
	};
}

function EF_HitSmashA( t )
{
	this.SetMotion(30, 0);
	this.keyAction = this.Release;
}

function EF_HitSmashB( t )
{
	this.SetMotion(31, 0);
	this.keyAction = this.Release;
}

function EF_HitSmashB2( t )
{
	this.SetMotion(31, 0);
	this.DrawActorPriority(185);
	this.keyAction = this.Release;
}

function EF_HitSmashC( t )
{
	this.SetMotion(32, 0);
	this.keyAction = this.Release;
}

function EF_HitSmashUpper( t )
{
	this.SetMotion(33, 0);
	this.keyAction = this.Release;
}

function EF_HitSmashFront( t )
{
	this.SetMotion(34, 0);
	this.keyAction = this.Release;
}

function EF_HitSmashUnder( t )
{
	this.SetMotion(35, 0);
	this.keyAction = this.Release;
}

function EF_HitGround( t )
{
	this.SetMotion(38, 0);
}

function EF_HitWall( t )
{
	this.SetMotion(39, 0);
}

function EF_Guard( t )
{
	this.flag1 = 0.20000000;
	this.SetMotion(0, 0);
	this.keyAction = this.Release;
	this.ry = 60 * 0.01745329 * this.direction;
	this.SetEffect(this.x, this.y, this.direction, this.EF_GuardRing, {});
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2.00000000 - this.sx) * 0.25000000;
		this.alpha = this.green = this.red -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_GuardRing( t )
{
	this.SetMotion(0, 1);
	this.flag1 = 0.10000000;
	this.ry = 60 * 0.01745329 * this.direction;
	this.stateLabel = function ()
	{
		this.sx += this.flag1;
		this.sy = this.sx;
		this.flag1 *= 0.89999998;
		this.alpha = this.green = this.red -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_GuardMiss( t )
{
	this.flag1 = 0.20000000;
	this.SetMotion(1, 0);
	this.keyAction = this.Release;
	this.ry = 60 * 0.01745329 * this.direction;
	local t_ = {};
	t_.rot <- this.rand() % 360 * 0.01745329;
	this.rz = t_.rot;
	this.SetEffect(this.x, this.y, this.direction, this.EF_GuardMissRing, t_);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02000000;
		this.flag1 *= 0.89999998;
		this.alpha = this.green = this.red -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_GuardMissRing( t )
{
	this.SetMotion(1, 1);
	this.flag1 = 0.10000000;
	this.rz = t.rot;
	this.ry = 60 * 0.01745329 * this.direction;
	this.stateLabel = function ()
	{
		this.sx += this.flag1;
		this.sy = this.sx;
		this.flag1 *= 0.89999998;
		this.alpha = this.green = this.red -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_Boss_Shield( t )
{
	this.SetMotion(92, 0);
	this.alpha = 0.00000000;
	this.sx = 0.89999998;
	this.sy = this.sx;
	this.flag2 = 0;
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
					return;
				}

				this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
			};
		},
		function ()
		{
			this.SetMotion(92, this.flag2);
			this.alpha = 0.00000000;
			this.sx = 1.50000000;
			this.sy = this.sx;
			this.stateLabel = function ()
			{
				this.rz += 0.01745329 * 2.00000000;
				this.Warp(this.initTable.pare.team.current.x, this.initTable.pare.team.current.y);

				if (this.initTable.pare.team.current.flagState & -2147483648)
				{
					this.alpha -= 0.20000000;

					if (this.alpha < 0.00000000)
					{
						this.alpha = 0.00000000;
					}
				}
				else
				{
					this.alpha += 0.10000000;

					if (this.alpha > 1.00000000)
					{
						this.alpha = 1.00000000;
					}
				}

				this.sx = this.sy -= 0.05000000;

				if (this.sx < 1.00000000)
				{
					this.sx = this.sy = 1.00000000;
				}
			};
		},
		function ()
		{
			this.SetMotion(92, this.flag2 + 4);
			this.alpha = 0.00000000;
			this.stateLabel = function ()
			{
				this.rz += 0.01745329;
				this.Warp(this.initTable.pare.team.current.x, this.initTable.pare.team.current.y);

				if (this.initTable.pare.team.current.flagState & -2147483648)
				{
					this.alpha -= 0.20000000;

					if (this.alpha < 0.00000000)
					{
						this.alpha = 0.00000000;
					}
				}
				else
				{
					this.alpha += 0.10000000;

					if (this.alpha > 1.00000000)
					{
						this.alpha = 1.00000000;
					}
				}

				this.sx = this.sy -= 0.05000000;

				if (this.sx < 1.00000000)
				{
					this.sx = this.sy = 1.00000000;
				}
			};
		},
		function ()
		{
			this.SetMotion(92, 8);

			if (::battle.boss_spell[0].slave_life > 0)
			{
				local r_ = (this.initTable.pare.team.regain_life - this.initTable.pare.team.life.tofloat()) / ::battle.boss_spell[0].slave_life.tofloat();

				if (r_ <= 0.50000000)
				{
					this.flag2 = 1;

					if (r_ <= 0.25000000)
					{
						this.flag2 = 2;

						if (r_ <= 0.12500000)
						{
							this.flag2 = 3;
						}
					}
				}
			}

			this.keyAction = function ()
			{
				if (this.initTable.pare)
				{
					if (this.initTable.pare.team.current.shield_rate > 1)
					{
						this.SetMotion(92, this.flag2 + 4);
					}
					else
					{
						this.SetMotion(92, this.flag2);
					}
				}
				else
				{
					this.Release();
				}

				this.keyAction = null;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0.01745329 * 2.00000000;
		this.Warp(this.initTable.pare.x, this.initTable.pare.y);

		if (this.initTable.pare.team.current.flagState & -2147483648)
		{
			this.alpha -= 0.20000000;

			if (this.alpha < 0.00000000)
			{
				this.alpha = 0.00000000;
			}
		}
		else
		{
			this.alpha += 0.10000000;

			if (this.alpha > 1.00000000)
			{
				this.alpha = 1.00000000;
			}
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.01500000;
	};
}

function EF_Shield( t )
{
	this.SetMotion(92, 4);
	this.alpha = 0.00000000;
	this.sx = 0.89999998;
	this.sy = this.sx;
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
					return;
				}

				this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0.01745329 * 2.00000000;
		this.Warp(this.initTable.pare.x, this.initTable.pare.y);
		this.alpha += 0.10000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.01500000;
	};
}

function EF_ApGuardConfetti( t )
{
	this.sx = this.sy = 1.00000000 + this.rand() % 6 * 0.10000000;
	this.flag1 = 0.00000000;
	this.flag2 = 10 + this.rand() % 20;
	this.flag4 = (10 - this.rand() % 120) * 0.01745329;
	this.flag3 = this.Vector3();
	this.flag3.x = (2 - this.rand() % 5) * 0.01745329;
	this.flag3.y = (2 - this.rand() % 5) * 0.01745329;
	this.flag3.z = (2 - this.rand() % 5) * 0.01745329;
	this.rx = this.rand() % 360 * 0.01745329;
	this.ry = this.rand() % 360 * 0.01745329;
	this.rz = this.rand() % 360 * 0.01745329;
	this.red = this.rand() % 11 * 0.10000000;
	this.green = this.rand() % 11 * 0.10000000;
	this.blue = this.rand() % 11 * 0.10000000;
	this.SetMotion(5, 0);
	this.count = this.rand() % 30;
	this.vx = this.flag2 * this.cos(this.flag4) * this.direction;
	this.vy = this.flag2 * this.sin(this.flag4);
	this.stateLabel = function ()
	{
		this.rx += this.flag3.x;
		this.ry += this.flag3.y;
		this.rz += this.flag3.z;
		this.flag2 *= 0.92000002;
		this.flag1 += 0.25000000;

		if (this.flag1 >= 4.00000000)
		{
			this.flag1 = 4.00000000;
		}

		this.vx = this.flag2 * this.cos(this.flag4) * this.direction;
		this.vy = this.flag2 * this.sin(this.flag4);
		this.vy += this.flag1;
		this.count--;

		if (this.count <= 0)
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		}
	};
}

function EF_GuardCrash( t )
{
	this.SetMotion(13, 0);
}

function EF_Avoid( t )
{
	this.flag1 = 0.50000000;
	this.SetMotion(2, 0);
	this.stateLabel = function ()
	{
		this.sx += this.flag1;
		this.sy = this.sx;
		this.flag1 *= 0.89999998;

		if (this.alpha > 0.10000000)
		{
			this.alpha -= 0.10000000;
		}
		else
		{
			this.Release();
		}
	};
}

function EF_StanStar( t )
{
	this.SetMotion(20, 0);
	this.SetParent(this.initTable.pare, 0, 0);
	this.stateLabel = function ()
	{
		if (this.initTable.pare.team.current.flagState & -2147483648)
		{
			this.isVisible = false;
		}
		else
		{
			this.isVisible = true;
		}

		this.Warp(this.initTable.pare.team.current.x, this.initTable.pare.team.current.y);

		if (this.initTable.pare.team.combo_stun != 100 || this.initTable.pare.team.current.stanCount <= 0 || this.initTable.pare.team.life <= 0)
		{
			this.Release();
		}
	};
}

function EF_GuardBaria( t )
{
	this.SetMotion(12, 0);
	this.stateLabel = function ()
	{
		this.Warp(this.initTable.pare.x, this.initTable.pare.y);

		if (this.initTable.pare.motion < 110 || this.initTable.pare.motion > 119)
		{
			this.initTable.pare.guardBaria = false;
			this.stateLabel = function ()
			{
				this.sx -= 0.20000000;
				this.sy -= 0.20000000;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
		}
	};
}

function EF_JustGuardBaria( t )
{
	this.SetMotion(12, 5);
	this.stateLabel = function ()
	{
		this.rz -= 9.00000000 * 0.01745329;
		this.sx = this.sy += 0.20000000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_StunBreak( t )
{
	this.SetMotion(14, 0);
	::camera.Shake(3.00000000);
	this.PlaySE(906);
	this.keyAction = this.Release;
}

function EF_StanBaria( t )
{
	this.SetMotion(10, 0);
	this.SetParent(t.pare, 0, 0);
	this.alpha = 0.00000000;
	this.sx = 0.00000000;
	this.sy = this.sx;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.sx += 0.10000000;

		if (this.sx > 1.00000000)
		{
			this.sx = 1.00000000;
		}

		this.sy = this.sx;

		if (!this.initTable.pare.baria)
		{
			if (this.initTable.pare.stanCount <= 0)
			{
				this.stateLabel = function ()
				{
					this.sx -= 0.10000000;
					this.sy -= 0.10000000;
					this.alpha -= 0.10000000;

					if (this.alpha <= 0.00000000)
					{
						this.Release();
					}
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					this.sx += 0.10000000;
					this.sy += 0.10000000;
					this.alpha -= 0.10000000;

					if (this.alpha <= 0.00000000)
					{
						this.Release();
					}
				};
			}
		}
	};
}

function EF_StanBariaRed( t )
{
	this.SetMotion(11, 0);
	this.SetParent(t.pare, 0, 0);
	this.alpha = 0.00000000;
	this.sx = 0.00000000;
	this.sy = this.sx;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.sx += 0.10000000;

		if (this.sx > 1.00000000)
		{
			this.sx = 1.00000000;
		}

		this.sy = this.sx;

		if (!this.initTable.pare.baria)
		{
			if (this.initTable.pare.stanCount <= 0)
			{
				this.stateLabel = function ()
				{
					this.sx -= 0.10000000;
					this.sy -= 0.10000000;
					this.alpha -= 0.10000000;

					if (this.alpha <= 0.00000000)
					{
						this.Release();
					}
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					this.sx += 0.10000000;
					this.sy += 0.10000000;
					this.alpha -= 0.10000000;

					if (this.alpha <= 0.00000000)
					{
						this.Release();
					}
				};
			}
		}
	};
}

function EF_GuardCancel( t )
{
	this.SetMotion(22, 0);
}

function EF_Spell_Cut_Petal( t )
{
	this.SetMotion(1100, 1);
	this.ConnectRenderSlot(::graphics.slot.info, 1001);
	this.keyAction = this.Release;
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
}

function EF_SpellFlash( t )
{
	this.SetMotion(40, 0);
	return;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.69999999;
		this.count++;

		if (this.count == 15)
		{
			this.count = 0;
			this.sx = this.sy = 0.00000000;
			this.flag1 = 0.60000002;
			local t_ = {};
			t_.scale <- 2.00000000;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_SpellFlashSub, t_);
			local t_ = {};
			t_.scale <- 0.50000000;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_SpellFlashSub, t_);
			this.stateLabel = function ()
			{
				this.SetMotion(this.motion, 1);
				this.sx = this.sy += this.flag1;
				this.flag1 *= 0.80000001;

				if (this.flag1 < 0.05000000)
				{
					this.flag1 = 0.05000000;

					if (this.alpha <= 0.05000000)
					{
						this.Release();
					}
					else
					{
						this.alpha -= 0.05000000;
						this.red -= 0.05000000;
						this.green -= 0.05000000;
					}
				}
			};
		}
	};
}

function EF_SpellFlashSub( t )
{
	this.flag2 = t.scale;
	this.flag1 = 0.60000002;
	this.sx = this.sy = 0.00000000;
	this.rx = (60 - this.rand() % 120) * 0.01745329;
	this.ry = (60 - this.rand() % 120) * 0.01745329;
	this.SetMotion(40, 1);
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag1 * this.flag2;
		this.flag1 *= 0.80000001;

		if (this.flag1 < 0.05000000 * this.flag2)
		{
			this.flag1 = 0.05000000 * this.flag2;

			if (this.alpha <= 0.05000000)
			{
				this.Release();
			}
			else
			{
				this.alpha -= 0.05000000;
				this.red -= 0.05000000;
				this.green -= 0.05000000;
			}
		}
	};
}

function EF_ClimaxFlash( t )
{
	this.sx = this.sy = 12.00000000;
	this.SetMotion(41, 0);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.69999999;
		this.count++;

		if (this.count == 15)
		{
			this.count = 0;
			this.sx = this.sy = 0.00000000;
			this.flag1 = 0.60000002;
			local t_ = {};
			t_.scale <- 2.00000000;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ClimaxFlashSub, t_);
			local t_ = {};
			t_.scale <- 0.50000000;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ClimaxFlashSub, t_);
			this.stateLabel = function ()
			{
				this.SetMotion(this.motion, 1);
				this.sx = this.sy += this.flag1;
				this.flag1 *= 0.80000001;

				if (this.flag1 < 0.05000000)
				{
					this.flag1 = 0.05000000;

					if (this.alpha <= 0.05000000)
					{
						this.Release();
					}
					else
					{
						this.alpha -= 0.05000000;
						this.red -= 0.05000000;
						this.green -= 0.05000000;
					}
				}
			};
		}
	};
}

function EF_ClimaxFlashSub( t )
{
	this.flag2 = t.scale;
	this.flag1 = 0.60000002;
	this.sx = this.sy = 0.00000000;
	this.rx = (60 - this.rand() % 120) * 0.01745329;
	this.ry = (60 - this.rand() % 120) * 0.01745329;
	this.SetMotion(41, 1);
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag1 * this.flag2;
		this.flag1 *= 0.80000001;

		if (this.flag1 < 0.05000000 * this.flag2)
		{
			this.flag1 = 0.05000000 * this.flag2;

			if (this.alpha <= 0.05000000)
			{
				this.Release();
			}
			else
			{
				this.alpha -= 0.05000000;
				this.red -= 0.05000000;
				this.green -= 0.05000000;
			}
		}
	};
}

function EF_Recover( t )
{
	this.SetMotion(51, 0);
}

function EF_RevibeContinue( t )
{
	this.SetMotion(93, 0);
	this.sx = this.sy = 0.10000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
		this.count++;

		if (this.count == 30)
		{
			this.alpha = 2.50000000;
			this.SetMotion(93, 1);
			this.SetEffect(this.x, this.y, this.direction, this.EF_RevibeContinue_Ring, {});
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;
				this.sx += 0.20000000;
				this.sy *= 0.80000001;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
				}
			};
		}
	};
}

function EF_RevibeContinue_Ring( t )
{
	this.SetMotion(93, 2);
	this.alpha = 3.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (3.00000000 - this.sx) * 0.15000001;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_SpellCallBack( t )
{
	this.SetMotion(1103, 0);
	this.ConnectRenderSlot(::graphics.slot.info_back, 100);
	this.alpha = 0.00000000;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 720;
	this.anime.height = 1280;
	this.anime.center_x = 720;
	this.anime.center_y = 640;
	this.rz = -90 * 0.01745329;
	this.sx = this.sy = 4.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.20000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.anime.top -= 10;
		this.anime.left -= 2.00000000;
		this.count++;

		if (this.count >= 60)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
					return;
				}
			};
		}
	};
}

function EF_BossCallBack( t )
{
	this.ConnectRenderSlot(::graphics.slot.info_back, 100);
	this.alpha = 0.00000000;
	this.SetMotion(1103, 0);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 720;
	this.anime.height = 1280;
	this.anime.center_x = 720;
	this.anime.center_y = 640;
	this.rz = -90 * 0.01745329;
	this.sx = this.sy = 4.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.10000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.anime.top -= 40 * this.direction;
		this.anime.left += 3.00000000;
		this.count++;

		if (this.count >= 60)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.15000001;

				if (this.alpha <= 0.00000000)
				{
					this.Release();
					return;
				}
			};
		}
	};
}

function EF_SpellCallBar( t )
{
	this.SetMotion(1103, 2);
	this.ConnectRenderSlot(::graphics.slot.info_back, 200);
	this.sy = 0.00000000;
	this.flag1 = this.SetEffectDynamic(this.x, this.y, this.direction, this.EF_SpellCallBarB, {}).weakref();
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sy -= 0.05000000;

			if (this.flag1)
			{
				this.flag1.sy = this.sy;
			}

			if (this.sy <= 0.00000000)
			{
				if (this.flag1)
				{
					this.flag1.Release();
				}

				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sy += 0.10000000;

		if (this.sy > 1.00000000)
		{
			this.sy = 1.00000000;
		}

		if (this.flag1)
		{
			this.flag1.sy = this.sy;
		}
	};
}

function EF_SpellCallBarB( t )
{
	this.SetMotion(1103, 3);
	this.ConnectRenderSlot(::graphics.slot.info_back, 200);
	this.sx = 6.00000000;
	this.sy = 0.00000000;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 128;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.stateLabel = function ()
	{
		this.anime.left -= 16.00000000;

		if (this.anime.left <= -256.00000000)
		{
			this.anime.left += 256.00000000;
		}
	};
}

function EF_BossSpell_BariaDamage( t )
{
	this.SetMotion(92, 5);
	this.rz = t.rot;
	this.vx = t.v;
	this.stateLabel = function ()
	{
		this.vy += 0.50000000;
		this.rz += 0.01745329;
		this.sx = this.sy += 0.01000000;
		this.alpha -= 0.01500000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_BossSpell_Baria( t )
{
	this.SetMotion(92, 0);
	this.alpha = 0.00000000;
	this.sx = 0.89999998;
	this.sy = this.sx;
	this.ConnectRenderSlot(::graphics.slot.actor, 200);
	this.flag2 = 0;
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
					return;
				}

				this.sx = this.sy += (3.00000000 - this.sx) * 0.10000000;
			};
		},
		function ()
		{
			this.SetMotion(92, this.flag2);
			this.alpha = 0.00000000;
			this.sx = 1.50000000;
			this.sy = this.sx;
			this.stateLabel = function ()
			{
				this.rz += 0.01745329 * 2.00000000;
				this.Warp(this.initTable.pare.x, this.initTable.pare.y);

				if (this.initTable.pare.flagState & -2147483648)
				{
					this.alpha -= 0.20000000;

					if (this.alpha < 0.00000000)
					{
						this.alpha = 0.00000000;
					}
				}
				else
				{
					this.alpha += 0.10000000;

					if (this.alpha > 1.00000000)
					{
						this.alpha = 1.00000000;
					}
				}

				this.sx = this.sy -= 0.05000000;

				if (this.sx < 1.00000000)
				{
					this.sx = this.sy = 1.00000000;
				}
			};
		},
		function ()
		{
			this.PlaySE(873);
			this.SetMotion(92, this.flag2 + 4);
			this.alpha = 0.00000000;
			this.stateLabel = function ()
			{
				this.rz += 0.01745329;
				this.Warp(this.initTable.pare.x, this.initTable.pare.y);

				if (this.initTable.pare.flagState & -2147483648)
				{
					this.alpha -= 0.20000000;

					if (this.alpha < 0.00000000)
					{
						this.alpha = 0.00000000;
					}
				}
				else
				{
					this.alpha += 0.10000000;

					if (this.alpha > 1.00000000)
					{
						this.alpha = 1.00000000;
					}
				}

				this.sx = this.sy -= 0.05000000;

				if (this.sx < 1.00000000)
				{
					this.sx = this.sy = 1.00000000;
				}
			};
		},
		function ()
		{
			this.SetMotion(92, 8);

			if (this.initTable.pare)
			{
				if (this.initTable.pare.team.life <= 0)
				{
					this.func[0].call(this);
					return;
				}
			}

			if (::game.occultCount <= 5000)
			{
				this.flag2 = 1;

				if (::game.occultCount <= 2500)
				{
					this.flag2 = 2;

					if (::game.occultCount <= 1250)
					{
						this.flag2 = 3;
					}
				}
			}

			this.keyAction = function ()
			{
				if (this.initTable.pare)
				{
					if (this.initTable.pare.shield_rate > 1)
					{
						this.SetMotion(92, this.flag2 + 4);
					}
					else
					{
						this.SetMotion(92, this.flag2);
					}
				}
				else
				{
					this.Release();
				}

				this.keyAction = null;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 0.01745329 * 2.00000000;
		this.Warp(this.initTable.pare.x, this.initTable.pare.y);

		if (this.initTable.pare.flagState & -2147483648)
		{
			this.alpha -= 0.20000000;

			if (this.alpha < 0.00000000)
			{
				this.alpha = 0.00000000;
			}
		}
		else
		{
			this.alpha += 0.10000000;

			if (this.alpha > 1.00000000)
			{
				this.alpha = 1.00000000;
			}
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.01500000;
	};
}

function EF_BossSpell_BariaB( t )
{
	this.SetMotion(92, 1);
	this.ConnectRenderSlot(::graphics.slot.actor, 180);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag1 += 0.02500000;
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
			this.flag1 = 0.00000000;
			this.subState = function ()
			{
				this.alpha += 0.10000000;

				if (this.alpha >= 1.00000000)
				{
					this.subState = function ()
					{
						this.alpha -= 0.05000000;

						if (this.alpha <= -1.00000000)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.flag1 += 0.00500000;
		this.subState();
	};
}

function Boss_SpellCharge_Core( t )
{
	this.DrawActorPriority(180);
	this.PlaySE(849);
	this.SetMotion(90, 2);
	this.sx = this.sy = 0.00000000;
	this.owner = t.owner.weakref();
	local t_ = {};
	t_.owner <- t.owner.weakref();
	this.flag1 = [];
	this.flag1.append(this.SetEffect(this.x, this.y, this.direction, this.Boss_SpellCharge_Ring, t_).weakref());
	this.func = function ()
	{
		foreach( a in this.flag1 )
		{
			if (a)
			{
				this.Release.call(a);
			}
		}

		this.flag1 = null;
		this.stateLabel = function ()
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.team.current.IsDamage())
		{
			this.func();
			return;
		}

		this.count++;

		if (this.count % 5 == 0)
		{
			local t_ = {};
			t_.owner <- this.owner.weakref();
			this.flag1.append(this.SetEffect(this.x, this.y, this.direction, this.Boss_SpellCharge, t_).weakref());
		}

		if (this.count % 20 == 0)
		{
			local t_ = {};
			t_.owner <- this.owner.weakref();
			this.flag1.append(this.SetEffect(this.x, this.y, this.direction, this.Boss_SpellChargeB, t_).weakref());
		}

		this.Warp(this.owner.x, this.owner.y);
		local s_ = (3.00000000 - this.sx) * 0.05000000;

		if (s_ < 0.01500000)
		{
			s_ = 0.01500000;
		}

		this.sx = this.sy += s_;
	};
}

function EF_SpellCharge( t )
{
	this.SetMotion(42, t.type);
	this.ConnectRenderSlot(::graphics.slot.status, 10000);
	this.sx = this.sy = 2.00000000;
	this.alpha = 1.25000000;
	this.stateLabel = function ()
	{
		if (::battle.state != 8)
		{
			this.Release();
			return;
		}

		this.sx = this.sy *= 0.80000001;
		this.count++;

		if (this.count == 5)
		{
			local t_ = {};
			t_.owner <- this.initTable.owner.weakref();
			t_.type <- this.initTable.type + 2;
			this.SetEffectDynamic(this.x, this.y, this.direction, this.EF_SpellChargeRing, t_);
			local t_ = {};
			t_.owner <- this.initTable.owner.weakref();
			t_.type <- this.initTable.type + 4;
			this.SetEffect(this.x, this.y, this.direction, this.EF_SpellChargePart, t_);
		}

		this.alpha -= 0.10000000;

		if (this.alpha <= 1.00000000)
		{
			this.red = this.green = this.alpha;
		}

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_SpellChargeRing( t )
{
	this.SetMotion(42, t.type);
	this.ConnectRenderSlot(::graphics.slot.status, 10000);
	this.alpha = 1.50000000;
	this.flag1 = 22.50000000 * 0.01745329;
	this.stateLabel = function ()
	{
		if (::battle.state != 8)
		{
			this.Release();
			return;
		}

		this.rz += this.flag1;
		this.flag1 *= 0.94999999;
		local r2_ = (128 - this.anime.radius1) * 0.25000000;

		if (r2_ < 0.02500000)
		{
			r2_ = 0.02500000;
		}

		this.anime.radius1 += r2_;
		this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0.11000000;
		this.alpha -= 0.03300000;

		if (t.type == 2)
		{
			if (this.alpha <= 1.00000000)
			{
				this.red = this.green = this.alpha;
			}
		}
		else if (this.alpha <= 1.00000000)
		{
			this.blue = this.green = this.alpha;
		}

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_SpellChargePart( t )
{
	this.SetMotion(42, t.type);
	this.ConnectRenderSlot(::graphics.slot.status, 10000);
	this.alpha = 1.50000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.stateLabel = function ()
	{
		if (::battle.state != 8)
		{
			this.Release();
			return;
		}

		this.sx = this.sy += (3.50000000 - this.sx) * 0.12500000;
		this.alpha -= 0.03300000;

		if (t.type == 4)
		{
			if (this.alpha <= 1.00000000)
			{
				this.red = this.green = this.alpha;
			}
		}
		else if (this.alpha <= 1.00000000)
		{
			this.blue = this.green = this.alpha;
		}

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function Boss_SpellCharge( t )
{
	this.PlaySE(849);
	this.SetMotion(94, 0);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.func = function ()
	{
		this.SetKeyFrame(1);
		this.SetParent(null, 0, 0);
		this.func = function ()
		{
		};
	};
	this.keyAction = this.Release;
}

function Boss_SpellChargeBig( t )
{
	this.DrawActorPriority(180);
	this.PlaySE(849);
	this.SetMotion(94, 1);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.func = function ()
	{
		this.Release();
	};
}

function Boss_SpellChargeDark( t )
{
	this.PlaySE(849);
	this.SetMotion(94, 2);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.func = function ()
	{
		this.SetKeyFrame(1);
		this.SetParent(null, 0, 0);
		this.func = function ()
		{
		};
	};
	this.keyAction = this.Release;
}

function Boss_SpellBreak( t )
{
	this.SetMotion(91, 0);
}

function Boss_PlayerBreak( t )
{
	this.SetMotion(91, 0);
}

function EF_FieldSpark( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, t.priority);
	this.SetMotion(108, 0);
}

function EF_SpeedLine( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, t.priority);
	this.SetMotion(73, 0);
	this.stateLabel = function ()
	{
		this.flag1 = 0;
		local t_ = {};
		t_.priority <- this.initTable.priority;
		this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine_Bar, t_);
		this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine_Bar, t_);
		this.count++;

		if (this.count >= this.initTable.count)
		{
			this.Release();
		}
	};
}

function EF_SpeedLine_Bar( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, t.priority);
	this.SetMotion(73, 1 + this.rand() % 3);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 1.00000000 + this.rand() % 6 * 0.10000000;
	this.stateLabel = function ()
	{
		this.sx += 0.05000000;
		this.sy *= 0.94999999;
		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function PopularCheer( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, 210);
	this.rz = (10 - this.rand() % 20) * 0.01745329;
	this.SetMotion(73, 0);
	this.stateLabel = function ()
	{
		this.count++;
		this.sx = this.sy += 0.00250000;

		if (this.count >= 30)
		{
			this.alpha -= 0.03500000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		}
	};
}

function EF_KO_Flash( t )
{
	this.ConnectRenderSlot(::graphics.slot.actor, 210);
	this.SetMotion(1010, 0);
	this.sx = this.sy = 0.00000000;
	this.SetParent(t.pare, 0, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.01000000;
		this.count++;

		if (this.count == 120)
		{
			this.initTable.pare.func.call(this.initTable.pare);
			this.PlaySE(847);
			this.initTable.pare.FadeIn(1.00000000, 1.00000000, 1.00000000, 120);
			this.SetEffect(this.x, this.y, 1.00000000, this.EF_KO_Exp, {});
			this.Release();
		}
	};
}

function EF_KO_Exp( t )
{
	this.ConnectRenderSlot(::graphics.slot.actor, 210);
	this.SetMotion(1010, 1);
}

function EF_KO_Back( t )
{
	this.ConnectRenderSlot(::graphics.slot.info_back, 100);
	this.SetMotion(1001, 4);
	this.sx = this.sy = 2.00000000;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 45)
		{
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		}
	};
}

function EF_BgmCall( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	local take_ = ::load_data.bgm % 100 - 1;
	take_ = this.Math_MinMax(take_, 0, 11);
	this.SetMotion(1009, take_);
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.Warp(this.x + (1680 - this.x) * 0.10000000, this.y);
			this.count++;

			if (this.count >= 120)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.Warp(this.x + (1280 - this.x) * 0.10000000, this.y);
	};
}

function Round_Call_1( t )
{
	this.SetMotion(1000, 0);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.PlaySE(850);
}

function Round_Call_2( t )
{
	this.SetMotion(1000, 1);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.PlaySE(850);
}

function Round_Call_3( t )
{
	this.SetMotion(1000, 2);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.PlaySE(850);
}

function Round_Call_4( t )
{
	this.SetMotion(1000, 3);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.PlaySE(850);
}

function Round_Call_5( t )
{
	this.SetMotion(1000, 4);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.PlaySE(850);
}

function Round_Call_Fight( t )
{
	this.SetMotion(1001, 0);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.PlaySE(851);
}

function Round_Call_KO( t )
{
	this.SetMotion(1001, 1);
	this.PlaySE(855);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
}

function Round_Call_TimeUp( t )
{
	this.SetMotion(1001, 2);
	this.PlaySE(852);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
}

function Round_Call_Draw( t )
{
	this.PlaySE(854);
	this.SetMotion(1001, 3);
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
}

function Round_Call_Win1P( t )
{
	this.SetMotion(1003, 0);
	this.rz = -15.00000000 * 0.01745329;
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.alpha = 0.00000000;
	this.sx = this.sy = 3.00000000;
	this.func = [
		function ()
		{
			this.Release();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.10000000;
		this.alpha += 0.05000000;

		if (this.sx <= 1.00000000)
		{
			this.sx = this.sy = this.alpha = 1.00000000;
			this.stateLabel = null;
		}
	};
}

function Round_Call_Win2P( t )
{
	this.SetMotion(1003, 1);
	this.rz = -15.00000000 * 0.01745329;
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.keyAction = this.Release;
	this.alpha = 0.00000000;
	this.sx = this.sy = 3.00000000;
	this.func = [
		function ()
		{
			this.Release();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.10000000;
		this.alpha += 0.05000000;

		if (this.sx <= 1.00000000)
		{
			this.sx = this.sy = this.alpha = 1.00000000;
			this.stateLabel = null;
		}
	};
}

function Story_Title_Back( t )
{
	this.SetMotion(2001, 0);
	this.ConnectRenderSlot(::graphics.slot.talk, 200);
	this.alpha = 0.00000000;
	this.vy = -4.00000000;
	this.func = function ()
	{
		this.alpha = 1.00000000;
		this.stateLabel = function ()
		{
			this.vy += 0.20000000;
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.vy += 0.20000000;

		if (this.vy > 0)
		{
			this.vy = 0;
		}

		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}
	};
}

function Story_Title_Shadow( t )
{
	this.SetMotion(2001, 1);
	this.ConnectRenderSlot(::graphics.slot.talk, 210);
	this.alpha = 0.00000000;
	this.func = function ()
	{
		this.alpha = 1.00000000;
		this.stateLabel = function ()
		{
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.alpha += 0.02500000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.sx = this.sy += 0.00100000;
	};
}

function Story_Title_Name( t )
{
	this.SetMotion(2001, 2);
	this.ConnectRenderSlot(::graphics.slot.talk, 220);
	this.alpha = 0.00000000;
	this.vy = 4.00000000;
	this.flag1 = this.SetStoryEffect(this.x, this.y + 100, 1.00000000, this.Story_Title_Back, {}).weakref();
	this.func = function ()
	{
		this.flag1.func();
		this.flag2.func();
		this.alpha = 1.00000000;
		this.stateLabel = function ()
		{
			this.vy -= 0.20000000;
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.vy -= 0.20000000;

		if (this.vy < 0)
		{
			this.vy = 0;
		}

		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.count++;

		if (this.count == 20)
		{
			this.flag2 = this.SetStoryEffect(this.x, this.y, 1.00000000, this.Story_Title_Shadow, {}).weakref();
		}

		if (this.count == 120)
		{
			this.func();
		}
	};
}

function Story_EnemyName_Back( t )
{
	this.SetMotion(2002, 0);
	this.ConnectRenderSlot(::graphics.slot.talk, 200);
	this.alpha = 0.00000000;
	this.vx = -8.00000000;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.vx += 0.20000000;

		if (this.vx > 0)
		{
			this.vx = 0;
		}

		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}
	};
}

function Story_EnemyName( t )
{
	this.SetMotion(2002, 1);
	this.ConnectRenderSlot(::graphics.slot.talk, 220);
	this.alpha = 0.00000000;
	this.vx = -10.00000000;
	this.flag1 = this.SetStoryEffect(this.x, this.y, 1.00000000, this.Story_EnemyName_Back, {}).weakref();
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.stateLabel = function ()
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.vx += 0.20000000;

		if (this.vx > 0)
		{
			this.vx = 0;
		}

		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.count++;

		if (this.count == 240)
		{
			this.func();
		}
	};
}

function Story_EnemySlaveName( t )
{
	this.SetMotion(2003, 1);
	this.ConnectRenderSlot(::graphics.slot.talk, 220);
	this.alpha = 0.00000000;
	this.vx = -10.00000000;
	this.flag1 = this.SetStoryEffect(this.x, this.y, 1.00000000, this.Story_EnemyName_Back, {}).weakref();
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.stateLabel = function ()
		{
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.vx += 0.20000000;

		if (this.vx > 0)
		{
			this.vx = 0;
		}

		this.alpha += 0.05000000;

		if (this.alpha > 1.00000000)
		{
			this.alpha = 1.00000000;
		}

		this.count++;

		if (this.count == 240)
		{
			this.func();
		}
	};
}

function EF_Set_FadeColor( a_, r_, g_, b_ )
{
	this.flag2 = a_;

	if (this.flag2 <= 0)
	{
		this.flag2 = 0.10000000;
	}

	this.red = r_;
	this.blue = b_;
	this.green = g_;
}

function EF_BeginFadeOut( wait_, time_ )
{
	this.alpha = 0.00000000;
	this.count = wait_;

	if (time_ <= 0)
	{
		this.flag1 = 1.00000000;
	}
	else
	{
		this.flag1 = this.flag2 / time_;
	}

	this.stateLabel = function ()
	{
		this.count--;

		if (this.count <= 0)
		{
			this.alpha += this.flag1;

			if (this.alpha >= this.flag2)
			{
				this.alpha = this.flag2;
				this.stateLabel = function ()
				{
				};
			}
		}
	};
}

function EF_BeginFadeIn( wait_, time_ )
{
	this.alpha = this.flag2;
	this.count = wait_;

	if (time_ <= 0)
	{
		this.flag1 = 1.00000000;
	}
	else
	{
		this.flag1 = this.flag2 / time_;
	}

	this.stateLabel = function ()
	{
		this.count--;

		if (this.count <= 0)
		{
			this.alpha -= this.flag1;

			if (this.alpha <= 0.00000000)
			{
				if (this.initTable.pare.team.fade_screen == this)
				{
					this.initTable.pare.team.fade_screen = null;
				}

				this.Release();
				return;
			}
		}
	};
}

function EF_BeginBackFadeIn( wait_, time_ )
{
	this.alpha = this.flag2;
	this.count = wait_;

	if (time_ <= 0)
	{
		this.flag1 = 1.00000000;
	}
	else
	{
		this.flag1 = this.flag2 / time_;
	}

	this.stateLabel = function ()
	{
		this.count--;

		if (this.count <= 0)
		{
			this.alpha -= this.flag1;

			if (this.alpha <= 0.00000000)
			{
				if (this.initTable.pare.team.fade_back == this)
				{
					this.initTable.pare.team.fade_back = null;
				}

				this.Release();
				return;
			}
		}
	};
}

function EF_FadeScreen( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, 300);
	this.SetMotion(1101, 0);
	this.red = 0.00000000;
	this.blue = 0.00000000;
	this.green = 0.00000000;
	this.alpha = 0.00000000;
}

function EF_FadeBackScreen( t )
{
	this.ConnectRenderSlot(::graphics.slot.info_back, 100);
	this.SetMotion(1101, 0);
	this.red = 0.00000000;
	this.blue = 0.00000000;
	this.green = 0.00000000;
	this.alpha = 0.00000000;
}

function EF_DebuffHate( t )
{
	this.SetMotion(3000, 0);
	this.owner = t.owner.weakref();
	this.stateLabel = function ()
	{
		if (this.owner.flagState & -2147483648)
		{
			this.alpha = 0.00000000;
		}
		else
		{
			this.alpha = 1.00000000;
			this.count++;

			if (this.count % 15 == 1)
			{
				local t_ = {};
				t_.owner <- this.owner.weakref();
				this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffHate_B, t_);
			}
		}

		this.Warp(this.owner.x, this.owner.y - 75);
	};
}

function EF_DebuffHate_B( t )
{
	this.SetMotion(3000, 1);
	this.owner = t.owner.weakref();
	this.rz = (-45 - this.rand() % 90) * 0.01745329;
	this.sx = this.sy = 0.00000000;
	this.vx = 15.00000000 * this.cos(this.rz) * this.direction;
	this.vy = 15.00000000 * this.sin(this.rz);
	this.stateLabel = function ()
	{
		this.vx *= 0.80000001;
		this.vy *= 0.80000001;

		if (this.owner.flagState & -2147483648 || !this.owner.isVisible)
		{
			this.Release();
		}

		this.sx = this.sy += this.sx < 2.00000000 ? 0.10000000 : 0.00000000;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function EF_DebuffHyper( t )
{
	this.SetMotion(3001, 0);
	this.owner = t.owner.weakref();
	this.stateLabel = function ()
	{
		if (this.owner.flagState & -2147483648 || !this.owner.isVisible)
		{
			this.alpha = 0.00000000;
		}
		else
		{
			this.alpha = 1.00000000;
		}

		this.Warp(this.owner.x, this.owner.y - 75);
	};
}

function EF_DebuffFear( t )
{
	this.SetMotion(3002, 0);
	this.owner = t.owner.weakref();
	this.stateLabel = function ()
	{
		if (this.owner.flagState & -2147483648 || !this.owner.isVisible)
		{
			this.alpha = 0.00000000;
		}
		else
		{
			this.alpha = 1.00000000;
			this.count++;

			if (this.count % 15 == 1)
			{
				local t_ = {};
				t_.owner <- this.owner;
				this.SetEffect(this.x, this.y, this.rand() % 100 <= 50 ? 1.00000000 : -1.00000000, this.EF_DebuffFear_B, t_);
			}
		}

		this.Warp(this.owner.x, this.owner.y - 75);
	};
}

function EF_DebuffFear_B( t )
{
	this.SetMotion(3002, 1 + this.rand() % 2);
	this.owner = t.owner.weakref();
	this.rz = (-this.rand() % 45 - 30) * 0.01745329;
	this.sx = this.sy = 0.00000000;
	this.vx = 8.00000000 * this.cos(this.rz) * this.direction;
	this.vy = 3.00000000 * this.sin(this.rz);
	this.stateLabel = function ()
	{
		this.vy += 0.20000000;
		this.rz = this.atan2(this.vy, this.vx * this.direction);
		this.count++;

		if (this.count >= 10)
		{
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		}

		if (this.owner.flagState & -2147483648 || !this.owner.isVisible)
		{
			this.Release();
		}

		this.sx = this.sy += this.sx < 2.00000000 ? 0.10000000 : 0.00000000;
	};
}

function EF_DebuffAnimal( t )
{
	this.SetMotion(3003, this.rand() % 4);
	this.rz = this.rand() % 360 * 0.01745329;
	local sp_ = this.rand() % 3;
	this.vx = sp_ * this.cos(this.rz) * this.direction;
	this.vy = sp_ * this.sin(this.rz);
	this.sx = this.sy = 2.00000000;
	local st_ = function ( t_ )
	{
		this.SetMotion(3003, this.rand() % 4);
		this.sx = this.sy = 0.80000001 + this.rand() % 5 * 0.10000000;
		this.rz = this.rand() % 360 * 0.01745329;
		local sp_ = 4 + this.rand() % 8;
		this.vx = sp_ * this.cos(this.rz) * this.direction;
		this.vy = sp_ * this.sin(this.rz) * 0.50000000;
		local r_ = 3 + this.rand() % 5;
		this.Warp(this.x + this.vx * r_, this.y + this.vy * r_);
		this.flag1 = 0.04000000 + this.rand() % 20 * 0.00100000;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.97000003;

			if (this.abs(this.vx) <= 0.50000000)
			{
				this.vx = 0;
			}
			else
			{
				this.vx -= this.vx > 0 ? 0.50000000 : -0.50000000;
			}

			this.vy -= 0.25000000;
			this.alpha -= this.flag1;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.rot <- (i + this.rand() % 30) * 0.01745329;
		this.SetEffect(this.x, this.y, this.direction, st_, t_);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.98000002;

		if (this.abs(this.vx) <= 0.44999999)
		{
			this.vx = 0;
		}
		else
		{
			this.vx -= this.vx > 0 ? 0.44999999 : -0.44999999;
		}

		this.vy -= 0.44999999;
		this.alpha -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

function PopularInfo( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, 200);
	this.SetMotion(t.motion, t.take);
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.Warp(this.x - (this.x < 640 ? 256 : -256), this.y);
	this.func = function ()
	{
		this.count = 90;
	};
	this.subState = function ()
	{
		local x_ = (this.flag1.x - this.x) * 0.20000000;

		if (this.abs(x_) <= 1.00000000)
		{
			this.Warp(this.flag1.x, this.y);
			this.subState = function ()
			{
				this.Warp(this.x, this.y + (this.flag1.y - this.y) * 0.20000000);
			};
		}
		else
		{
			this.Warp(this.x + x_, this.y);
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.count++;

		if (this.count >= 90)
		{
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		}
	};
}

function EF_Item8( t )
{
	this.SetMotion(3003, this.rand() % 4);
	this.rz = this.rand() % 360 * 0.01745329;
	local sp_ = this.rand() % 3;
	this.vx = sp_ * this.cos(this.rz) * this.direction;
	this.vy = sp_ * this.sin(this.rz);
	this.sx = this.sy = 2.00000000;
	local st_ = function ( t_ )
	{
		this.SetMotion(3003, this.rand() % 4);
		this.sx = this.sy = 0.80000001 + this.rand() % 5 * 0.10000000;
		this.rz = this.rand() % 360 * 0.01745329;
		local sp_ = 4 + this.rand() % 8;
		this.vx = sp_ * this.cos(this.rz) * this.direction;
		this.vy = sp_ * this.sin(this.rz) * 0.50000000;
		local r_ = 3 + this.rand() % 5;
		this.Warp(this.x + this.vx * r_, this.y + this.vy * r_);
		this.flag1 = 0.04000000 + this.rand() % 20 * 0.00100000;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0.97000003;

			if (this.abs(this.vx) <= 0.50000000)
			{
				this.vx = 0;
			}
			else
			{
				this.vx -= this.vx > 0 ? 0.50000000 : -0.50000000;
			}

			this.vy -= 0.25000000;
			this.alpha -= this.flag1;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	};

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.rot <- (i + this.rand() % 30) * 0.01745329;
		this.SetEffect(this.x, this.y, this.direction, st_, t_);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.98000002;

		if (this.abs(this.vx) <= 0.44999999)
		{
			this.vx = 0;
		}
		else
		{
			this.vx -= this.vx > 0 ? 0.44999999 : -0.44999999;
		}

		this.vy -= 0.44999999;
		this.alpha -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.Release();
		}
	};
}

