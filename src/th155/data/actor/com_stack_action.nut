function ComStack_Clear()
{
	this.com_stackState = [];
	this.com_stackCount = 0;
}

function ComStack_CheckFree( wait_ = 0 )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.IsFree())
			{
				return true;
			}
			else
			{
				this.com_stackCount--;

				if (this.com_stackCount <= 0)
				{
					this.ComStack_Clear();
					return;
				}
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_CheckMotion( motion_, wait_ = 0 )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.motion <- motion_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = t_.motion;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.motion == this.com_stackFlag)
			{
				return true;
			}
			else
			{
				this.com_stackCount--;

				if (this.com_stackCount <= 0)
				{
					this.ComStack_Clear();
					return;
				}
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_CheckHit( HR_, wait_ = 0 )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.result <- HR_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = t_.result;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.hitResult & this.com_stackFlag)
			{
				return true;
			}
			else
			{
				this.com_stackCount--;

				if (this.com_stackCount <= 0)
				{
					this.ComStack_Clear();
					return;
				}
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_CheckMana( mp_, wait_ = 0 )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.mp <- mp_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = t_.mp;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.team.mp >= this.com_stackFlag)
			{
				return true;
			}
			else
			{
				this.com_stackCount--;

				if (this.com_stackCount <= 0)
				{
					this.ComStack_Clear();
					return;
				}
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Wait( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_WaitHit( HR_, wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.result <- HR_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = t_.result;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.hitResult & this.com_stackFlag)
			{
				return true;
			}

			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Walk( x_, wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.x <- x_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_keyFlag.x = t_.x;
		this.com_stackState[0].state = function ( t_ )
		{
			this.input.x = this.com_keyFlag.x;

			if (this.motion == 1 || this.motion == 2)
			{
				this.com_stackState[0].state = function ( t_ )
				{
					this.com_stackCount--;

					if (this.com_stackCount <= 0)
					{
						return true;
					}

					this.input.x = this.com_keyFlag.x;
				};
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Slide( x_, y_, wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.wait <- wait_;
	tab_.table.x <- x_;
	tab_.table.y <- y_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_keyFlag.x = t_.x;
		this.com_keyFlag.y = t_.y;
		this.com_stackState[0].state = function ( t_ )
		{
			this.input.x = this.com_keyFlag.x;
			this.input.y = this.com_keyFlag.y < 0 ? -3 : 3;

			if (this.motion == 10 || this.motion == 11 || this.motion == 20 || this.motion == 21)
			{
				this.com_stackState[0].state = function ( t_ )
				{
					this.com_stackCount--;

					if (this.com_stackCount <= 0)
					{
						return true;
					}
				};
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_DashFront( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.com_dash = 1,00000000.0;
			this.input.b4 = 3;
			this.input.x = this.direction;

			if (this.motion == 40 || this.motion == 42)
			{
				this.com_stackState[0].state = function ( t_ )
				{
					this.com_stackCount--;

					if (this.com_stackCount <= 0)
					{
						return true;
					}

					this.com_dash = 1,00000000.0;
					this.input.b4 = 3;
					this.input.x = this.direction;
				};
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_DashFront_Near( x_, wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.wait <- wait_;
	tab_.table.x <- x_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = t_.x;
		this.com_stackState[0].state = function ( t_ )
		{
			this.com_dash = 1,00000000.0;
			this.input.b4 = 3;
			this.input.x = this.direction;

			if (this.motion == 40 || this.motion == 42)
			{
				this.com_stackState[0].state = function ( t_ )
				{
					this.com_stackCount--;

					if (this.com_stackCount <= 0)
					{
						this.ComStack_Clear();
						return;
					}

					if (this.abs(this.targetDist) <= this.com_stackFlag)
					{
						return true;
					}

					this.com_dash = 1,00000000.0;
					this.input.b4 = 3;
					this.input.x = this.direction;
				};
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_DashBack( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_rand[2] = this.rand() % 10;
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.com_dash = -1,00000000.0;
			this.input.b4 = 3;
			this.input.x = -this.direction;

			if (this.motion == 41 || this.motion == 43)
			{
				this.com_stackState[0].state = function ( t_ )
				{
					this.com_stackCount--;

					if (this.com_stackCount <= 0)
					{
						return true;
					}

					this.com_dash = -1,00000000.0;
					this.input.b4 = 3;
					this.input.x = -this.direction;
				};
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_NA( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k0 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_FrontA( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k0 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = this.direction;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_UpperA( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k0 = 3;
			this.command.rsv_y = -1;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_UnderA( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k0 = 3;
			this.command.rsv_y = 1;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_NB( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k1 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_FrontB( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k1 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = this.direction;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_UpperB( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k1 = 3;
			this.command.rsv_y = -3;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_UnderB( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k1 = 3;
			this.command.rsv_y = 3;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_ChargeShot( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.input.b1 = 15;
			this.input.x = -this.direction;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_NC( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k2 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_BackC( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k2 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = -this.direction;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_FrontC( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k2 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = this.direction;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_UpperC( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k2 = 3;
			this.command.rsv_y = -3;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_UnderC( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			this.command.rsv_k2 = 3;
			this.command.rsv_y = 3;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Push_D( x_, y_, wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.key <- this.Vector3();
	tab_.table.key.x = x_;
	tab_.table.key.y = y_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = this.Vector3();
		this.com_stackFlag.x = t_.key.x;
		this.com_stackFlag.y = t_.key.y;
		this.com_stackState[0].state = function ( t_ )
		{
			this.input.b4 = 3;
			this.input.x = this.com_stackFlag.x;
			this.input.y = this.com_stackFlag.y;
			this.command.ban_slide = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Hyoui( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.team.op_stop > 0 || this.team.slave_ban > 0)
			{
				this.ComStack_Clear();
				return;
			}

			this.command.rsv_k3 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = 0;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				this.ComStack_Clear();
				return;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Atk_Hyoui( wait_ )
{
	local tab_ = {};
	tab_.table <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.team.op_stop > 0 || this.team.slave_ban > 0 || this.team.op < 1000)
			{
				this.ComStack_Clear();
				return;
			}

			this.command.rsv_k3 = 3;
			this.command.rsv_y = 0;
			this.command.rsv_x = this.direction;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_Occult( x_, y_, wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table <- {};
	tab_.table.key <- this.Vector3();
	tab_.table.key.x = x_;
	tab_.table.key.y = y_;
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackFlag = this.Vector3();
		this.com_stackFlag.x = t_.key.x;
		this.com_stackFlag.y = t_.key.y;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.team.op_stop > 0)
			{
				this.ComStack_Clear();
				return;
			}

			this.command.rsv_k01 = 3;
			this.command.rsv_y = this.com_stackFlag.y;
			this.command.rsv_x = this.com_stackFlag.x;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_SpellCall( wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.team.spell_active || this.team.op < this.team.sp_max)
			{
				this.ComStack_Clear();
				return;
			}

			this.command.rsv_k12 = 3;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_SpellUse( wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackState[0].state = function ( t_ )
		{
			if (!this.team.spell_active)
			{
				this.ComStack_Clear();
				return;
			}

			this.command.rsv_k12 = 3;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

function ComStack_LastWord( wait_ )
{
	local tab_ = {};
	tab_.table <- {};
	tab_.table.wait <- wait_;
	tab_.state <- function ( t_ )
	{
		this.com_stackCount = t_.wait;
		this.com_stackState[0].state = function ( t_ )
		{
			if (this.team.op < 2000 && this.team.op_stop > 0 && this.team.sp < this.team.sp_max2)
			{
				this.ComStack_Clear();
				return;
			}

			this.command.rsv_k23 = 3;
			this.com_stackCount--;

			if (this.com_stackCount <= 0)
			{
				return true;
			}
		};
	};
	this.com_stackState.append(tab_);
}

