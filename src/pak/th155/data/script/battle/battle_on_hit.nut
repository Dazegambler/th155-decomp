this.hit_effect <- [
	::actor.effect_class.EF_HitSmashA,
	::actor.effect_class.EF_HitSmashB,
	::actor.effect_class.EF_HitSmashC,
	::actor.effect_class.EF_HitSmashUpper,
	::actor.effect_class.EF_HitSmashFront,
	::actor.effect_class.EF_HitSmashUnder
];
class this.TempActorData 
{
	direction = 0.00000000;
	attackLV = 0;
	cancelCount = 0;
	atk_id = 0;
	disableGuard = false;
}

function ContactTest()
{
	if (!this.enable_contact_test)
	{
		return;
	}

	this.temp_actor_data_index = 0;
	this.CalcContactTestParam();
	this.group_player.CacheContactTest();
	this.group_player.ContactTest(1, 2, this, this.OnHit_PlayerActor);
	this.group_player.ContactTest(2, 1, this, this.OnHit_PlayerActor);
	this.group_player.ContactTest(1, 8192 | 131072 | 16384 | 262144 | 524288, this, this.OnHit_NormalActor);
	this.group_player.ContactTest(2, 4096 | 65536 | 16384 | 262144 | 32768, this, this.OnHit_NormalActor);
	this.group_player.ContactTest(16 | 65536 | 4096, 2, this, this.OnHit_PlayerActor);
	this.group_player.ContactTest(32 | 131072 | 8192, 1, this, this.OnHit_PlayerActor);
	this.group_player.ContactTest(64 | 262144 | 16384, 1 | 2, this, this.OnHit_PlayerActor);
	this.group_player.ContactTest(16 | 65536 | 4096, 524288 | 8192 | 16384, this, this.OnHit_NormalActor);
	this.group_player.ContactTest(32 | 131072 | 8192, 32768 | 4096 | 16384, this, this.OnHit_NormalActor);
	this.group_player.ContactTest(64 | 262144 | 16384, 4096 | 8192, this, this.OnHit_NormalActor);
	this.group_player.ContactTest(16 | 65536, 8 | 32 | 131072 | 64 | 262144, this, this.OnHit_ShotActor);
	this.group_player.ContactTest(32 | 131072, 128 | 16 | 65536 | 64 | 262144, this, this.OnHit_ShotActor);
	this.group_player.ContactTest(64 | 262144, 16 | 65536 | 32 | 131072, this, this.OnHit_ShotActor);
	this.group_player.ContactTest(256, 1024, this, this.OnHit_CheckActor);
	this.group_player.ContactTest(512, 2048, this, this.OnHit_CheckActor);
	this.group_player.Refresh();
}

function CalcContactTestParam()
{
	foreach( v in this.team )
	{
		v.current.CalcContactTestParam();
	}
}

function OnHit_PlayerActor( atk, def, pos )
{
	if (def != def.team.current)
	{
		return;
	}

	if ((atk.attack_state & def.hit_state) != atk.attack_state)
	{
		return;
	}

	if (def.attackTarget && def.attackTarget != atk || atk.attackTarget && atk.attackTarget != def)
	{
		return;
	}

	if (def.team.master.id in atk.hitOwner.hitTarget)
	{
		return;
	}

	atk.hitOwner.hitTarget[def.team.master.id] <- 0;

	if (atk.atkOwner)
	{
		def.damageTarget = atk.atkOwner.weakref();
	}
	else
	{
		def.damageTarget = atk.weakref();
	}

	if (atk.actorType == 1)
	{
		atk.DrawActorPriority(atk.drawPriority);
	}

	this.HitPlayer(atk, def, pos);
}

function OnHit_NormalActor( atk, def, pos )
{
	if (!this.OnHit_CommonHitCheck(atk, def))
	{
		return;
	}

	this.HitActor(atk, def, pos);
}

function OnHit_ShotActor( atk, def, pos )
{
	if (!this.OnHit_CommonHitCheck(atk, def))
	{
		return;
	}

	this.ShotCounter(atk, def, pos);
}

function OnHit_CheckActor( atk, def, info )
{
	if (atk.attackTarget && atk.attackTarget != def)
	{
		return false;
	}

	if (def.id in atk.hitOwner.hitTarget)
	{
		return;
	}

	atk.hitOwner.hitTarget[def.id] <- 0;

	if (atk.atkOwner)
	{
		def.damageTarget = atk.atkOwner.weakref();
	}
	else
	{
		def.damageTarget = atk.weakref();
	}

	atk.hitOwner.hitResult = atk.hitOwner.hitResult | 512;
	return true;
}

function OnHit_CommonHitCheck( atk, def )
{
	if (atk.attackTarget && atk.attackTarget != def)
	{
		return false;
	}

	if (def.id in atk.hitOwner.hitTarget)
	{
		return;
	}

	atk.hitOwner.hitTarget[def.id] <- 0;

	if (atk.atkOwner)
	{
		def.damageTarget = atk.atkOwner.weakref();
	}
	else
	{
		def.damageTarget = atk.weakref();
	}

	return true;
}

function SetHitState( t, atk_, def_ )
{
	if (atk_.temp_frame_data.flagAttack & 4194304)
	{
		t.direction <- -atk_.temp_atk_data.direction;
	}
	else if (atk_.owner.x == def_.x)
	{
		t.direction <- def_.temp_atk_data.direction;
	}
	else
	{
		t.direction <- atk_.owner.x > def_.x ? 1.00000000 : -1.00000000;
	}

	if (atk_.actorType & (1 | 4))
	{
		t.knockFlag <- 1;
	}
	else if (atk_.actorType & 2)
	{
		t.knockFlag <- 2;
	}
	else
	{
		t.knockFlag <- 0;
	}

	t.atk <- atk_.weakref();
	t.spellAttack <- atk_.temp_frame_data.flagAttack & 512;
	t.damage <- 0;
	t.atkRank <- atk_.temp_frame_data.atkRank;
	t.atkType <- atk_.temp_frame_data.atkType;
	t.hitVecX <- atk_.temp_frame_data.hitVecX * 0.01000000;
	t.hitVecY <- atk_.temp_frame_data.hitVecY * 0.01000000;
	t.grazeKnock <- atk_.temp_frame_data.grazeKnock * 0.01000000;
	t.stopVecX <- atk_.temp_frame_data.stopVecX * 0.01000000;
	t.stopVecY <- atk_.temp_frame_data.stopVecY * 0.01000000;
	t.recover <- atk_.temp_frame_data.recover;
	t.forceKnock <- atk_.temp_frame_data.flagAttack & 2097152;
	t.bariaBreak <- atk_.temp_frame_data.flagAttack & 524288;
}

function HitPlayer( atk, def, pos )
{
	if (atk.attack_state & def.catch_state)
	{
		if (atk.attack_state & 1)
		{
			atk.hitOwner.hitResult = atk.hitOwner.hitResult | 16;
			def.hitOwner.hitResult = def.hitOwner.hitResult | 16;
			return;
		}

		if (atk.temp_frame_data.flagAttack & 16384)
		{
			atk.hitOwner.hitResult = atk.hitOwner.hitResult | 256;
			def.hitOwner.hitResult = def.hitOwner.hitResult | 256;
			return;
		}
	}

	if (atk.attack_state & def.graze_state && (atk.temp_frame_data.flagAttack & 65536) == 0)
	{
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 32;
		atk.hitOwner.grazeCount++;
		this.PlaySE(803);
		::effect.Create(1006, pos, null, ::graphics.slot.actor, 200, 4096);
		return;
	}

	if (def.team.combo_stun >= 100 && (atk.temp_frame_data.flagAttack & 512) == 0)
	{
		return;
	}

	if (def.layerSwitch)
	{
		def.layerSwitch = false;
		atk.owner.layerSwitch = true;
		atk.owner.ConnectRenderSlot(::graphics.slot.actor, 190);
	}

	atk.hitOwner.hitCount++;
	local guard_result = def.guard_state;

	if (!(atk.temp_frame_data.flagAttack & 2 + 4))
	{
		guard_result = 0;
	}

	if (guard_result)
	{
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 8;
		def.damageStopTime = atk.guardStopE;
		atk.hitOwner.hitStopTime = atk.guardStopP;

		if (atk.hitOwner)
		{
			atk.hitOwner.hitStopTime = atk.temp_frame_data.guardStopP;
		}

		if (atk.guardDamage > 0)
		{
			local gf_ = def.team.GetGutsRate();
			gf_ = gf_ * atk.owner.atkRate;
			gf_ = gf_ * atk.atkRate_Pat;
			def.team.SetDamage(atk.guardDamage * gf_, true);
		}

		atk.team.AddSP(atk.addSP * 0.33000001);

		if (atk.guardLost > 0)
		{
			if (def.team.current == def.team.master)
			{
				local gf_ = def.team.GetGutsRate();
				gf_ = gf_ * atk.owner.atkRate;
				gf_ = gf_ * atk.atkRate_Pat;
				def.team.SetDamage_FullRegain(atk.temp_frame_data.damagePoint * 0.25000000, true);
			}
			else
			{
				def.team.AddOP(-atk.guardLost, 0);
			}
		}

		local t = {};
		this.SetHitState(t, atk, def);
		this.GuardCrash_Check(atk, def, t, guard_result, pos);
		return;
	}

	if (atk.temp_frame_data.atkType == 0)
	{
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 1;
		def.damageStopTime = atk.temp_frame_data.hitStopE;
		atk.hitStopTime = atk.temp_frame_data.hitStopP;
		atk.hitOwner.hitStopTime = atk.temp_frame_data.hitStopP;
		return;
	}

	local Knock_ = atk.temp_frame_data.addKnock;
	local KnockCheck_ = false;
	local rate_ = 1.00000000;
	local t = {};
	this.SetHitState(t, atk, def);

	if (def.temp_frame_data.flagState & 1048576)
	{
		Knock_ = Knock_ / 2;
	}

	if (def.temp_frame_data.flagState & 2097152 || def.armor)
	{
		if (atk.group & 15)
		{
			if (atk.x == def.x)
			{
				atk.vfBaria.x = -15.00000000 * atk.direction;
			}
			else if (atk.x > def.x)
			{
				atk.vfBaria.x = 15.00000000;
			}
			else
			{
				atk.vfBaria.x = -15.00000000;
			}
		}

		Knock_ = 0;
	}

	if (Knock_ > 0 && def.IsDamage())
	{
		def.endure = def.endureMax;
	}
	else
	{
		def.endure += Knock_ * 2;
		def.endureCount = 120;
	}

	if (def.endure >= def.endureMax)
	{
		KnockCheck_ = true;
	}

	if (atk.temp_frame_data.flagAttack & (128 | 64) && def.team.combo_count <= 0)
	{
		if (def.temp_frame_data.flagState & 256 || atk.temp_frame_data.flagAttack & 64 || def.force_counter)
		{
			if (atk.temp_frame_data.atkRank <= 1)
			{
				def.team.counter_scale += 0.10000000;
			}
			else
			{
				def.team.counter_scale += 0.20000000;
			}

			atk.SetEffect(pos.x, pos.y, t.direction, ::actor.effect_class.EF_Counter, {});
		}
	}

	def.damageStopTime = atk.temp_frame_data.hitStopE;
	atk.hitStopTime = atk.temp_frame_data.hitStopP;

	if (atk.hitOwner)
	{
		atk.hitOwner.hitStopTime = atk.temp_frame_data.hitStopP;
	}

	if (atk.temp_frame_data.hitSE)
	{
		::PlaySE(atk.temp_frame_data.hitSE);
	}

	if (atk.hitEffect <= 5)
	{
		::effect.Create(atk.hitEffect + 1000, pos, null, ::graphics.slot.actor, 200, 4096);
	}

	local _min_scale = 0.10000000;

	if (atk.temp_frame_data.flagAttack & 256)
	{
		_min_scale = 0.20000000;
	}

	if (atk.temp_frame_data.flagAttack & 512)
	{
		_min_scale = 0.25000000;
	}

	local dam_ = 0;

	if (def.temp_frame_data.flagState & 2097152 || def.armor)
	{
		dam_ = def.team.SetComboDamage(atk, atk.temp_frame_data.damagePoint / 2, _min_scale, atk.temp_frame_data.flagAttack & 1048576);
	}
	else
	{
		dam_ = def.team.SetComboDamage(atk, atk.temp_frame_data.damagePoint, _min_scale, atk.temp_frame_data.flagAttack & 1048576);
	}

	if (atk.temp_frame_data.flagAttack & 2097152)
	{
		def.SetRecoverFrame(-atk.temp_frame_data.recover);
	}
	else
	{
		def.SetRecoverFrame(atk.temp_frame_data.recover);
	}

	if (def.team.combo_count == 0)
	{
		def.minRate = 1.00000000;
		def.team.SetDamageScale(atk.temp_frame_data.firstRate * 0.00100000);
	}
	else
	{
		def.team.SetDamageScale(atk.temp_frame_data.comboRate * 0.00100000);
	}

	if (!((def.temp_frame_data.flagState & 2097152 || def.armor) && def.team.life > 0))
	{
		if (def.team.combo_stun < 100 && def.team.combo_stun + atk.temp_frame_data.addStan >= 100)
		{
			local t_ = {};
			t_.num <- 3;
			local dam_ = def.team.combo_damage;

			while (dam_ > 0)
			{
				if (dam_ >= 5000)
				{
					dam_ = dam_ - 1000;
					t_.num++;
				}
				else if (dam_ >= 3000)
				{
					dam_ = dam_ - 500;
					t_.num++;
				}
				else if (dam_ >= 1000)
				{
					dam_ = dam_ - 250;
					t_.num++;
				}
				else
				{
					dam_ = 0;
					t_.num++;
				}
			}

			this.PlaySE(842);
			def.SetFreeObject(def.x, def.y, atk.direction, def.Occult_PowerCreatePoint, t_);
			atk.SetEffect(pos.x, pos.y, t.direction, ::actor.effect_class.EF_StanStar, t, def.weakref());
		}

		def.team.combo_stun += atk.temp_frame_data.addStan;

		if (def.team.combo_stun >= 100)
		{
			KnockCheck_ = true;
			def.team.combo_stun = 100;
			def.stanCount = 60;
		}
	}

	if (def.team.life <= 0)
	{
		KnockCheck_ = true;
	}

	atk.team.AddSP(atk.temp_frame_data.addSP);
	def.team.AddSP(dam_ * 0.10000000);

	if (KnockCheck_)
	{
		if (atk.temp_atk_data.atk_id > 0)
		{
			if (!(atk.temp_atk_data.atk_id & atk.owner.hit_id))
			{
				atk.owner.hit_id = atk.owner.hit_id | atk.temp_atk_data.atk_id;
				local t_ = {};
				t_.num <- 5;
				def.SetFreeObject(def.x, def.y, 1.00000000, def.Occult_PowerCreatePoint, t_);
			}
			else
			{
				local t_ = {};
				t_.num <- 1;
				def.SetFreeObject(def.x, def.y, 1.00000000, def.Occult_PowerCreatePoint, t_);
			}
		}

		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 1;

		if (atk.flagAttack & 33554432)
		{
			def.invinBoss = 600;
			def.hit_state = 0;
		}

		def.baria = false;
		def.team.combo_reset_count = 0;
		def.endure = 0;

		if (def.hitAction)
		{
			local t = {};
			this.SetHitState(t, atk, def);
			t.damage = dam_;
			def.hitAction(t);
		}
	}
	else
	{
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 4;

		if (atk.flagAttack & 33554432)
		{
			def.invinBoss = 600;
		}

		def.team.combo_reset_count = 30;

		if (atk.temp_frame_data.atkType == 23)
		{
			local t = {};
			this.SetHitState(t, atk, def);
			def.DamageBullet_Init(t);
		}

		if (def.armorEvent)
		{
			def.armorEvent();
		}
	}
}

function HitActor( atk, def, pos )
{
	local t = {};
	this.SetHitState(t, atk, def);

	if (atk.temp_frame_data.hitSE)
	{
		this.PlaySE(atk.temp_frame_data.hitSE);
	}

	if (atk.hitEffect <= 5)
	{
		::effect.Create(atk.hitEffect + 1000, pos, null, ::graphics.slot.actor, 200, 4096);
	}

	local dam_ = def.SetComboDamage(atk, atk.temp_frame_data.damagePoint);

	if (def.hitAction)
	{
		t.damage = dam_;
		def.hitAction(t);
	}

	atk.hitOwner.hitResult = atk.hitOwner.hitResult | 2;
	atk.hitOwner.hitCount++;
}

function ShotCounter( atk, def, pos )
{
	if (atk.temp_atk_data.attackLV == 0 || def.temp_atk_data.attackLV == 0)
	{
		return;
	}

	if (atk.hitOwner.cancelCount <= 0 || def.hitOwner.cancelCount <= 0)
	{
		return;
	}

	if (atk.temp_atk_data.attackLV == def.temp_atk_data.attackLV)
	{
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 128;
		def.hitOwner.hitResult = def.hitOwner.hitResult | 128;
		local ac_ = atk.hitOwner.cancelCount;
		local dc_ = def.hitOwner.cancelCount;
		atk.hitOwner.cancelCount -= dc_;
		def.hitOwner.cancelCount -= ac_;
		return;
	}

	if (atk.temp_atk_data.attackLV > def.temp_atk_data.attackLV)
	{
		def.hitOwner.cancelCount = 0;
		def.hitOwner.hitResult = def.hitOwner.hitResult | 128;
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 64;
	}
	else
	{
		atk.hitOwner.cancelCount = 0;
		atk.hitOwner.hitResult = atk.hitOwner.hitResult | 128;
		def.hitOwner.hitResult = def.hitOwner.hitResult | 64;
	}
}

this.GuardCrash_Check <- null;
function GuardCrash_Check_VS( atk, def, t, guard_result, pos )
{
	if (def == def.team.slave && def.team.op <= 0 && (atk.guardLost >= 1 || atk.temp_frame_data.flagAttack & 524288))
	{
		if (def.guardCrashAction)
		{
			def.GuardCrash_Param();
			def.guardCrashAction.call(def, t);
			def.temp_atk_data.disableGuard = true;
		}
	}
	else
	{
		switch(guard_result)
		{
		case 1:
			if (def.guardEffect)
			{
				def.guardEffect.Release();
			}

			def.guardEffect = atk.SetEffect(pos.x, pos.y, t.direction, ::actor.effect_class.EF_Guard, {}).weakref();

			if (def.guardAction)
			{
				def.guardAction.call(def, t);
			}

			break;

		case 2:
			if (def.guardEffect)
			{
				def.guardEffect.Release();
			}

			def.guardEffect = atk.SetEffect(pos.x, pos.y, t.direction, ::actor.effect_class.EF_Guard, {}).weakref();
			break;
		}
	}
}

function GuardCrash_Check_Story( atk, def, t, guard_result, pos )
{
	if (def == def.team.master && def.team.life == 1 && def.team.regain_life == 1 && (atk.guardLost >= 1 || atk.temp_frame_data.flagAttack & 524288))
	{
		if (def.guardCrashAction)
		{
			def.GuardCrash_Param();
			def.guardCrashAction.call(def, t);
			def.temp_atk_data.disableGuard = true;
		}
	}
	else if (def == def.team.slave && def.team.op <= 0 && (atk.guardLost >= 1 || atk.temp_frame_data.flagAttack & 524288))
	{
		if (def.guardCrashAction)
		{
			def.GuardCrash_Param();
			def.guardCrashAction.call(def, t);
			def.temp_atk_data.disableGuard = true;
		}
	}
	else
	{
		switch(guard_result)
		{
		case 1:
			if (def.guardEffect)
			{
				def.guardEffect.Release();
			}

			def.guardEffect = atk.SetEffect(pos.x, pos.y, t.direction, ::actor.effect_class.EF_Guard, {}).weakref();

			if (def.guardAction)
			{
				def.guardAction.call(def, t);
			}

			break;

		case 2:
			if (def.guardEffect)
			{
				def.guardEffect.Release();
			}

			def.guardEffect = atk.SetEffect(pos.x, pos.y, t.direction, ::actor.effect_class.EF_Guard, {}).weakref();
			break;
		}
	}
}

