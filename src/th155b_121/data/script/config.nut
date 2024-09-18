this.version <- this.GetVersion();
this.lang <- 0;
this.graphics <- {};
this.graphics.fullscreen <- 0;
this.graphics.vsync <- 1;
this.graphics.fps <- 1;
this.graphics.background <- 0;
this.input <- {};
this.input.key <- [
	{},
	{}
];
this.input.pad <- [
	{},
	{}
];

for( local i = 0; i < 2; i = ++i )
{
	local d = this.input.key[i];
	d.up <- 200;
	d.down <- 208;
	d.left <- 203;
	d.right <- 205;
	d.b0 <- 44;
	d.b1 <- 45;
	d.b2 <- 46;
	d.b3 <- 30;
	d.b4 <- 31;
	d.b10 <- 1;
	d.t0 <- -2;
	d.t1 <- -2;
	d.t2 <- -2;
	d = this.input.pad[i];
	d.up <- 516;
	d.down <- 513;
	d.left <- 515;
	d.right <- 512;
	d.b0 <- 0;
	d.b1 <- 1;
	d.b2 <- 2;
	d.b3 <- 3;
	d.b4 <- 4;
	d.b10 <- 5;
	d.t0 <- -2;
	d.t1 <- -2;
	d.t2 <- -2;
}

this.sound <- {};
this.sound.se <- 50;
this.sound.bgm <- 50;
this.network <- {};
this.network.hosting_port <- 10800;
this.network.target_host <- "127.0.0.1";
this.network.target_port <- 10800;
this.network.lobby_name <- "";
this.network.upnp <- false;
this.network.allow_watch <- true;
this.network.player_name <- "";
this.replay <- {};
this.replay.version_dir <- false;
this.replay.daily_dir <- false;
this.replay.save_mode <- 1;
this.replay.save_mode_online <- 1;
this.practice <- {};
this.practice.position <- [
	0,
	0
];
this.practice.life <- [
	5,
	5
];
this.practice.regain <- [
	5,
	5
];
this.practice.mp <- [
	6,
	6
];
this.practice.op <- [
	5,
	5
];
this.practice.sp <- [
	3,
	3
];
this.practice.guard <- [
	6,
	6
];
this.practice.master <- [
	{},
	{}
];
this.practice.slave <- [
	{},
	{}
];
this.practice.marisa <- [
	0,
	0
];
this.practice.hijiri <- [
	0,
	0
];
this.practice.futo <- [
	0,
	0
];
this.practice.miko <- [
	0,
	0
];
this.practice.mamizou <- [
	0,
	0
];
this.practice.kokoro <- [
	0,
	0
];
this.practice.udonge <- [
	0,
	0
];
this.practice.doremy <- [
	0,
	0
];
this.practice.player2 <- 0;
this.practice.difficulty <- 0;
this.practice.counter_mode <- 0;
this.practice.guard_mode <- 0;
this.practice.ex_guard_mode <- 0;
this.practice.recover_mode <- 0;
this.practice.slave_2p <- 0;
this.practice.macro_index <- 0;
this.difficulty <- {};
this.difficulty.story <- 1;
this.difficulty.vs <- 1;
function Initialize()
{
}

function Save()
{
	return ::manbow.SaveTable("system.dat", this);
}

function Load()
{
	if (::manbow.LoadTableEx("system.dat", this, false))
	{
		return;
	}

	return;
}

function Apply()
{
	::sound.SetVolumeSE(this.sound.se / 100.00000000);
	::sound.SetVolumeBGM(this.sound.bgm / 100.00000000);
	::SetWindowMode(0, 0, this.graphics.fullscreen, this.graphics.vsync, false);
}


if (!this.Load())
{
	this.Save();
}
