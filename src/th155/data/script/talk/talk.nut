this.font <- ::manbow.FontTexture();
this.font.Load("data/font/talk_font.bmp");
::manbow.CompileFile("data/script/talk/talk_command.nut", this);
::manbow.CompileFile("data/script/talk/talk_image.nut", this);
::manbow.CompileFile("data/script/talk/talk_character.nut", this);
::manbow.CompileFile("data/script/talk/talk_text.nut", this);
::manbow.CompileFile("data/script/talk/talk_balloon.nut", this);
::manbow.CompileFile("data/script/talk/talk_command_ex.nut", this);
::manbow.CompileFile("data/script/talk/talk_generate.nut", this);
this.command_line <- [];
this.current_line <- 0;
this.sync_task <- [];
this.async_task <- {};
this.sub_stack <- [];
this.object_list <- {};
this.current_obj <- null;
this.group <- {};
this.default_balloon <- "a05x2";
this.message <- null;
this.message_flush <- false;
this.is_active <- false;
function Load( filename )
{
	this.command_line = ::manbow.LoadCSV(filename);
	return this.command_line != null;
}

function Clear()
{
	this.End();
	this.current_line = 0;
	this.command_line.resize(0);
}

function Begin( _label )
{
	this.is_active = true;
	local label = ":" + _label;

	foreach( i, v in this.command_line )
	{
		if (v.len() && v[0] == label)
		{
			this.current_line = i;
			::battle.AddTask(this);
			return;
		}
	}
}

function End( arg = null )
{
	this.sync_task.resize(0);
	this.async_task = {};
	this.take_data = {};
	this.object_list = {};
	this.current_obj = null;
	this.message = null;
	this.group = {};
	this.is_active = false;
	::battle.DeleteTask(this);
	return true;
}

function Update()
{
	::input_talk.Update();

	foreach( i, v in this.async_task )
	{
		if (v.getstatus() == "idle")
		{
			delete this.async_task[i];
			continue;
		}

		v.wakeup();
	}

	if (this.sync_task.len() > 0)
	{
		this.sync_task[0].wakeup();

		if (this.sync_task[0].getstatus() == "idle")
		{
			this.sync_task.remove(0);
		}

		return;
	}

	while (this.current_line < this.command_line.len())
	{
		if (this.Perse(this.command_line[this.current_line++]))
		{
			break;
		}
	}
}

function Perse( line )
{
	if (line.len() == 0)
	{
		return false;
	}

	local head = line[0];

	if (head.len() >= 1 && head[0] == 58)
	{
		return false;
	}

	if (line.len() > 1 && line[0] == "")
	{
		if (line[1] in this)
		{
			return this[line[1]].call(this, line);
		}
		else
		{
		}
	}
	else
	{
		return this.Message(line);
	}

	if (line[line.len() - 1] == "&")
	{
		return false;
	}

	return true;
}

