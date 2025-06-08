function GetVersion()
{
	return 1551211;
}

function GetReplayVersion()
{
	return 1551210;
}

this.current_version <- ::manbow.GetPrivateProfileString("updater", "version", "0", "config.ini").tointeger();
function GetUpdaterVersion()
{
	return this.current_version;
}

function GetVersionString()
{
	return "Ver1.21b";
}

function GetVersionSignature()
{
	return "1_21b";
}

::SetWindowText("“Œ•\x221aœ\x2580ˆ\x2566‰\x256a@` Antinomy of Common Flowers. " + this.GetVersionString());
