functor
import
	Application
	Browser
	List
	System
define
	fun {Factorial Number}
		if Number == 0 then 1
		else Number * {Factorial Number - 1} end
	end

	proc {PrintLines NumberOfLines}
		if NumberOfLines == 0 then skip
		else
			{System.showInfo 'woot'}
			{PrintLines NumberOfLines - 1}
		end
	end

	{PrintLines 10}
	{System.showInfo {Factorial 100}}
	{Application.exit 0}
end
