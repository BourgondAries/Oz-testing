functor
import
	Application
	Browser
	List
	System
define
	fun {Factorial Number}
		{Delay 100}
		if Number == 0 then 1
		else Number * {Factorial Number - 1} end
	end

	proc {PrintLines NumberOfLines}
		if NumberOfLines == 0 then skip
		else
			{System.showInfo 'woot'}
			{Delay 400}
			{PrintLines NumberOfLines - 1}
		end
	end

	thread {PrintLines 10} end
	thread {System.showInfo {Factorial 100}} end

	%% {Application.exit 0}
end
