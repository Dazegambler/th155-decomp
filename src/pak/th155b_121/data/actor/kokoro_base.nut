function EndtoFreeMove()
{
	if (this.FreeReset())
	{
		return true;
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		this.Stand_Init(null);
	}
	else if (this.y > this.centerY)
	{
		if (this.va.y > 6.00000000)
		{
			this.Fall_Init(null);
		}
		else
		{
			this.Up_Init(null);
		}
	}
	else if (this.va.y < -6.00000000)
	{
		this.Up_Init(null);
	}
	else
	{
		this.Fall_Init(null);
	}

	if (::battle.state == 8)
	{
		if (!this.cpuState && this.command)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}

		this.Update_Input();
	}

	this.SummonMask();
}

local func_ = this.GetDamageReset;
function GetDamageReset()
{
	this.DamageMask();
	func_();
}

function ChangeEmotion( type_ )
{
	if (type_ == this.emotion && type_ >= 0)
	{
		return false;
	}

	if (type_ >= 0)
	{
		local t_ = {};
		t_.keyTake <- type_;
		this.SetFreeObject(this.x, this.y, 1.00000000, this.EmotionChange_Aura, t_);
	}

	switch(type_)
	{
	case 1:
		this.uv.SetMotion(9902, 0);
		this.emotion = 1;

		if (this.spellA_Aura)
		{
			this.spellA_Aura.func[1].call(this.spellA_Aura);
		}

		return true;
		break;

	case 0:
		this.uv.SetMotion(9901, 0);
		this.emotion = 0;

		if (this.spellA_Aura)
		{
			this.spellA_Aura.func[1].call(this.spellA_Aura);
		}

		return true;
		break;

	case 2:
		this.uv.SetMotion(9903, 0);
		this.emotion = 2;

		if (this.spellA_Aura)
		{
			this.spellA_Aura.func[1].call(this.spellA_Aura);
		}

		return true;
		break;

	default:
		this.uv.SetMotion(9900, 0);
		this.emotion = -1;
		return true;
		break;
	}

	return false;
}

function SummonMask()
{
	if (this.isVisible && this.mask == null && this.team.current == this)
	{
		this.mask = [];

		for( local i = 0; i < 3; i++ )
		{
			local t_ = {};
			t_.type <- i;
			t_.rot <- 120 * i * 0.01745329;
			this.mask.append(this.SetShot(this.x, this.y, this.direction, this.MaskObject, t_).weakref());
		}
	}
}

function DamageMask()
{
	if (this.mask && this.mask.len() > 0)
	{
		foreach( a in this.mask )
		{
			if (a)
			{
				a.func[0].call(a);
			}
		}
	}

	this.mask = null;
}

function ClearMask()
{
	if (this.mask && this.mask.len() > 0)
	{
		foreach( a in this.mask )
		{
			a.ReleaseActor();
		}
	}

	this.mask = null;
}

function Update_Normal()
{
	if (!this.MainLoopFirst())
	{
		if (this.IsDamage())
		{
			if (this.stateLabel)
			{
				this.stateLabel();
			}

			return true;
		}
		else
		{
			return false;
		}
	}

	this.maskRot += 2.00000000 * 0.01745329;
	this.maskYaw += 0.01745329;
	this.maskPitch += 0.33000001 * 0.01745329;
	this.uv_count++;
	local mat = ::manbow.Matrix();
	mat.SetTranslation(this.x * this.direction / 2 + this.uv_count * 0.20000000 % 1024, 64, 0);
	this.uv.SetWorldTransform(mat);

	if (this.mask == null && this.IsFree())
	{
		this.SummonMask();
	}

	if (::battle.state == 8)
	{
		if (this.cpuState)
		{
			this.cpuState();
		}

		if (this.input && this.team.current == this)
		{
			this.Update_Input();
		}
	}

	this.MainLoop();
	return true;
}

function Update_Input()
{
	if (this.command_change())
	{
		return true;
	}

	if (this.team.op >= 1000 && this.team.op_stop == 0 && this.command.rsv_k01 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.faceMask)
			{
				this.Okult_Init(null);
				this.command.ResetReserve();
				return true;
			}
			else if (this.centerStop * this.centerStop <= 1)
			{
				this.Okult_InitB(null);
			}
			else
			{
				this.Okult_InitB_Air(null);
			}
		}
	}

	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				this.SP_F_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				this.SP_E_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				this.SP_A_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				local t_ = {};
				t_.rush <- false;
				this.SP_B_Init(t_);
				this.command.ResetReserve();
				return true;
			}

			if (!this.command.rsv_x)
			{
				this.SP_D_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1 && this.target.centerStop * this.target.centerStop <= 1 && this.abs(this.target.x - this.x) <= 90)
	{
		if (this.team.current.target.invinGrab == 0 && !(this.target.flagState & 8192) && !this.target.IsDamage())
		{
			if (this.Cancel_Check(1))
			{
				this.Atk_Grab_Init(null);
				return true;
			}
		}
	}

	if (this.Input_CommonAttack())
	{
		return true;
	}

	this.InputMove();
}

function TeamSkillChain_Input( input_ )
{
	if (input_.command.rsv_y < 0)
	{
		this.SummonMask();
		this.SP_F_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0)
	{
		this.SummonMask();
		this.SP_E_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction > 0)
	{
		this.SummonMask();
		this.SP_A_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction < 0)
	{
		this.SummonMask();
		local t_ = {};
		t_.rush <- false;
		this.SP_B_Init(t_);
		this.command.ResetReserve();
		return true;
	}

	if (!input_.command.rsv_x)
	{
		this.SummonMask();
		this.SP_D_Init(null);
		this.command.ResetReserve();
		return true;
	}

	return false;
}

