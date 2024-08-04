function Debug_AllKillShot( t )
{
	this.SetMotion(9002, 1);

	switch(t.type)
	{
	case 0:
		this.SetAllHitShot();
		break;

	case 1:
		this.SetTeamShot();
		break;

	default:
		this.SetTeamShot();
		break;
	}

	this.keyAction = this.ReleaseActor;
}

function Debug_KcockShot( t )
{
	this.SetMotion(9001, 0);
	this.SetTeamShot();
	this.keyAction = this.ReleaseActor;
}

function Debug_KcockStunShot( t )
{
	this.SetMotion(9001, 2);
	this.SetTeamShot();
	this.keyAction = this.ReleaseActor;
}

function Debug_SmashShot( t )
{
	this.SetMotion(9001, 1);
	this.SetTeamShot();
	this.keyAction = this.ReleaseActor;
}

function EnableTimeStop( t )
{
	if (t)
	{
		if (this.team.index == 0)
		{
			this.group = 16;
		}
		else
		{
			this.group = 32;
		}
	}
	else if (this.team.index == 0)
	{
		this.group = 256;
	}
	else
	{
		this.group = 512;
	}
}

function DummyPlayer( t )
{
	this.SetMotion(t.motion, t.keyTake);
	this.DrawActorPriority(500);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function DummyPlayer_Screen( t )
{
	this.SetMotion(t.motion, t.keyTake);
	this.DrawScreenActorPriority(200);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function SpellFace( t )
{
	this.EnableTimeStop(false);

	if (this.team.index == 0)
	{
		this.SetMotion(8000, 0);
	}
	else
	{
		this.SetMotion(8001, 0);
	}

	this.isVisible = false;
	this.rz = -15 * 0,01745329.0;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag1 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.SpellFace_Mask, t_, this.weakref()).weakref();
	this.anime.stencil = this.flag1;
	this.anime.is_equal = true;
	this.DrawScreenActorPriority(1002);
	this.SetParent(this.flag1, 0, 0);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.isVisible = true;
			this.flag1.func[1].call(this.flag1);
			this.SetSpeed_Vec(3,00000000.0, this.rz, this.direction);
		},
		function ()
		{
			this.flag1.func[2].call(this.flag1);
			this.stateLabel = function ()
			{
				if (!this.flag1)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 3)
		{
			this.func[1].call(this);
		}

		if (this.count == 40)
		{
			this.func[2].call(this);
		}
	};
}

function SpellFace_Slave( t )
{
	this.EnableTimeStop(false);

	if (this.team.index == 0)
	{
		this.SetMotion(8000, 0);
	}
	else
	{
		this.SetMotion(8001, 0);
	}

	this.isVisible = false;
	this.rz = 15 * 0,01745329.0;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag1 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.SpellFace_Mask, t_, this.weakref()).weakref();
	this.anime.stencil = this.flag1;
	this.anime.is_equal = true;
	this.DrawScreenActorPriority(1002);
	this.SetParent(this.flag1, 0, 0);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.isVisible = true;
			this.flag1.func[1].call(this.flag1);
			this.SetSpeed_Vec(3,00000000.0, this.rz, this.direction);
		},
		function ()
		{
			this.flag1.func[2].call(this.flag1);
			this.stateLabel = function ()
			{
				if (!this.flag1)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 3)
		{
			this.func[1].call(this);
		}

		if (this.count == 40)
		{
			this.func[2].call(this);
		}
	};
}

function SpellFace_Back( t )
{
	this.EnableTimeStop(false);
	this.SetMotion(8000, 2);
	this.sy = 0,00000000.0;
	this.rz = t.rot;
	this.SetParent(t.pare, 0, 0);
	this.DrawScreenActorPriority(999);
	this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_Spell_Cut_Petal, {}, this.weakref());
}

function SpellFace_Edge( t )
{
	this.EnableTimeStop(false);
	this.SetMotion(8000, 3);
	this.sy = 0,00000000.0;
	this.rz = t.rot;
	this.SetParent(t.pare, 0, 0);
	this.DrawScreenActorPriority(1003);
}

function SpellFace_Mask( t )
{
	this.EnableTimeStop(false);
	this.SetMotion(8000, 1);
	this.rz = t.rot;
	this.anime.is_write = true;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellFace_Back, t_, this.weakref()).weakref();
	local t_ = {};
	t_.rot <- this.rz;
	this.flag3 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellFace_Edge, t_, this.weakref()).weakref();
	this.DrawScreenActorPriority(1000);
	this.sy = 1,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();

			if (this.flag2)
			{
				this.flag2.ReleaseActor();
			}

			if (this.flag3)
			{
				this.flag3.ReleaseActor();
			}
		},
		function ()
		{
			this.SetSpeed_Vec(100, this.rz, this.direction);
			this.stateLabel = function ()
			{
				this.flag1 += 100;

				if (this.flag2)
				{
					this.flag2.sy = this.sy;
				}

				if (this.flag3)
				{
					this.flag3.sy = this.sy;
				}

				if (this.flag1 >= 1000)
				{
					if (this.Vec_Brake(10,00000000.0))
					{
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
				this.sy -= 0,20000000.0;

				if (this.flag2)
				{
					this.flag2.sy = this.sy;
				}

				if (this.flag3)
				{
					this.flag3.sy = this.sy;
				}

				if (this.sy <= 0,00000000.0)
				{
					if (this.initTable.pare)
					{
						this.initTable.pare.isVisible = false;
					}

					if (this.flag2)
					{
						this.flag2.ReleaseActor();
					}

					if (this.flag3)
					{
						this.flag3.ReleaseActor();
					}

					this.ReleaseActor();
				}
			};
		}
	];
}

function KO_Face( t )
{
	this.EnableTimeStop(false);
	this.SetMotion(8001, 0);
	this.group = 16384;
	this.DrawScreenActorPriority(200);
	this.stateLabel = function ()
	{
		this.sy += 0,10000000.0;

		if (this.sy > 1,00000000.0)
		{
			this.sy = 1,00000000.0;
		}

		this.count++;

		if (this.count >= 45)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			return;
		}
		else
		{
			this.SetSpeed_XY((640 - 640 * this.direction - this.x) * 0,20000000.0, 0,00000000.0);
		}
	};
}

function SpellUseFace( t )
{
	this.EnableTimeStop(false);

	if (this.direction == 1,00000000.0)
	{
		this.SetMotion(8000, 4);
	}
	else
	{
		this.SetMotion(8001, 4);
	}

	this.DrawScreenActorPriority(200);
	this.SetSpeed_XY(-150 * this.direction, 0,00000000.0);
	this.sx = this.sy = 3,00000000.0;
	this.stateLabel = function ()
	{
		this.VX_Brake(7,50000000.0, -0,75000000.0 * this.direction);
		this.count++;

		if (this.count >= 30)
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(7,50000000.0, -0,75000000.0 * this.direction);
				local s_ = (1,00000000.0 - this.sx) * 0,20000000.0;

				if (s_ > -0,00100000.0)
				{
					s_ = -0,00100000.0;
				}

				this.sx = this.sy += s_;
				this.alpha -= 0,07500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			return;
		}
		else
		{
			local s_ = (1,00000000.0 - this.sx) * 0,20000000.0;

			if (s_ > -0,00100000.0)
			{
				s_ = -0,00100000.0;
			}

			this.sx = this.sy += s_;
		}
	};
}

function SpellBack( t )
{
	this.ConnectRenderSlot(::graphics.slot.info_back, 10);
	this.EnableTimeStop(false);
	this.SetMotion(8000, 2);
	this.alpha = 0,00000000.0;
	this.anime.left = 0;
	this.anime.height = 760;
	this.anime.width = 1280;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.anime.left -= 1,00000000.0;
			this.anime.top += 1,00000000.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.anime.left -= 1,00000000.0;
		this.anime.top += 1,00000000.0;

		if (this.team.spell_time <= 0 && this.owner.IsAttack.call(this.owner) <= 3)
		{
			this.func();
			return;
		}
	};
}

function SpellBack2( t )
{
	this.ConnectRenderSlot(::graphics.slot.info_back, 10);
	this.EnableTimeStop(false);
	this.SetMotion(8000, 2);
	this.alpha = 0,00000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.Warp(this.x + 0,25000000.0 * this.direction, this.y - 0,50000000.0);

			if (this.y <= -512,00000000.0)
			{
				this.Warp(this.x, this.y + 512,00000000.0);
			}

			if (this.x >= 512 && this.direction == 1,00000000.0)
			{
				this.Warp(this.x - 512, this.y);
			}

			if (this.x <= 1280 - 512 && this.direction == -1,00000000.0)
			{
				this.Warp(this.x + 512, this.y);
			}

			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.target.team.spell_time > 0)
		{
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.alpha = 0,00000000.0;
				this.isVisible = false;
			}
		}
		else
		{
			this.isVisible = true;
			this.alpha += 0,05000000.0;

			if (this.alpha > 1,00000000.0)
			{
				this.alpha = 1,00000000.0;
			}
		}

		this.Warp(this.x + 0,25000000.0 * this.direction, this.y - 0,50000000.0);

		if (this.y <= -512,00000000.0)
		{
			this.Warp(this.x, this.y + 512,00000000.0);
		}

		if (this.x >= 512 && this.direction == 1,00000000.0)
		{
			this.Warp(this.x - 512, this.y);
		}

		if (this.x <= 1280 - 512 && this.direction == -1,00000000.0)
		{
			this.Warp(this.x + 512, this.y);
		}

		if (this.team.spell_time <= 0 && this.owner.IsAttack.call(this.owner) <= 3)
		{
			this.func();
			return;
		}
	};
}

function BossBack( t )
{
	this.ConnectRenderSlot(::graphics.slot.info_back, 10);
	this.EnableTimeStop(false);
	this.SetMotion(8000, 2);
	this.alpha = 0,00000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.Warp(this.x + 1,00000000.0 * this.direction, this.y - 1,00000000.0);

			if (this.y <= -512,00000000.0)
			{
				this.Warp(this.x - 512 * this.direction, this.y + 512,00000000.0);
			}

			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.Release();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.Warp(this.x + 1,00000000.0 * this.direction, this.y - 1,00000000.0);

		if (this.y <= -512,00000000.0)
		{
			this.Warp(this.x - 512 * this.direction, this.y + 512,00000000.0);
		}

		if (::battle.time <= 0 || this.owner.life <= 0)
		{
			this.func();
			return;
		}
	};
}

function SpellName( t )
{
	this.ConnectRenderSlot(::graphics.slot.info, 300);
	this.flag1 = {};
	this.flag1.x <- 0,00000000.0;
	this.flag1.y <- 0,00000000.0;
	this.flag1.direction <- this.direction;
	this.direction = 1,00000000.0;

	if (this.owner.team == 1)
	{
		this.group = 256;
		this.flag1.x = 135,00000000.0;
		this.flag1.y = 110,00000000.0;
	}
	else
	{
		this.group = 512;
		this.flag1.x = 1280 - 135,00000000.0;
		this.flag1.y = 110;
	}

	local icon_ = 0;

	if (this.owner.team == 1)
	{
		this.SetMotion(8003, 0);
	}
	else
	{
		this.SetMotion(8004, 0);
	}

	this.sx = this.sy = 6,00000000.0;
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.alpha += 0,06000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		if (this.sx > 4,00000000.0)
		{
			this.sx = this.sy -= 0,20000000.0;
		}

		if (this.count >= 60)
		{
			this.stateLabel = function ()
			{
				if (!this.owner.team.spell_active)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						this.Warp(this.x + (this.owner.team == 1 ? -30 : 30), this.y);
						this.count++;

						if (this.count >= 60)
						{
							this.ReleaseActor();
						}
					};
					return;
				}

				if (this.owner.IsAttack() == 5)
				{
					this.alpha -= 0,20000000.0;

					if (this.alpha < 0,00000000.0)
					{
						this.alpha = 0,00000000.0;
					}
				}
				else
				{
					this.alpha += 0,20000000.0;

					if (this.alpha > 1,00000000.0)
					{
						this.alpha = 1,00000000.0;
					}
				}

				this.sx = this.sx + (1,00000000.0 - this.sx) * 0,20000000.0;
				this.sy = this.sx;
				this.Warp(this.x, this.y + (this.flag1.y - this.y) * 0,20000000.0);
			};
		}
	};
}

function ClimaxSpellName( t )
{
	this.flag1 = {};
	this.flag1.x <- 0,00000000.0;
	this.flag1.y <- 0,00000000.0;
	this.flag1.direction <- this.direction;
	this.direction = 1,00000000.0;

	if (this.owner.team == 1)
	{
		this.group = 256;
		this.flag1.x = 135,00000000.0;
		this.flag1.y = 110,00000000.0;
	}
	else
	{
		this.group = 512;
		this.flag1.x = 1280 - 135,00000000.0;
		this.flag1.y = 110;
	}

	this.priority = 1100;
	local icon_ = 0;

	if (this.owner.team == 1)
	{
		this.SetMotion(8003, 10);
	}
	else
	{
		this.SetMotion(8004, 10);
	}

	this.ConnectRenderSlot(::graphics.slot.info, 300);
	this.sx = this.sy = 6,00000000.0;
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.alpha += 0,06000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		if (this.sx > 4,00000000.0)
		{
			this.sx = this.sy -= 0,20000000.0;
		}

		if (this.count >= 60)
		{
			if (this.count == 60)
			{
				this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 5);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function RoundTitleName( t )
{
	this.SetMotion(9030, 0);
	this.ConnectRenderSlot(::graphics.slot.info, 300);
	this.sx = this.sy = 0,75000000.0;
	this.alpha = 0,00000000.0;
	this.SetSpeed_XY(0,00000000.0, -0,20000000.0);

	if (this.owner.team == 1)
	{
		this.flag1 = 1,00000000.0;
	}
	else
	{
		this.flag1 = -1,00000000.0;
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		if (this.sx > 1,00000000.0)
		{
			this.sx = this.sy = 1,00000000.0;
		}

		this.count++;

		if (this.count >= 150)
		{
			this.AddSpeed_XY(-6,00000000.0 * this.flag1, 0,00000000.0);
		}

		if (this.count >= 240)
		{
			this.ReleaseActor();
		}
	};
}

function WinPlayerName_R( t )
{
	this.SetMotion(9019, 0);
	this.DrawScreenActorPriority(200);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 60)
		{
			this.vx = (200 - this.x) * 0,20000000.0;
		}
	};
}

function WinPlayerName_L( t )
{
	this.SetMotion(9019, 1);
	this.DrawScreenActorPriority(200);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 60)
		{
			this.vx = (1080 - this.x) * 0,20000000.0;
		}
	};
}

function CallAttack_Shot( t )
{
	this.SetMotion(0, 1);
	this.stateLabel = function ()
	{
		this.sx += 0,10000000.0;
		this.sy += 0,10000000.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Suicide_Exp( t )
{
	this.SetMotion(2, 0);
	this.keyAction = this.ReleaseActor;
}

function Shield_Object( t )
{
	this.SetMotion(1, 1);
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.cancelCount = t.life;
	this.func = function ()
	{
		this.SetMotion(1, 2);
		this.stateLabel = function ()
		{
			this.alpha -= 0,20000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.initTable.count <= 0)
		{
			this.func();
			return;
		}

		this.subState();
		this.initTable.count--;
		local s_ = (this.initTable.scale - this.sx) * 0,20000000.0;

		if (s_ > 0,10000000.0)
		{
			s_ = 0,10000000.0;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function BodyShield_Object( t )
{
	this.SetMotion(1, 1);
	this.SetParent(t.pare, 0, 0);
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.cancelCount = t.life;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetMotion(1, 2);
		this.stateLabel = function ()
		{
			this.alpha -= 0,20000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.initTable.count <= 0)
		{
			this.func();
			return;
		}

		this.subState();
		this.initTable.count--;
		local s_ = (this.initTable.scale - this.sx) * 0,20000000.0;

		if (s_ > 0,10000000.0)
		{
			s_ = 0,10000000.0;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.hitResult)
		{
			this.SetMotion(1, 0);
			this.hitResult = 0;
			this.PlaySE(804);
		}
	};
}

function ChargeShot_ChargeStart( t )
{
	this.SetMotion(1010, 3);
	this.sx = this.sy = 4,00000000.0;
	this.SetParent(t.pare, 0, -20);
	this.alpha = 0,00000000.0;
	this.red = 0,00000000.0;
	this.green = 0,33000001.0;
	this.vx = 1,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,20000000.0;
		this.sx = this.sy -= 0,40000001.0;

		if (this.sx <= 0,00000000.0)
		{
			this.DrawActorPriority(99);
			this.sx = this.sy = 2,00000000.0;
			this.SetMotion(1010, 1);
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (6,00000000.0 - this.sx) * 0,03300000.0;
				this.alpha -= 0,05000000.0;
				this.green -= 0,01000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function ChargeShot_FullSpark( t )
{
	this.SetMotion(1010, 1);
	this.sx = this.sy = 5,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetParent(t.pare, 0, -20);
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0,20000000.0;
		this.alpha = this.red = this.green -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.SetMotion(1010, 3);
			this.alpha = 1,00000000.0;
			this.red = 0,00000000.0;
			this.green = 0,25000000.0;
			this.blue = 1,00000000.0;
			this.sx = this.sy = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3,00000000.0 - this.sx) * 0,10000000.0;
				this.alpha -= 0,02500000.0;
				this.green *= 0,98000002.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function ChargeShot_Spark( t )
{
	this.SetMotion(1010, 1);
	this.sx = this.sy = 0,50000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetParent(t.pare, 0, -20);
	this.DrawActorPriority(99);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,15000001.0;
		this.alpha = this.red = this.green -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function ChargeShot_Aura( t )
{
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 128;
	this.anime.vertex_red0 = 0,00000000.0;
	this.anime.vertex_alpha1 = 0,00000000.0;
	this.anime.vertex_red1 = 0,25000000.0;
	this.anime.vertex_green1 = 0,00000000.0;
	this.SetMotion(1010, 0);
	this.DrawActorPriority(99);
	this.alpha = 0,00000000.0;
	this.SetParent(t.pare, 0, -20);
	this.sx = this.sy = 1,50000000.0;
	this.SetCommonFreeObject(this.x, this.y, this.direction, this.ChargeShot_ChargeStart, {}, this.weakref());
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top += 6,00000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.SetCommonFreeObject(this.x, this.y, this.direction, this.ChargeShot_FullSpark, {}, this.weakref());
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 3 == 0)
				{
					this.SetCommonFreeObject(this.x, this.y, this.direction, this.ChargeShot_Spark, {}, this.weakref());
				}

				if (this.count % 9 == 0)
				{
					this.SetCommonFreeObject(this.x, this.y, this.direction, this.ChargeShot_Particle, {}, this.weakref());
				}

				this.alpha += 0,10000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.alpha = 1,00000000.0;
				}

				this.anime.top += 12,00000000.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.anime.top += 6,00000000.0;
	};
}

function ChargeShot_Particle( t )
{
	this.SetMotion(1010, 2);
	this.alpha = 0,00000000.0;
	this.DrawActorPriority(99);
	this.SetParent(t.pare, 0, -20);
	this.sx = this.sy = 0,50000000.0;
	this.red = 0,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.subState = function ()
	{
		this.alpha += 0,15000001.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		local s_ = (1,50000000.0 - this.sx) * 0,10000000.0;

		if (s_ < 0,02500000.0)
		{
			s_ = 0,02500000.0;
		}

		this.sx = this.sy += s_;
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
		this.subState();
	};
}

function Occult_PowerCreatePoint( t )
{
	this.stateLabel = function ()
	{
		if (this.initTable.num > 0 && this.team.slave_ban == 0)
		{
			this.initTable.num--;
			this.owner.target.team.current.SetCommonFreeObject(this.x, this.y, this.direction, this.Occult_Power, {});
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function Occult_Power( t )
{
	this.SetMotion(190, 0);
	this.flag1 = this.rand() % 360 * 0,01745329.0;
	this.flag2 = 10 + this.rand() % 10;
	this.flag3 = this.Vector3();
	this.flag4 = 12,00000000.0;
	this.SetSpeed_Vec(this.flag2, this.flag1, this.direction);
	this.keyAction = function ()
	{
		if (this.team.op_stop < 9999 && this.team.slave_ban == 0)
		{
			this.stateLabel = function ()
			{
				this.flag3.x = this.team.current.x - this.x;
				this.flag3.y = this.team.current.y - this.y;
				this.flag4 += 0,50000000.0;

				if (this.flag4 > 12,00000000.0)
				{
					this.flag4 = 12,00000000.0;
				}

				if (this.flag3.Length() <= 50)
				{
					this.SetEffect(this.x, this.y, this.direction, this.EF_Blossum, {});
					this.PlaySE(856);
					this.sx = this.sy = 1,00000000.0 + this.rand() % 11 * 0,10000000.0;
					this.SetMotion(190, 2);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.keyAction = this.ReleaseActor;

					if (this.team.op_stop > 0)
					{
						if (this.team.op_stop < 9999)
						{
							this.team.op_stop -= 10;
						}

						if (this.team.op_stop < 0)
						{
							this.team.op_stop = 0;
						}
					}
					else
					{
						this.team.AddOP(10, 0);
					}

					this.stateLabel = function ()
					{
						if (this.flag5)
						{
							this.flag5.anime.length *= 0,80000001.0;
							this.flag5.anime.radius0 *= 0,50000000.0;
						}
					};
					return;
				}

				this.flag3.Normalize();
				this.SetSpeed_XY(this.flag3.x * this.flag4, this.flag3.y * this.flag4);
			};
		}
		else
		{
			this.SetMotion(190, 2);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				if (this.flag5)
				{
					this.flag5.anime.length *= 0,80000001.0;
					this.flag5.anime.radius0 *= 0,50000000.0;
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0, 0,50000000.0);
	};
}

