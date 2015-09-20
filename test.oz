functor
import
	Application
	Browser
	System
define
	/* Task 2 */
	fun {StreamMap S F}
		case S of S1|S0 then
			{F S1}|{StreamMap S0 F}
		else
			nil
		end
	end

	A = {StreamMap 1|2|3 fun {$ Num} Num * 2 end}
	{System.showInfo {Nth A 2}}
	{Application.exit 0}
end
