function SetInput_Player( input_ )
{
	if (input_)
	{
		this.input = input_;
		this.command = this.InputCommand(input_);
		this.input.Clear();
	}
}

